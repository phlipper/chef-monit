#
# Cookbook Name:: monit
# Recipe:: default
#

package "monit"

# configuration file
template node["monit"]["main_config_path"] do
  owner  "root"
  group  "root"
  mode   "0700"
  source "monitrc.erb"
  notifies :reload, "service[monit]", :delayed
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
  service_name "monit"

  case node["platform_family"]
  when "rhel", "fedora", "suse"
    start_command "/sbin/service monit start"
    restart_command "/sbin/service monit restart"
    reload_command "monit reload"
  when "debian"
    start_command "/usr/sbin/invoke-rc.d monit start"
    restart_command "/usr/sbin/invoke-rc.d monit restart"
    reload_command "monit reload"
  end

  supports value_for_platform(
    "debian" => { "4.0" => [ :restart, :start, :reload ], "default" => [ :restart, :start, :reload ] },
    "ubuntu" => { "default" => [ :restart, :start, :reload ] },
    "redhat" => { "default" => [ :restart, :start, :reload ] },
    "centos" => { "default" => [ :restart, :start, :reload ] },
    "fedora" => { "default" => [ :restart, :start, :reload ] },
    "default" => { "default" => [:restart, :start, :reload ] }
  )

  action :enable
end

# build default monitrc files
node["monit"]["default_monitrc_configs"].each do |conf|
  monit_monitrc conf do
    variables(:category => "system")
    notifies :reload, "service[monit]", :delayed
  end
end
