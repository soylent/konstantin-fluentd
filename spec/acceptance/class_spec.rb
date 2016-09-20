require 'spec_helper_acceptance'

RSpec.describe 'fluentd' do
  shared_examples 'works' do |manifest|
    before(:context) { apply_manifest(manifest, expect_changes: true) }

    context 'when the manifest is applied second time' do
      it 'does not change anything' do
        apply_manifest(manifest, catch_changes: true)
      end
    end

    describe package('td-agent') do
      it { is_expected.to be_installed }
    end

    describe service('td-agent') do
      it { is_expected.to be_enabled.with_level(3) }
      it { is_expected.to be_running }
    end
  end

  Dir[File.expand_path('../../examples/*.pp', __dir__)].each do |manifest_file|
    context "with #{manifest_file}" do
      include_examples 'works', File.read(manifest_file)
    end
  end
end
