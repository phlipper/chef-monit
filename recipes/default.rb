package "monit" do
  action :install
end

template "/etc/monit/monitrc" do
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

# enable startup
execute "enable-monit-startup" do
  command "/bin/sed s/startup=0/startup=1/ -i /etc/default/monit"
  not_if "grep 'startup=1' /etc/default/monit"
end

execute "restart-monit" do
  command "/usr/sbin/service monit restart"
  action :nothing
end

# build monitrc files
%w[load ssh].each do |conf|
  monitrc conf, :app_name => "system"
end