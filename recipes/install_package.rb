#
# Cookbook Name:: monit
# Recipe:: install_package
#

include_recipe "yum-epel" if platform_family?("rhel") # ~FC007 uses `suggests`

package "monit" do
  version node["monit"]["version"] if node["monit"]["version"]
end
