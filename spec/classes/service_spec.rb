require 'spec_helper'

RSpec.describe 'fluentd::service' do
  context 'with redhat', :redhat do
    it { is_expected.to contain_service('td-agent').with(provider: 'redhat') }
  end

  context 'with debian', :debian do
    it { is_expected.to contain_service('td-agent').without(:provider) }
  end
end
