source "https://rubygems.org"

chef_version = ENV.fetch("CHEF_VERSION", "11.18.6")

gem "chef", "~> #{chef_version}"
gem "chefspec", "~> 4.2.0"

gem "berkshelf", "~> 3.2.3"
gem "foodcritic", "~> 4.0.0"
gem "rake", "~> 10.4.0"
gem "rubocop", "~> 0.30.1"
gem "serverspec", "~> 2.14.1"

group :integration do
  gem "busser-serverspec", "~> 0.5.5"
  gem "kitchen-docker", "~> 2.1.0"
  gem "kitchen-sync", "~> 1.0.1"
  gem "test-kitchen", "~> 1.4.0"
end
