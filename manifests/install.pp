class fluentd::install inherits fluentd {
  case $::osfamily {
    'RedHat': {
      yumrepo { $fluentd::repo_name:
        baseurl  => $fluentd::repo_baseurl,
        enabled  => $fluentd::repo_enabled,
        gpgcheck => $fluentd::repo_gpgcheck,
        gpgkey   => $fluentd::repo_gpgkey,
        notify   => Exec['rpmkey'],
      }

      exec { 'rpmkey':
        command     => "rpm --import ${fluentd::repo_gpgkey}",
        path        => '/usr/bin',
        refreshonly => true,
      }

      package { $fluentd::package_name:
        ensure  => $fluentd::package_ensure,
        require => Yumrepo[$fluentd::repo_name],
      }

      package { $fluentd::plugin_names:
        ensure   => $fluentd::plugin_ensure,
        provider => tdagent,
        require  => [Package[$fluentd::package_name], Package['rubygems']],
      }

      # TODO: Remove this dependency. Gem provider requires this package.
      package { 'rubygems':
        ensure => present,
      }

    }
    default: {
      fail("${::osfamily} based system is not supported")
    }
  }
}
