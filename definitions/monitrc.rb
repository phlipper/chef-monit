define :monitrc, :name => nil, :variables => {} do
  Chef::Log.info("Making monitrc for: #{params[:name]}")

  template "#{node["monit"]["includes_dir"]}/#{params[:name]}.monitrc" do
    owner "root"
    group "root"
    mode  "0644"
    source "#{params[:name]}.monitrc.erb"
    variables params[:variables]
    notifies :restart, resources(:service => "monit")
    action :create
  end
end