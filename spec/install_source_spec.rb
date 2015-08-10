require "spec_helper"

describe "monit::install_source" do
  let(:remote_tarball) do
    "#{Chef::Config[:file_cache_path]}/monit-1.2.3.tgz"
  end

  describe "debian platform family" do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.set["monit"]["source_install"] = true
        node.set["monit"]["source"]["version"] = "1.2.3"
      end.converge("apt", described_recipe)
    end

    specify do
      expect(chef_run).to install_package "libpam-dev"
      expect(chef_run).to install_package "libssl-dev"

      expect(chef_run).to create_remote_file_if_missing(remote_tarball)

      expect(chef_run).to create_directory "/etc/monit"
      expect(chef_run).to create_directory "/etc/monit/conf.d"

      expect(chef_run).to_not run_execute "chkconfig monit on"
    end
  end

  describe "redhat platform family" do
    let(:chef_run) do
      platform = { platform: "centos", version: "6.5" }
      ChefSpec::SoloRunner.new(platform) do |node|
        node.set["monit"]["source_install"] = true
        node.set["monit"]["source"]["version"] = "1.2.3"
      end.converge("yum-epel", described_recipe)
    end

    before do
      stub_command("chkconfig --list | grep 'monit ' | grep '2:on'")
        .and_return(false)
    end

    specify do
      expect(chef_run).to install_package "pam-devel"
      expect(chef_run).to install_package "openssl-devel"

      expect(chef_run).to create_remote_file_if_missing(remote_tarball)

      expect(chef_run).to create_directory "/etc"
      expect(chef_run).to create_directory "/etc/monit.d"

      expect(chef_run).to run_execute "chkconfig monit on"
    end
  end

  # shared behavior
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.set["monit"]["source_install"] = true
      node.set["monit"]["source"]["version"] = "1.2.3"
    end.converge("apt", described_recipe)
  end

  specify do
    expect(chef_run).to create_remote_file_if_missing(remote_tarball)
    expect(chef_run).to run_bash "install_monit"
    expect(chef_run).to create_directory "/var/lib/monit"
    expect(chef_run).to create_template("/etc/init.d/monit").with(
      source: "monit.init.erb",
      mode: "0755"
    )
    expect(chef_run).to create_template("/etc/init.d/monit").
      with_variables lambda { |x|
        expect(x).to include(prefix: chef_run.node["monit"]["source"]["prefix"])
      }
  end
end
