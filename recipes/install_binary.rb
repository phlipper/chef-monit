tar_file = "monit-#{node["monit"]["binary"]["version"]}.tar.gz"

remote_file "#{Chef::Config[:file_cache_path]}/#{tar_file}" do
  source node["monit"]["binary"]["url"]
  checksum node["monit"]["binary"]["checksum"]
  action :create_if_missing
  notifies :run, "execute[install-monit-binary]"
end

execute "install-monit-binary" do
  command "cd #{Chef::Config[:file_cache_path]} && \
  tar zxvf monit-#{node["monit"]["binary"]["version"]}.tar.gz && \
  cd monit-#{node["monit"]["binary"]["version"]} && \
  cp bin/monit #{node["monit"]["binary"]["prefix"]}/bin/monit"
  action :nothing
end

config_dir = File.dirname(node["monit"]["main_config_path"])

[config_dir, node["monit"]["includes_dir"], "/var/lib/monit"].each do |dir|
  directory dir do
    recursive true
  end
end

template "/etc/init.d/monit" do
  source "monit.init.erb"
  mode "0755"
  variables(
    prefix: node["monit"]["binary"]["prefix"],
    config: node["monit"]["main_config_path"]
  )
end

execute "chkconfig monit on" do
  only_if { platform_family?("rhel") }
end
