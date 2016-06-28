class fluentd::install inherits fluentd {
  if $fluentd::repo_install {
    require fluentd::install_repo
  }

  package { $fluentd::package_name:
    ensure => $fluentd::package_ensure,
  } ->

  file { $fluentd::config_path:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    recurse => true,
    force   => true,
    purge   => true,
  } ->

  file { $fluentd::config_file:
    ensure => present,
    source => 'puppet:///modules/fluentd/td-agent.conf',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }
}
