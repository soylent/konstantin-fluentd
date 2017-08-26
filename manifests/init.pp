# Class fluentd install, configures and manages the fluentd (td-agent)
# service.
#
class fluentd (
  Boolean $repo_install = $::fluentd::params::repo_install,
  String $repo_name = $::fluentd::params::repo_name,
  String $repo_desc = $::fluentd::params::repo_desc,
  Stdlib::Httpurl $repo_url = $::fluentd::params::repo_url,
  Boolean $repo_enabled = $::fluentd::params::repo_enabled,
  Boolean $repo_gpgcheck = $::fluentd::params::repo_gpgcheck,
  Stdlib::Httpurl $repo_gpgkey = $::fluentd::params::repo_gpgkey,
  String $repo_gpgkeyid = $::fluentd::params::repo_gpgkeyid,
  String $package_name = $::fluentd::params::package_name,
  String $package_ensure = $::fluentd::params::package_ensure,
  String $service_name = $::fluentd::params::service_name,
  String $service_ensure = $::fluentd::params::service_ensure,
  Boolean $service_enable = $::fluentd::params::service_enable,
  Boolean $service_manage = $::fluentd::params::service_manage,
  Optional[String] $service_provider = $::fluentd::params::service_provider,
  Stdlib::Absolutepath $config_file = $::fluentd::params::config_file,
  Stdlib::Absolutepath $config_path = $::fluentd::params::config_path,
  String $config_owner = $::fluentd::params::config_owner,
  String $config_group = $::fluentd::params::config_group,
  Hash $configs = $::fluentd::params::configs,
  Hash $plugins = $::fluentd::params::plugins,
) inherits fluentd::params {
  contain fluentd::install
  contain fluentd::service

  Class['Fluentd::Install'] -> Class['Fluentd::Service']

  create_resources('fluentd::plugin', $plugins)
  create_resources('fluentd::config', $configs)
}
