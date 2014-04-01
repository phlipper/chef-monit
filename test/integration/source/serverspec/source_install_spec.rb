require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe 'Source install of monit' do
  it 'does not install monit via package manager' do
    expect(package('monit')).to_not be_installed
  end

  it 'installs the desired version of monit' do
    expect(command('monit -V').stdout).to match(/version 5\.7/)
  end

  it 'starts monit in the background' do
    expect(service('monit')).to be_running
  end
end
