action :create do
  template "#{node["monit"]["includes_dir"]}/#{new_resource.name}.monitrc" do
    owner "root"
    group "root"
    mode  "0644"
    source "#{new_resource.name}.monitrc.erb"
    variables new_resource.variables
    notifies :restart, "service[monit]", :immediately
    action :create
  end
end

action :delete do
  execute "delete monitrc" do
    command "rm -f #{node["monit"]["includes_dir"]}/#{new_resource.name}.monitrc"
  end
end
