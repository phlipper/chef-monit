require "spec_helper"

describe "monit::install_binary" do
  describe "when binary is not found" do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(file_cache_path: '/var/chef/cache') do |node|
        node.set["monit"]["binary"]["version"] = "5.12.2"
        node.set["monit"]["binary"]["prefix"] = "/usr"
      end.converge(described_recipe)
    end
		
    specify do
    	allow(File).to receive(:exist?).and_call_original
    	allow(File).to receive(:exist?).with('/usr/bin/monit').and_return(false)
    	expect(chef_run).to_not run_execute("rm /usr/bin/monit")
      
      expect(chef_run).to create_remote_file_if_missing('/var/chef/cache/monit-5.12.2.tar.gz')
      download = chef_run.remote_file('/var/chef/cache/monit-5.12.2.tar.gz')
			expect(download).to notify('execute[install-monit-binary]').to(:run)
      
      expect(chef_run).to_not run_execute("install-monit-binary").with(cwd: "/var/chef/cache", command: "tar zxvf monit-5.12.2.tar.gz && cd monit-5.12.2 && cp bin/monit /usr/bin/monit")
      expect(chef_run).to include_recipe('monit::_service_configuration')
    end
  end
  
  describe "when binary is found and installing version is different from existing binary" do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(file_cache_path: '/var/chef/cache') do |node|
        node.set["monit"]["binary"]["version"] = '5.12.2'
        node.set["monit"]["binary"]["prefix"] = '/usr'
      end.converge(described_recipe)
    end

    specify do
    	allow(File).to receive(:exist?).and_call_original
    	allow(File).to receive(:exist?).with('/usr/bin/monit').and_return(true)    
    	stub_command('monit -V | grep 5.12.2').and_return(false) # ex) 5.12.1 was installed
    	
      expect(chef_run).to run_execute('rm /usr/bin/monit')
      remove_existing_binary = chef_run.execute('rm /usr/bin/monit')
      expect(remove_existing_binary).to notify('remote_file[/var/chef/cache/monit-5.12.2.tar.gz]').to(:create).immediately
      
      download = chef_run.remote_file('/var/chef/cache/monit-5.12.2.tar.gz')
      expect(download).to notify('execute[install-monit-binary]').to(:run).immediately
      
      expect(chef_run).to create_remote_file_if_missing('/var/chef/cache/monit-5.12.2.tar.gz')
      
      expect(chef_run).to_not run_execute("install-monit-binary").with(cwd: "/var/chef/cache", command: "tar zxvf monit-5.12.2.tar.gz && cd monit-5.12.2 && cp bin/monit /usr/bin/monit")
      expect(chef_run).to include_recipe('monit::_service_configuration')
    end
  end  
  
  describe "when binary is found and installing version same as existing binary" do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(file_cache_path: '/var/chef/cache') do |node|
        node.set["monit"]["binary"]["version"] = '5.12.2'
        node.set["monit"]["binary"]["prefix"] = '/usr'
      end.converge(described_recipe)
    end

    specify do
    	allow(File).to receive(:exist?).and_call_original
    	allow(File).to receive(:exist?).with('/usr/bin/monit').and_return(true)    
    	stub_command('monit -V | grep 5.12.2').and_return(true)
    	
      expect(chef_run).not_to run_execute('rm /usr/bin/monit')
      
      expect(chef_run).to_not run_execute("install-monit-binary").with(cwd: "/var/chef/cache", command: "tar zxvf monit-5.12.2.tar.gz && cd monit-5.12.2 && cp bin/monit /usr/bin/monit")
      expect(chef_run).to include_recipe('monit::_service_configuration')
    end
  end
end
