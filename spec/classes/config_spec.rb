require 'spec_helper'

RSpec.describe 'fluentd::config' do
  context 'on RedHat based system' do
    let(:facts) { { osfamily: 'RedHat' } }

    specify do
      is_expected.to contain_file('/etc/td-agent/td-agent.conf')
        .with_content(/type forward/)
        .with_content(/type stdout/)
        .with_content(/match \*\*/)
    end
  end
end
