action :create do
  t = template "#{node["monit"]["includes_dir"]}/#{new_resource.name}.monitrc" do
    owner "root"
    group "root"
    mode  "0644"
    source new_resource.template_source || "#{new_resource.name}.monitrc.erb"
    cookbook new_resource.template_cookbook
    variables new_resource.variables
    action :create
    notifies :restart, "service[monit]", :delayed
  end

  new_resource.updated_by_last_action(t.updated_by_last_action?)
end

action :delete do
  f = file "#{node["monit"]["includes_dir"]}/#{new_resource.name}.monitrc" do
    action :delete
    notifies :restart, "service[monit]", :delayed
  end

  new_resource.updated_by_last_action(f.updated_by_last_action?)
end
