class fluentd (
  $repo_name = $fluentd::repo_name,
  $repo_baseurl = $fluentd::repo_baseurl,
  $repo_enabled = $fluentd::repo_enabled,
  $repo_gpgcheck = $fluentd::repo_gpgcheck,
  $repo_gpgkey = $fluentd::repo_gpgkey,
  $package_name = $fluentd::package_name,
  $package_ensure = $fluentd::package_ensure,
  $plugin_names = $fluentd::plugin_names,
  $plugin_ensure = $fluentd::plugin_ensure,
  $service_name = $fluentd::service_name,
  $service_ensure = $fluentd::service_ensure,
  $service_enable = $fluentd::service_enable,
  $config_file = $fluentd::config_file,
  $config_template = $fluentd::config_template,
  $config = $fluentd::params::config,
) inherits fluentd::params {

  contain fluentd::install
  contain fluentd::config
  contain fluentd::service

  Class['Fluentd::Install'] ->
  Class['Fluentd::Config'] ~>
  Class['Fluentd::Service']
}
