RSpec.shared_context 'redhat', :redhat do
  let(:facts) do
    { operatingsystem: 'CentOS', osfamily: 'RedHat' }
  end
end

RSpec.shared_context 'darwin', :darwin do
  let(:facts) do
    { osfamily: 'Darwin' }
  end
end

RSpec.shared_context 'debian', :debian do
  let(:facts) do
    {
      osfamily: 'Debian',
      lsbdistid: 'Ubuntu',
      lsbdistcodename: 'trusty',
      # NOTE: Module `puppetlabs/apt` uses structured facts
      # Please see: https://tickets.puppetlabs.com/browse/MODULES-4792
      os: {
        name: 'Ubuntu',
        release: {
          full: '14.04'
        }
      }
    }
  end
end
