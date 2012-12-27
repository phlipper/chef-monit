#
# Cookbook Name:: monit
# Recipe:: default
#

package "monit" do
  action :install
end

template node["monit"]["main_config_path"] do
  owner  "root"
  group  "root"
  mode   "0700"
  source "monitrc.erb"
end

directory "/var/monit" do
  owner "root"
  group "root"
  mode  "0700"
end

service "monit" do
  service_name "monit"

  case node["platform"]
  when platform_family?("rhel"), platform_family?("fedora"), platform_family?("suse")
    start_command "/sbin/service monit start"
    restart_command "/sbin/service monit restart"
  when platform_family?("debian")
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

if platform_family?("debian")
  # enable startup
  execute "enable-monit-startup" do
    command "/bin/sed s/startup=0/startup=1/ -i /etc/default/monit"
    not_if "grep 'startup=1' /etc/default/monit"
  end
end

# build monitrc files
%w[load ssh].each do |conf|
  monit_monitrc conf do
    variables({ category: "system" })
  end
end
