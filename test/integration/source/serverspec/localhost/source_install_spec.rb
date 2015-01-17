require "serverspec"

set :backend, :exec

def redhat?
  os[:family] == "redhat"
end

def status_command
  config_file = redhat? ? "/etc/monit.conf" : "/etc/monit/monitrc"
  "monit -c #{config_file} status"
end

describe "Source install of monit" do
  describe package("monit") do
    it { should_not be_installed }
  end

  describe command("monit -V") do
    its(:stdout) { should match(/version 5\.7/) }
    its(:exit_status) { should eq 0 }
  end

  describe service("monit") do
    it { should be_enabled }
    it { should be_running }
  end

  describe command(status_command) do
    its(:stdout) { should match(/System '[\w\-\.]+'/) }
    its(:stdout) { should match(/status\s+Running/) }
    its(:stdout) { should match(/monitoring status\s+Monitored/) }
    its(:exit_status) { should eq 0 }
  end
end
