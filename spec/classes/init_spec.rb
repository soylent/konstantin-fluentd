require 'spec_helper'

RSpec.describe 'fluentd' do
  shared_examples 'works' do
    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('fluentd') }
    it { is_expected.to contain_class('fluentd::install') }
    it { is_expected.to contain_class('fluentd::service') }
  end

  context 'with debian', :debian do
    include_examples 'works'
  end

  context 'with defaults for all parameters', :redhat do
    include_examples 'works'
  end
end
