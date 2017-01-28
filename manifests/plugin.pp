define fluentd::plugin(
  String $plugin_ensure = present,
  Stdlib::Httpurl $plugin_source = 'https://rubygems.org',
  Array[Variant[String, Hash]] $plugin_install_options = [],
  String $plugin_provider = tdagent,
) {
  package { $title:
    ensure          => $plugin_ensure,
    source          => $plugin_source,
    install_options => $plugin_install_options,
    provider        => $plugin_provider,
    notify          => Class['Fluentd::Service'],
    require         => Class['Fluentd::Install'],
  }
}
