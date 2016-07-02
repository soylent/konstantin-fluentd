require 'spec_helper'

RSpec.describe 'fluentd::install' do
  shared_examples 'package and configs' do
    it { is_expected.to contain_package('td-agent') }
    it { is_expected.to contain_file('/etc/td-agent/td-agent.conf') }
    it { is_expected.to contain_file('/etc/td-agent/config.d') }
  end

  context 'with redhat', :redhat do
    include_examples 'package and configs'

    it { is_expected.to contain_yumrepo('treasuredata') }
  end

  context 'with debian', :debian do
    include_examples 'package and configs'

    it { is_expected.to contain_apt__source('treasuredata') }
  end

  context 'with unsupported system', :darwin do
    it { is_expected.not_to compile }
  end
end
