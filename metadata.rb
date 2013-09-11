name              "monit"
maintainer        "Phil Cohen"
maintainer_email  "github@phlippers.net"
license           "MIT"
description       "Configures monit"
long_description  "Please refer to README.md"
version           "1.4.0"

recipe "monit", "Sets up the service definition and default checks."

%w[ubuntu debian redhat centos scientific fedora suse amazon].each do |os|
  supports os
end
