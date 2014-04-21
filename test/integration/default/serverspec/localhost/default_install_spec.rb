require "spec_helper"

describe "Default install of monit" do
  it "installed monit via package manager" do
    expect(package "monit").to be_installed
  end

  it "installed the desired version of monit" do
    expect(command "monit -V").to return_stdout(/monit version \d\.\d/i)
  end

  it "enabled the monit service" do
    expect(service "monit").to be_enabled
  end

  it "started monit in the background" do
    expect(service "monit").to be_running
  end

  describe command("monit status") do
    it "properly configured system monitoring" do
      should return_stdout(/System '[\w\-\.]+'/)
    end

    it "properly enabled system monitoring" do
      # centos 6.5 is old and has different output
      if centos65?
        true
      else
        should return_stdout(/status\s+Running/)
      end
    end

    it "properly monitored the system" do
      if centos65?
        true
      else
        should return_stdout(/monitoring status\s+Monitored/)
      end
    end
  end
end
