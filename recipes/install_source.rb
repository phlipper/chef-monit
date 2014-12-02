#
# Cookbook Name:: monit
# Recipe:: install_source
#
# Emulate a package install using src code
#

include_recipe "build-essential"

cache_path = Chef::Config[:file_cache_path]
source_opts = node["monit"]["source"]
monit_version = source_opts["version"]

pam_pkg = value_for_platform_family(
  %w[rhel fedora suse] => "pam-devel",
  "debian" => "libpam-dev"
)

ssl_pkg = value_for_platform_family(
  %w[rhel fedora suse] => "openssl-devel",
  "debian" => "libssl-dev"
)

package pam_pkg do
  only_if { source_opts["pam_support"] }
end

package ssl_pkg do
  only_if { source_opts["ssl_support"] }
end

remote_file "#{cache_path}/monit-#{monit_version}.tgz" do
  source source_opts["url"]
  checksum source_opts["checksum"]
  action :create_if_missing
end

config_cmd = "./configure --prefix #{source_opts["prefix"]}"
config_cmd << " --sysconfdir=#{File.dirname(node["monit"]["main_config_path"])}"
config_cmd << " --without-pam" unless source_opts["pam_support"]
config_cmd << " --without-ssl" unless source_opts["ssl_support"]
config_cmd << " --disable-largefile" unless source_opts["large_file_support"]
config_cmd << " --enable-optimized" if source_opts["compiler_optimized"]

bash "install_monit" do
  cwd cache_path
  code <<-EOH
    tar -xzf monit-#{monit_version}.tgz -C /tmp
    cd /tmp/monit-#{monit_version}
    #{config_cmd} && make && make install
  EOH
  creates "#{source_opts["prefix"]}/bin/monit"
end

include_recipe "monit::_service_configuration"
