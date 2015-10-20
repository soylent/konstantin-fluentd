class fluentd::params {
  $repo_name = 'treasuredata'
  $repo_baseurl = 'http://packages.treasuredata.com/2/redhat/$releasever/$basearch'
  $repo_enabled = true
  $repo_gpgcheck = true
  $repo_gpgkey = 'https://packages.treasuredata.com/GPG-KEY-td-agent'

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
