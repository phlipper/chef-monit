require "spec_helper"

describe "Binary install of monit" do
  it "does not install monit via package manager" do
    expect(package "monit").to_not be_installed
  end

  it "installs the desired version of monit" do
    expect(command "/usr/bin/monit -V").to return_stdout(/version 5\.8\.1/)
  end

  it "enables the monit service" do
    expect(service "monit").to be_enabled
  end

  it "starts monit in the background" do
    expect(service "monit").to be_running
  end

  describe command("/usr/bin/monit status") do
    it { should return_stdout(/System '[\w\-\.]+'/) }
    it { should return_stdout(/status\s+Running/) }
    it { should return_stdout(/monitoring status\s+Monitored/) }
  end
end
