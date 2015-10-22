class fluentd::config inherits fluentd {
  file { $fluentd::config_file:
    ensure  => present,
    content => fluent_config($fluentd::config),
  }
}
