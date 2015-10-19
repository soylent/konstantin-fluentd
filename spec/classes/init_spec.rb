require 'spec_helper'

RSpec.describe 'fluentd' do
  context 'with defaults for all parameters' do
    let(:facts) { { osfamily: 'RedHat' } }

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('fluentd') }
    it { is_expected.to contain_class('fluentd::install') }
    it { is_expected.to contain_class('fluentd::config') }
    it { is_expected.to contain_class('fluentd::service') }
  end
end
