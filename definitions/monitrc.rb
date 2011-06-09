define :monitrc, :name => nil, :variables => {} do
  Chef::Log.info("Making monitrc for: #{params[:name]}")

  template "/etc/monit/conf.d/#{params[:name]}.monitrc" do
    owner "root"
    group "root"
    mode  "0644"
    source "#{params[:name]}.monitrc.erb"
    variables params[:variables]
    notifies :run, resources(:execute => "restart-monit")
    action :create
  end
end