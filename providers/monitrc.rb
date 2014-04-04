def whyrun_supported?
  true
end

action :create do
  name = new_resource.name

  t = template "#{node["monit"]["includes_dir"]}/#{name}.monitrc" do
    owner "root"
    group "root"
    mode  "0644"
    source new_resource.template_source || "#{name}.monitrc.erb"
    cookbook new_resource.template_cookbook
    variables new_resource.variables
    notifies :reload, "service[monit]" if node["monit"]["reload_on_change"]
  end

  new_resource.updated_by_last_action(t.updated_by_last_action?)
end

action :delete do
  f = file "#{node["monit"]["includes_dir"]}/#{new_resource.name}.monitrc" do
    action :delete
    notifies :reload, "service[monit]"
  end

  new_resource.updated_by_last_action(f.updated_by_last_action?)
end
