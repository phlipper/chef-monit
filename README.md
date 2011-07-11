# DESCRIPTION

Installs the `monit` package from (http://mmonit.com/monit/). Currently only targeting Ubuntu platform. It's not complicated and would work on other platforms, but that can come later.


# REQUIREMENTS

## Supported Platforms

The following platforms are supported by this cookbook, meaning that the recipes run on these platforms without error:

* Ubuntu
* Debian


# DEFINITIONS

## monitrc

The following will create a monitrc configuration:

``` ruby
monitrc "ssh configuration" do
  name "ssh"
  variables { :category => "system" }
end
```

The `name` parameter must match a file located in your templates directory. In the example above, this would be `ssh.monitrc.erb`.


# ATTRIBUTES

## polling_frequency

How frequently the monit daemon polls for changes.

The default is `20`.

## use_syslog

Use syslog for logging instead of a logfile.

The default is `true`.

## logfile

If not using syslog, the log file that monit will use.

The default is `/var/log/monit.log`.

## alert_email

Email address that will be notified of events.

The default is `root@localhost`.

## web_interface

Enable the web interface and define credentials.

The default is

``` ruby
{
  :enable => false,
  :port => 2812,
  :address => "localhost",
  :allow  => ["localhost", "admin:b1gbr0th3r"]
}
```

## mail

Email settings that will be used for notification of events.

The default is

``` ruby
{
  :hostname => "localhost",
  :port     => 25
  :username => nil,
  :password => nil,
  :from     => "monit@localhost",
  :tls      => false,
  :timeout  => 30
}
```


# USAGE

This cookbook installs monit if not present and pulls updates if it is installed on the system.


# LICENSE and AUTHOR:

Author:: Phil Cohen (<github@phlippers.net>)

Copyright:: 2011, Phil Cohen

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.