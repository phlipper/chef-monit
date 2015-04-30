require "serverspec"

set :backend, :exec

def redhat?
  os[:family] == "redhat"
end

def status_command
  config_file = redhat? ? "/etc/monit.conf" : "/etc/monit/monitrc"
  "monit -c #{config_file} status"
end

describe "Binary install of monit" do
  describe package("monit") do
    it { should_not be_installed }
  end

  describe command("monit -V") do
    its(:stdout) { should match(/version 5\.12\.2/) }
    its(:exit_status) { should eq 0 }
  end

  describe service("monit") do
    it { should be_enabled }
    it { should be_running }
  end

  describe command(status_command) do
    its(:stdout) { should match(/System '[\w\-\.]+'/) }
    its(:stdout) { should match(/status\s+(Initializing|Running)/) }
    its(:stdout) do
      should match(/monitoring status\s+(Initializing|Monitored)/)
    end
    its(:exit_status) { should eq 0 }
  end
end
