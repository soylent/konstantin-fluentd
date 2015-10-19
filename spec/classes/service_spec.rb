require 'spec_helper'

RSpec.describe 'fluentd::service' do
  context 'on RedHat based system' do
    let(:facts) { { osfamily: 'RedHat' } }

    it { is_expected.to contain_service('td-agent') }
  end
end
