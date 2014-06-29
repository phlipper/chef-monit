require "spec_helper"

describe "monit::default" do
  let(:chef_run) do
    ChefSpec::Runner.new.converge("apt", described_recipe)
  end

  it { expect(chef_run).to include_recipe "apt" }
  it { expect(chef_run).to include_recipe "monit::install_package" }
  it { expect(chef_run).to_not include_recipe "monit::install_source" }

  # optionally use encrypted mail credentials
  # node["monit"]["mail"]["encrypted_credentials"]

  it "creates the main configuration file" do
    monitrc = "/etc/monit/monitrc"

    expect(chef_run).to create_template(monitrc).with(
      owner: "root",
      group: "root",
      mode: "0600",
      source: "monitrc.erb"
    )

    expect(chef_run.template(monitrc)).to notify("service[monit]").to(:reload)
    # if node["monit"]["reload_on_change"]
  end

  it "creates the `/var/monit` directory" do
    expect(chef_run).to create_directory("/var/monit").with(
      owner: "root",
      group: "root",
      mode: "0700"
    )
  end

  it "creates the service startup file" do
    startup = "/etc/default/monit"

    expect(chef_run).to create_file(startup).with(
      owner: "root",
      group: "root",
      mode: "0644"
    )

    expect(chef_run).to render_file(startup).with_content("START=yes")
    expect(chef_run).to render_file(startup).with_content("MONIT_OPTS=")

    expect(chef_run.file(startup)).to notify("service[monit]").to(:restart)
  end

  it "manages the system service" do
    expect(chef_run).to enable_service "monit"
    expect(chef_run).to start_service "monit"
  end

  it "builds default monitrc files" do
    expect(chef_run).to create_monit_monitrc "load"
    expect(chef_run).to create_monit_monitrc "ssh"
  end

  describe "source installation" do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set["monit"]["source_install"] = true
      end.converge("apt", described_recipe)
    end

    it { expect(chef_run).to_not include_recipe "monit::install_package" }
    it { expect(chef_run).to include_recipe "monit::install_source" }
  end
end
