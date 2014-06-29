require "spec_helper"

describe "monit::install_package" do
  describe "debian platform family" do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set["monit"]["version"] = "1.2.3"
      end.converge("apt", described_recipe)
    end

    it { expect(chef_run).to_not include_recipe "yum-epel" }
    it { expect(chef_run).to install_package("monit").with(version: "1.2.3") }
  end

  describe "redhat platform family" do
    let(:chef_run) do
      platform = { platform: "centos", version: "6.5" }
      ChefSpec::Runner.new(platform).converge("yum-epel", described_recipe)
    end

    it { expect(chef_run).to include_recipe "yum-epel" }
    it { expect(chef_run).to install_package "monit" }
  end
end
