#
# Cookbook Name:: monit
# Recipe:: _install_source
#
# Emulate a package install using src code
#

package 'libpam-dev' do
  only_if { node['monit']['source']['pam_support'] }
end

package 'libssl-dev' do
  only_if { node['monit']['source']['ssl_support'] }
end

remote_file "#{Chef::Config[:file_cache_path]}/monit-#{node['monit']['source']['version']}.tgz" do
  source node['monit']['source']['url']
  checksum node['monit']['source']['checksum']
  action :create_if_missing
end

config_dir = File.dirname(node['monit']['main_config_path'])

config_cmd = "./configure --prefix #{node['monit']['source']['prefix']}"
config_cmd << " --sysconfdir=#{config_dir}"
config_cmd << ' --without-pam' unless node['monit']['source']['pam_support']
config_cmd << ' --without-ssl' unless node['monit']['source']['ssl_support']
config_cmd << ' --disable-largefile' unless node['monit']['source']['large_file_support']
config_cmd << ' --enable-optimized' if node['monit']['source']['compiler_optimized']

bash 'install_monit' do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    tar -xzf monit-#{node['monit']['source']['version']}.tgz -C /tmp
    cd /tmp/monit-#{node['monit']['source']['version']}
    #{config_cmd} && make && make install
  EOH
  creates "#{node['monit']['source']['prefix']}/bin/monit"
end

[config_dir, node['monit']['includes_dir'], '/var/lib/monit'].each do |dir|
  directory dir do
    recursive true
  end
end

cookbook_file node['monit']['main_config_path'] do
  source 'monit-config'
  mode 0600
end

cookbook_file '/etc/default/monit' do
  source 'monit-init-defaults'
end

template '/etc/init.d/monit' do
  source 'monit.init.erb'
  mode 0755
  variables(
    prefix: node['monit']['source']['prefix'],
    config: node['monit']['main_config_path']
  )
end

service 'monit' do
  action :start
end
