require "serverspec"
require "pathname"

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.os = backend(Serverspec::Commands::Base).check_os
  end
end

def centos65?
  RSpec.configuration.os.values_at(:family, :release) == ["RedHat", "6.5"]
end
