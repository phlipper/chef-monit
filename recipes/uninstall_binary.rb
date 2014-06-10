binary = "#{node["monit"]["binary"]["prefix"]}/bin/monit"

execute "rm #{binary}" do
  only_if { File.exist?(binary) }
end

template "/etc/init.d/monit" do
  source "monit.init.erb"
  mode "0755"
  variables(
    prefix: node["monit"]["binary"]["prefix"],
    config: node["monit"]["main_config_path"]
  )
  action :delete
end
