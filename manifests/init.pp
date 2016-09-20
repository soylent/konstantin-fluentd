# Class fluentd install, configures and manages the fluentd (td-agent)
# service.
#
class fluentd (
  $repo_install = $::fluentd::params::repo_install,
  $repo_name = $::fluentd::params::repo_name,
  $repo_desc = $::fluentd::params::repo_desc,
  $repo_url = $::fluentd::params::repo_url,
  $repo_enabled = $::fluentd::params::repo_enabled,
  $repo_gpgcheck = $::fluentd::params::repo_gpgcheck,
  $repo_gpgkey = $::fluentd::params::repo_gpgkey,
  $repo_gpgkeyid = $::fluentd::params::repo_gpgkeyid,
  $package_name = $::fluentd::params::package_name,
  $package_ensure = $::fluentd::params::package_ensure,
  $plugin_names = undef,
  $plugin_ensure = undef,
  $plugin_source = undef,
  $plugin_install_options = undef,
  $plugin_provider = undef,
  $service_name = $::fluentd::params::service_name,
  $service_ensure = $::fluentd::params::service_ensure,
  $service_enable = $::fluentd::params::service_enable,
  $service_manage = $::fluentd::params::service_manage,
  $config_file = $::fluentd::params::config_file,
  $config_path = $::fluentd::params::config_path,
  $config_owner = $::fluentd::params::config_owner,
  $config_group = $::fluentd::params::config_group,
) inherits fluentd::params {

  validate_bool($repo_install)
  validate_string($repo_name)
  validate_string($repo_url)
  validate_bool($repo_enabled)
  validate_bool($repo_gpgcheck)
  validate_string($repo_gpgkey)
  validate_string($repo_gpgkeyid)
  validate_string($package_name)
  validate_string($package_ensure)
  validate_string($service_name)
  validate_string($service_ensure)
  validate_bool($service_enable)
  validate_bool($service_manage)
  validate_absolute_path($config_file)
  validate_string($config_owner)
  validate_string($config_group)

  if $plugin_names {
    validate_array($plugin_names)
    warning('$plugin_names is deprecated and will be removed in the next release.')
  }

  if $plugin_ensure {
    validate_string($plugin_ensure)
    warning('$plugin_ensure is deprecated and will be removed in the next release.')
    $_plugin_ensure = $plugin_ensure
  } else {
    $_plugin_ensure = $::fluentd::params::plugin_ensure
  }

  if $plugin_source {
    validate_string($plugin_source)
    warning('$plugin_source is deprecated and will be removed in the next release.')
    $_plugin_source = $plugin_source
  } else {
    $_plugin_source = $::fluentd::params::plugin_source
  }

  if $plugin_install_options {
    warning('$plugin_install_options is deprecated and will be removed in the next release.')
    $_plugin_install_options = $plugin_install_options
  } else {
    $_plugin_install_options = $::fluentd::params::plugin_install_options
  }

  if $plugin_provider {
    validate_string($plugin_provider)
    warning('$plugin_provider is deprecated and will be removed in the next release.')
    $_plugin_provider = $plugin_provider
  } else {
    $_plugin_provider = $::fluentd::params::plugin_provider
  }

  contain fluentd::install
  contain fluentd::service

  Class['Fluentd::Install'] ->
  Class['Fluentd::Service']
}
