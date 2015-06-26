#
# Cookbook Name:: monit
# Recipe:: install_package
#

case node["platform_family"] # ~FC007 uses `suggests`
when "debian"
  include_recipe "apt"
when "rhel"
  include_recipe "yum-epel"
end

package "monit" do
  version node["monit"]["version"] if node["monit"]["version"]
end
