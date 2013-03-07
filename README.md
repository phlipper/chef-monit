# chef-monit  [![Build Status](https://secure.travis-ci.org/phlipper/chef-monit.png)](http://travis-ci.org/phlipper/chef-monit) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/phlipper/chef-monit)

## Description

Installs the `monit` package from (http://mmonit.com/monit/).


## Requirements

### Supported Platforms

The following platforms are supported by this cookbook, meaning that the recipes run on these platforms without error:

* Ubuntu
* Debian
* RedHat
* CentOS
* Scientific
* Fedora
* SUSE
* Amazon


## Recipes

* `monit` - The default recipe. Sets up the service definition and default checks.


## Resources

### `monit_monitrc`

The following will create a monitrc configuration:

```ruby
monit_monitrc "ssh" do
  variables({ category: "system" })
end
```

The `name` parameter must match a file located in your templates directory. In the example above, this would be `ssh.monitrc.erb`.

The `variables` option within the block is optional, and can contain a list of key-value pairs to assign within your template.


## Usage

This cookbook installs the monit components if not present, and pulls updates if they are installed on the system.


## Attributes

```ruby
# How frequently the monit daemon polls for changes.
default["monit"]["polling_frequency"] = 20

# Use syslog for logging instead of a logfile.
default["monit"]["use_syslog"]        = true

# If not using syslog, the log file that monit will use.
default["monit"]["logfile"]           = "/var/log/monit.log"

# Email address that will be notified of events.
default["monit"]["alert_email"]       = "root@localhost"

# Enable the web interface and define credentials.
default["monit"]["web_interface"] = {
  :enable  => true,
  :port    => 2812,
  :address => "localhost",
  :allow   => ["localhost", "admin:b1gbr0th3r"]
}

# Email settings that will be used for notification of events.
default["monit"]["mail"] = {
  :hostname => "localhost",
  :port     => 25,
  :username => nil,
  :password => nil,
  :from     => "monit@$HOST",
  :subject  => "$SERVICE $EVENT at $DATE",
  :message  => "Monit $ACTION $SERVICE at $DATE on $HOST,\n\nDutifully,\nMonit",
  :tls      => false,
  :timeout  => 30
}

case platform
when "redhat", "centos", "fedora"
  default["monit"]["main_config_path"] = "/etc/monit.conf"
  default["monit"]["includes_dir"]     = "/etc/monit.d"
else
  default["monit"]["main_config_path"] = "/etc/monit/monitrc"
  default["monit"]["includes_dir"]     = "/etc/monit/conf.d"
end

# The monit::default recipe will load these monit_monitrc resources automatically
# NOTE setting this attribute at the default level will append values to the array
default["monit"]["default_monitrc_configs"] = ["load", "ssh"]
```


## Contributors

Many thanks go to the following [contributors](https://github.com/phlipper/chef-monit/graphs/contributors) who have helped to make this cookbook even better:

* **[@werdan](https://github.com/werdan)**
    * add support for redhat-flavored systems
* **[@auser](https://github.com/auser)**
    * add missing metadata
* **[@arrowcircle](https://github.com/arrowcircle)**
    * update syntax to be Ruby 1.8-compatible
* **[@dwradcliffe](https://github.com/dwradcliffe)**
    * typo fix for README
* **[@tjwallace](https://github.com/tjwallace)**
    * load default monitrc configs from an attribute


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## License

**chef-monit**

* Freely distributable and licensed under the [MIT license](http://phlipper.mit-license.org/2011-2012/license.html).
* Copyright (c) 2011-2012 Phil Cohen (github@phlippers.net) [![endorse](http://api.coderwall.com/phlipper/endorsecount.png)](http://coderwall.com/phlipper)
* http://phlippers.net/
