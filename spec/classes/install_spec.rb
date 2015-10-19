require 'spec_helper'

RSpec.describe 'fluentd::install' do
  context 'on RedHat system' do
    let(:facts) { { osfamily: 'RedHat' } }

    it { is_expected.to contain_yumrepo('treasuredata') }
    it { is_expected.to contain_package('td-agent') }
  end

  context 'on unsupported system' do
    let(:facts) { { osfamily: 'Darwin' } }

    it { is_expected.not_to compile }
  end
end
