define fluentd::plugin(
  $plugin_ensure          = $fluentd::plugin_ensure,
  $plugin_source          = $fluentd::plugin_source,
  $plugin_install_options = $fluentd::plugin_install_options,
) {
  package { $title:
    ensure          => $plugin_ensure,
    source          => $plugin_source,
    install_options => $plugin_install_options,
    provider        => tdagent,
    notify          => Class['Fluentd::Service'],
    require         => Class['Fluentd::Install'],
  }
}
