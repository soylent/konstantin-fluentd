define fluentd::config($config, $config_path='/etc/td-agent/config.d') {
  $path = sprintf("${config_path}/%s", $title)

  file { $path:
    ensure  => present,
    content => fluent_config($config),
    require => Class['Fluentd::Install'],
    notify  => Class['Fluentd::Service'],
  }
}
