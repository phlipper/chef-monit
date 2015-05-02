#
# Cookbook Name:: monit
# Recipe:: install_binary
#

tar_file = "monit-#{node["monit"]["binary"]["version"]}.tar.gz"
cache_path = Chef::Config[:file_cache_path]
binary = "#{node["monit"]["binary"]["prefix"]}/bin/monit"

execute "rm #{binary}" do
  only_if { ::File.exist?(binary) }
  not_if "monit -V | grep #{node["monit"]["binary"]["version"]}"
  notifies :create, "remote_file[#{cache_path}/#{tar_file}]", :immediately
end

remote_file "#{cache_path}/#{tar_file}" do
  source node["monit"]["binary"]["url"]
  checksum node["monit"]["binary"]["checksum"]
  action :create_if_missing
  notifies :run, "execute[install-monit-binary]", :immediately
end

execute "install-monit-binary" do
  cwd cache_path
  command [
    "tar zxvf #{tar_file}",
    "cd #{File.basename(tar_file, ".tar.gz")}",
    "cp bin/monit #{node["monit"]["binary"]["prefix"]}/bin/monit"
  ].join(" && ")
  action :nothing
end

include_recipe "monit::_service_configuration"
