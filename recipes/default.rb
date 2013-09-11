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
  notifies :restart, "service[monit]", :delayed
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
  when "debian"
    start_command "/usr/sbin/invoke-rc.d monit start"
    restart_command "/usr/sbin/invoke-rc.d monit restart"
  end

  supports value_for_platform(
    "debian" => { "4.0" => [ :restart, :start ], "default" => [ :restart, :start ] },
    "ubuntu" => { "default" => [ :restart, :start ] },
    "redhat" => { "default" => [ :restart, :start ] },
    "centos" => { "default" => [ :restart, :start ] },
    "fedora" => { "default" => [ :restart, :start ] },
    "default" => { "default" => [:restart, :start ] }
  )

  action :enable
end

# build default monitrc files
node["monit"]["default_monitrc_configs"].each do |conf|
  monit_monitrc conf do
    variables(:category => "system")
    notifies :restart, "service[monit]", :delayed
  end
end
