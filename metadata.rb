maintainer        "Phil Cohen"
maintainer_email  "github@phlippers.net"
description       "Configures monit"
version           "0.1"

%w{ubuntu debian}.each do |os|
  supports os
end

attribute "monit/polling_frequency",
  :display_name => "Polling Frequency",
  :description  => "How frequently the monit daemon polls for changes",
  :default      => "20"

attribute "monit/use_syslog",
  :display_name => "Use Syslog",
  :description  => "Use syslog for logging instead of a logfile",
  :default      => "true"

attribute "monit/logfile",
  :display_name => "Log File",
  :description  => "If not using syslog, the log file that monit will use",
  :default      => "/var/log/monit.log"

attribute "monit/web_interface",
  :display_name => "Web Interface Settings",
  :description  => "Enable the web interface and define credentials",
  :default      => {
    :enable => "false", :port => "2812", :address => "localhost",
    :allow  => ["localhost", "admin:b1gbr0th3r"]
  }

attribute "monit/alert_email",
  :display_name => "Alert Email",
  :description  => "Email address that will be notified of events",
  :default      => "root@localhost"

attribute "monit/mail",
  :display_name => "Mail Settings",
  :description  => "Email settings that will be used for notification of events",
  :default      => {
    :hostname => "localhost",
    :port     => "25",
    :username => "",
    :password => "",
    :from     => "monit@localhost",
    :tls      => "false",
    :timeout  => "30"
  }