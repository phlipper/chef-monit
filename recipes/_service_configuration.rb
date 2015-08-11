#
# Cookbook Name:: monit
# Recipe:: _service_configuration
#

config_dir = ::File.dirname(node["monit"]["main_config_path"])
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

pidfile = node["monit"]["pidfile"]
config_path = node["monit"]["main_config_path"]
binary_prefix = \
  if node["monit"]["source_install"]
    node["monit"]["source"]["prefix"]
  else
    node["monit"]["binary"]["prefix"]
  end

if node['platform'] == 'debian' && node['platform_version'].to_i >= 8
  template "/lib/systemd/system/monit.service" do
    source "monit.systemd.erb"
    mode 0755
    variables(
      prefix: binary_prefix,
      config: config_path,
      opts: node["monit"]["init_opts"]
    )
  end
else
  template "/etc/init.d/monit" do
    source "monit.init.erb"
    mode "0755"
    variables(
      prefix: binary_prefix,
      config: config_path,
      pidfile: pidfile
    )
  end
end

execute "chkconfig monit on" do
  only_if { platform_family?("rhel") }
  not_if %(chkconfig --list | grep 'monit ' | grep '2:on')
end
