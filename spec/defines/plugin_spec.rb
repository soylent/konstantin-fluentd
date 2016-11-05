require 'spec_helper'

RSpec.describe 'fluentd::plugin' do
  let(:pre_condition) { 'include fluentd' }

  let(:title) { 'fluent-plugin-test' }

  context 'with redhat', :redhat do
    it { is_expected.to contain_package(title).with(provider: 'tdagent') }
  end

  context 'with debian', :debian do
    it { is_expected.to contain_package(title).with(provider: 'tdagent') }
  end
end
