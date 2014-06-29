#
# Cookbook Name:: monit
# Attributes:: default
#
# Author:: Phil Cohen <github@phlippers.net>
#

# Delay the start of polling when the service is started
default["monit"]["start_delay"] = 0

# How frequently the monit daemon polls for changes.
default["monit"]["polling_frequency"] = 20

# Use syslog for logging instead of a logfile.
default["monit"]["use_syslog"] = true

# If not using syslog, the log file that monit will use.
default["monit"]["logfile"] = "/var/log/monit.log"

# Where Monit stores unique Monit instance id
default["monit"]["idfile"] = "/var/.monit.id"

# Where Monit stores Monit state file
default["monit"]["statefile"] = "/var/lib/monit/state"

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
  timeout:  30,
  using_hostname: nil
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

# `MONIT_OPTS` for /etc/default/monit
default["monit"]["init_opts"] = ""

# specify a particular version of the monit package you want installed,
# otherwise it will install the default. this value is ignored when performing a
# source install.
default["monit"]["version"] = nil

# source install specifics
default["monit"]["source_install"] = false

default["monit"]["source"]["version"] = "5.7"
default["monit"]["source"]["prefix"] = "/usr/local"
default["monit"]["source"]["url"] = "https://mmonit.com/monit/dist/monit-5.7.tar.gz"
default["monit"]["source"]["checksum"] = "bb250ab011d805b5693972afdf95509e79bb3b390caa763275c9501f74b598a2"
default["monit"]["source"]["pam_support"] = true
default["monit"]["source"]["ssl_support"] = true
default["monit"]["source"]["large_file_support"] = true
default["monit"]["source"]["compiler_optimized"] = true
