def whyrun_supported?
  true
end

use_inline_resources

action :create do
  name = new_resource.name

  template "#{node["monit"]["includes_dir"]}/#{name}.monitrc" do
    owner "root"
    group "root"
    mode  "0644"
    source new_resource.template_source || "#{name}.monitrc.erb"
    cookbook new_resource.template_cookbook
    variables new_resource.variables
    notifies :reload, "service[monit]" if node["monit"]["reload_on_change"]
    action :create
  end
end

action :delete do
  file "#{node["monit"]["includes_dir"]}/#{new_resource.name}.monitrc" do
    action :delete
    notifies :reload, "service[monit]"
  end
end
