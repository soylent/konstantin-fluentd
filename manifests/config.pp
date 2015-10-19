class fluentd::config inherits fluentd {
  file { $fluentd::config_file:
    ensure  => present,
    content => template($fluentd::config_template),
  }
}
