RSpec.shared_context 'redhat', :redhat do
  let(:facts) do
    { osfamily: 'RedHat' }
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
      lsbdistrelease: '14.04'
    }
  end
end
