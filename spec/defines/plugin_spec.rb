require 'spec_helper'

RSpec.describe 'fluentd::plugin' do
  let(:pre_condition) { 'include fluentd' }

  let(:facts) { { osfamily: 'RedHat' } }
  let(:title) { 'fluent-plugin-test' }

  it { is_expected.to contain_package(title).with(provider: 'tdagent') }
end
