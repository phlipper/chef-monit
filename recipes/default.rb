#
# Cookbook Name:: monit
# Recipe:: default
#

if node['monit']['source_install']
  include_recipe 'monit::install_source'
else
  package 'monit' do
    version node['monit']['version'] if node['monit']['version']
  end
end

# optionally use encrypted mail credentials
encrypted_credentials = node["monit"]["mail"]["encrypted_credentials"]
if encrypted_credentials
  bag_name = node["monit"]["mail"]["encrypted_credentials_data_bag"]
  credentials = Chef::EncryptedDataBagItem.load(bag_name, encrypted_credentials)

  node.default["monit"]["mail"]["username"] = credentials["username"]
  node.default["monit"]["mail"]["password"] = credentials["password"]

  Chef::Log.info "Using encrpyted mail credentials: #{encrypted_credentials}"
end

# configuration file
template node["monit"]["main_config_path"] do
  owner  "root"
  group  "root"
  mode   "0600"
  source "monitrc.erb"
  notifies :reload, "service[monit]" if node["monit"]["reload_on_change"]
end

directory "/var/monit" do
  owner "root"
  group "root"
  mode  "0700"
end

# enable service startup
execute "enable-monit-startup" do
  command "/bin/sed -e s/startup=0/startup=1/ -e s/START=no/START=yes/ \
          -i /etc/default/monit"
  not_if "grep -e 'startup=1' -e 'START=yes' /etc/default/monit"
  only_if { platform_family?("debian") }
  notifies :restart, "service[monit]"
end

# system service
service "monit" do
  supports restart: true, start: true, reload: true
  action [:enable, :start]

  case node["platform_family"]
  when "rhel", "fedora", "suse"
    start_command   "/sbin/service monit start"
    restart_command "/sbin/service monit restart"
    reload_command  "monit reload"
  when "debian"
    start_command   "/usr/sbin/invoke-rc.d monit start"
    restart_command "/usr/sbin/invoke-rc.d monit restart"
    reload_command  "monit reload"
  end
end

# build default monitrc files
node["monit"]["default_monitrc_configs"].each do |conf|
  monit_monitrc conf do
    variables(category: "system")
    notifies :reload, "service[monit]"
  end
end
