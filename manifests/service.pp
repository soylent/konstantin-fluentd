class fluentd::service inherits fluentd {
  service { $fluentd::service_name:
    ensure     => $fluentd::service_ensure,
    enable     => $fluentd::service_enable,
    hasstatus  => true,
    hasrestart => true,
  }
}
