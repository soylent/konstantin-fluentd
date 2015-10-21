class fluentd::params {
  $repo_name = 'treasuredata'

  case $::osfamily {
    'redhat': {
      $repo_url = 'http://packages.treasuredata.com/2/redhat/$releasever/$basearch'
    }

    'debian': {
      $distro_id = downcase($::lsbdistid)
      $distro_codename = $::lsbdistcodename
      $repo_url = "http://packages.treasuredata.com/2/${distro_id}/${distro_codename}/"
    }

    default: {
      fail("Unsupported osfamily ${::osfamily}")
    }
  }

  $repo_enabled = true
  $repo_gpgcheck = true
  $repo_gpgkey = 'https://packages.treasuredata.com/GPG-KEY-td-agent'
  $repo_gpgkeyid = 'C901622B5EC4AF820C38AB861093DB45A12E206F'

  $package_name = 'td-agent'
  $package_ensure = present

  $plugin_names = []
  $plugin_ensure = present

  $service_name = 'td-agent'
  $service_ensure = running
  $service_enable = true
  $service_manage = true

  $config_file = '/etc/td-agent/td-agent.conf'
  $config_template = 'fluentd/td-agent.conf.erb'
  $config = {
    'source' => [
      { 'type' => 'forward' }
    ],
    'match' => [
      { 'tag_pattern' => '**', 'type' => 'stdout' }
    ]
  }
}
