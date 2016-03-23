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
  $plugin_names = $::fluentd::params::plugin_names,
  $plugin_ensure = $::fluentd::params::plugin_ensure,
  $plugin_source = $::fluentd::params::plugin_source,
  $plugin_install_options = $::fluentd::params::plugin_install_options,
  $service_name = $::fluentd::params::service_name,
  $service_ensure = $::fluentd::params::service_ensure,
  $service_enable = $::fluentd::params::service_enable,
  $service_manage = $::fluentd::params::service_manage,
  $config_file = $::fluentd::params::config_file,
) inherits fluentd::params {

  # Param validations
  validate_bool($repo_install)
  validate_string($repo_name)
  validate_string($repo_url)
  validate_bool($repo_enabled)
  validate_bool($repo_gpgcheck)
  validate_string($repo_gpgkey)
  validate_string($repo_gpgkeyid)
  validate_string($package_name)
  validate_string($package_ensure)
  validate_array($plugin_names)
  validate_string($plugin_ensure)
  validate_string($plugin_source)
  validate_string($service_name)
  validate_string($service_ensure)
  validate_bool($service_enable)
  validate_bool($service_manage)
  validate_absolute_path($config_file)

  contain fluentd::install
  contain fluentd::service

  Class['Fluentd::Install'] ->
  Class['Fluentd::Service']
}
