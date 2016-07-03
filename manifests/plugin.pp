define fluentd::plugin(
  $plugin_ensure          = $::fluentd::_plugin_ensure,
  $plugin_source          = $::fluentd::_plugin_source,
  $plugin_install_options = $::fluentd::_plugin_install_options,
  $plugin_provider        = $::fluentd::_plugin_provider,
) {
  include fluentd

  package { $title:
    ensure          => $plugin_ensure,
    source          => $plugin_source,
    install_options => $plugin_install_options,
    provider        => $plugin_provider,
    notify          => Class['Fluentd::Service'],
    require         => Class['Fluentd::Install'],
  }
}
