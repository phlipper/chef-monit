actions :create, :delete
default_action :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :variables, :kind_of => Hash
