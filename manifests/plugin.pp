define fluentd::plugin(
  $plugin_ensure          = present,
  $plugin_source          = 'https://rubygems.org',
  $plugin_install_options = [],
  $plugin_provider        = tdagent,
) {
  validate_string($plugin_ensure)
  validate_string($plugin_source)
  validate_string($plugin_provider)

  package { $title:
    ensure          => $plugin_ensure,
    source          => $plugin_source,
    install_options => $plugin_install_options,
    provider        => $plugin_provider,
    notify          => Class['Fluentd::Service'],
    require         => Class['Fluentd::Install'],
  }
}
