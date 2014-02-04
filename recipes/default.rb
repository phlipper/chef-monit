#
# Cookbook Name:: monit
# Recipe:: default
#

package "monit"

# optionally use encrypted mail credentials
if smtp_provider = node["monit"]["mail"]["encrypted_credentials"]
  bag_name = node["monit"]["mail"]["encrypted_credentials_data_bag"]
  credentials = Chef::EncryptedDataBagItem.load(bag_name, smtp_provider)

  node.default["monit"]["mail"]["username"] = credentials["username"]
  node.default["monit"]["mail"]["password"] = credentials["password"]

  Chef::Log.info "Using encrpyted mail credentials: #{smtp_provider}"
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
  command "/bin/sed s/START=no/START=yes/ -i /etc/default/monit"
  not_if "grep 'START=yes' /etc/default/monit"
  only_if { platform_family?("debian") }
end

# system service
service "monit" do
  supports restart: true, start: true, reload: true
  action :enable

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
    notifies :reload, "service[monit]", :delayed
  end
end
