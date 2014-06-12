if node["monit"]["source_uninstall"]
  include_recipe "monit::uninstall_source"
elsif node["monit"]["binary_uninstall"]
  include_recipe "monit::uninstall_binary"
else
  include_recipe "yum-epel" if platform_family?("rhel") # ~FC007 uses `suggests`

  package "monit" do
    version node["monit"]["version"] if node["monit"]["version"]
    action :remove
  end
end
