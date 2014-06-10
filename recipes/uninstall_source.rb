#
# Cookbook Name:: monit
# Recipe:: install_source
#
# Remove the binary, libs and init script installed
# by install_source.
#
binary = "#{node["monit"]["source"]["prefix"]}/bin/monit"

execute "rm #{binary}" do
  only_if { File.exist?(binary) }
end

directory "/var/lib/monit" do
  action :delete
end

template "/etc/init.d/monit" do
  source "monit.init.erb"
  mode "0755"
  variables(
    prefix: source_opts["prefix"],
    config: node["monit"]["main_config_path"]
  )
  action :delete
end
