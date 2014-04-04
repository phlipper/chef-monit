# chef-monit  [![Build Status](http://img.shields.io/travis-ci/phlipper/chef-monit.png)](http://travis-ci.org/phlipper/chef-monit)

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
# Delay the start of polling when the service is started
default["monit"]["start_delay"] = 0

# How frequently the monit daemon polls for changes.
default["monit"]["polling_frequency"] = 20

# Use syslog for logging instead of a logfile.
default["monit"]["use_syslog"] = true

# If not using syslog, the log file that monit will use.
default["monit"]["logfile"] = "/var/log/monit.log"

# Where Monit stores unique Monit instance id
default["monit"]["idfile"]            = "/var/.monit.id"

# Where Monit stores Monit state file
default["monit"]["statefile"]         = "/var/lib/monit/state"

# Enable emails for internal monit alerts
default["monit"]["mail_alerts"] = true

# Ignore alerts for specific events
# Possible events include: action, checksum, connection, content, data, exec, fsflags, gid, icmp, instance, invalid, nonexist, permission, pid, ppid, resource, size, status, timeout, timestamp, uid, uptime.
default["monit"]["alert_ignore_events"] = []

# Email address that will be notified of events.
default["monit"]["alert_email"] = "root@localhost"

# Enable the web interface and define credentials.
default["monit"]["web_interface"] = {
  enable:  true,
  port:    2812,
  address: "localhost",
  allow:   ["localhost", "admin:b1gbr0th3r"]
}

# Email settings that will be used for notification of events.
default["monit"]["mail"] = {
  hostname: "localhost",
  port:     25,
  username: nil,
  password: nil,
  encrypted_credentials: nil,
  encrypted_credentials_data_bag: "credentials",
  from:     "monit@$HOST",
  subject:  "$SERVICE $EVENT at $DATE",
  message:  "Monit $ACTION $SERVICE at $DATE on $HOST,\n\n$DESCRIPTION\n\nDutifully,\nMonit",
  security: nil,  # 'SSLV2'|'SSLV3'|'TLSV1'
  timeout:  30
}

case node["platform_family"]
when "rhel", "fedora", "suse"
  default["monit"]["main_config_path"] = "/etc/monit.conf"
  default["monit"]["includes_dir"] = "/etc/monit.d"
else
  default["monit"]["main_config_path"] = "/etc/monit/monitrc"
  default["monit"]["includes_dir"] = "/etc/monit/conf.d"
end

# The monit::default recipe will load these monit_monitrc resources automatically
# NOTE setting this attribute at the default level will append values to the array
default["monit"]["default_monitrc_configs"] = %w[load ssh]

# Whether the monit service should be reloaded when a configuration changes
default["monit"]["reload_on_change"] = true
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
    * fix logging logic
    * whyrun support for monitrc provider
    * support for reloading monit without restart
    * don't render 'use address' if no address is provided
* **[@tjwallace](https://github.com/tjwallace)**
    * load default monitrc configs from an attribute
* **[@tomdz](https://github.com/tomdz)**
    * Ruby 1.8.x compatibility fix
    * add support for templates in different cookbooks
* **[@alexism](https://github.com/alexism)**
    * support other security protocols
* **[@fixlr](https://github.com/fixlr)**
    * add `mail_alerts` attribute
* **[@darron](https://github.com/darron)**
    * add descriptions to email notifications
* **[@claco](https://github.com/claco)**
    * add startup delay option to monit daemon config
    * restart on default monitrc configs change
    * restart monit service if the monit config changes
    * fix platform family logic
* **[@maciejgalkiewicz](https://github.com/maciejgalkiewicz)**
    * fix logging logic
* **[@pauloricardomg](https://github.com/pauloricardomg)**
    * add `alert_ignore_events` attribute
    * add `reload_on_change` attribute
* **[@drywheat](https://github.com/drywheat)**
    * support encrypted data bag for smtp credentials
* **[@esigler](https://github.com/esigler)**
    * allow either style of monit startup flag to work
* **[@evan2645](https://github.com/evan2645)**
    * fix bug in which monit is not started during bootstrap
* **[@mvdkleijn](https://github.com/mvdkleijn)**
    * add settings for idfile and statefile


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## License

**chef-monit**

* Freely distributable and licensed under the [MIT license](http://phlipper.mit-license.org/2011-2014/license.html).
* Copyright (c) 2011-2014 Phil Cohen (github@phlippers.net) [![endorse](http://api.coderwall.com/phlipper/endorsecount.png)](http://coderwall.com/phlipper)  [![Gittip](http://img.shields.io/gittip/phlipper.png)](https://www.gittip.com/phlipper/)
* http://phlippers.net/

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/phlipper/chef-monit/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
