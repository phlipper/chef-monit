if defined?(ChefSpec)
  def create_monit_monitrc(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:monit_monitrc, :create, resource)
  end

  def delete_monit_monitrc(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:monit_monitrc, :delete, resource)
  end
end
