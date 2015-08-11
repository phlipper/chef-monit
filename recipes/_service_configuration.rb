#
# Cookbook Name:: monit
# Recipe:: _service_configuration
#

config_dir = File.dirname(node["monit"]["main_config_path"])
monit_dirs = [
  config_dir,
  node["monit"]["includes_dir"],
  "/var/lib/monit"
]

monit_dirs.each do |dir|
  directory dir do
    recursive true
  end
end

binary_prefix = \
  if node["monit"]["source_install"]
    node["monit"]["source"]["prefix"]
  else
    node["monit"]["binary"]["prefix"]
  end

template "/etc/init.d/monit" do
  source "monit.init.erb"
  mode "0755"
  variables(
    prefix: binary_prefix,
    config: node["monit"]["main_config_path"],
    pidfile: node["monit"]["pidfile"]
  )
end

execute "chkconfig monit on" do
  only_if { platform_family?("rhel") }
  not_if %(chkconfig --list | grep 'monit ' | grep '2:on')
end
