def whyrun_supported?
  true
end

use_inline_resources if defined?(use_inline_resources)

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
    action :nothing
  end

  # Run the action immediately so `updated_by_last_action?` is correct
  t.run_action(:create)

  new_resource.updated_by_last_action(t.updated_by_last_action?)
end

action :delete do
  f = file "#{node["monit"]["includes_dir"]}/#{new_resource.name}.monitrc" do
    action :nothing
    notifies :reload, "service[monit]"
  end

  # Run the action immediately so `updated_by_last_action?` is correct
  f.run_action(:delete)

  new_resource.updated_by_last_action(f.updated_by_last_action?)
end
