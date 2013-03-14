actions :create, :delete
default_action :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :variables, :kind_of => Hash
# the cookbook containing the template, defaults to the one invoking this LWRP
attribute :template_source, :kind_of => String
# the template file name, defaults to #{name}.monitrc.erb
attribute :template_cookbook, :kind_of => String
