class fluentd::params {
  $repo_install = true
  $repo_name = 'treasuredata'
  $repo_desc = 'TreasureData'

  case $facts['osfamily'] {
    'redhat': {
      $repo_url = 'http://packages.treasuredata.com/2/redhat/$releasever/$basearch'
    }

    'debian': {
      $distro_id = downcase($facts['lsbdistid'])
      $distro_codename = $facts['lsbdistcodename']
      $repo_url = "http://packages.treasuredata.com/2/${distro_id}/${distro_codename}/"
    }

    default: {
      fail("Unsupported osfamily ${facts['osfamily']}")
    }
  }

  $repo_enabled = true
  $repo_gpgcheck = true
  $repo_gpgkey = 'https://packages.treasuredata.com/GPG-KEY-td-agent'
  $repo_gpgkeyid = 'BEE682289B2217F45AF4CC3F901F9177AB97ACBE'

  $package_name = 'td-agent'
  $package_ensure = present

  $service_name = 'td-agent'
  $service_ensure = running
  $service_enable = true
  $service_manage = true

  # NOTE: Workaround for the following issue:
  # https://tickets.puppetlabs.com/browse/PUP-5296
  if $facts['osfamily'] == 'redhat' {
    $service_provider = 'redhat'
  } else {
    $service_provider = undef
  }

  $config_file = '/etc/td-agent/td-agent.conf'
  $config_path = '/etc/td-agent/config.d'
  $config_owner = 'td-agent'
  $config_group = 'td-agent'
  $configs = {}

  $plugins = {}
}
