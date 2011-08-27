#
# Cookbook Name:: monit
# Attributes:: default
#
# Copyright 2011, Phil Cohen
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default["monit"]["polling_frequency"] = "20"
default["monit"]["use_syslog"]        = "true"
default["monit"]["logfile"]           = "/var/log/monit.log"
default["monit"]["alert_email"]       = "root@localhost"

default["monit"]["web_interface"] = {
  :enable  => "false",
  :port    => "2812",
  :address => "localhost",
  :allow   => ["localhost", "admin:b1gbr0th3r"]
}

default["monit"]["mail"] = {
  :hostname => "localhost",
  :port     => "25",
  :username => "",
  :password => "",
  :from     => "monit@localhost",
  :tls      => "false",
  :timeout  => "30"
}
