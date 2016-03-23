require "serverspec"

set :backend, :exec

def redhat?
  os[:family] == "redhat"
end

describe "Default install of monit" do
  describe package("monit") do
    it { should be_installed }
  end

  describe command("monit -V") do
    its(:stdout) { should match(/monit version \d\.\d/i) }
    its(:exit_status) { should eq 0 }
  end

  describe service("monit") do
    it { should be_enabled }
    it { should be_running }
  end

  describe command("monit status") do
    its(:stdout) { should match(/System '[\w\-\.]+'/) }
    its(:stdout) do
      should match(/monitoring status\s+(Initializing|Monitored)/i)
    end

    if redhat?
      its(:stdout) { should match(/The Monit daemon \d\.\d+ uptime: \d+m/) }
    else
      its(:stdout) { should match(/status\s+(Initializing|Running)/) }
    end

    its(:exit_status) { should eq 0 }
  end
end
