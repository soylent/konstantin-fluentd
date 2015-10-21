class fluentd::install inherits fluentd {
  # TODO: Add $repo_install param
  case $::osfamily {
    'redhat': {
      yumrepo { $fluentd::repo_name:
        baseurl  => $fluentd::repo_url,
        enabled  => $fluentd::repo_enabled,
        gpgcheck => $fluentd::repo_gpgcheck,
        gpgkey   => $fluentd::repo_gpgkey,
        notify   => Exec['rpmkey'],
        before   => Package[$fluentd::package_name],
      }

      exec { 'rpmkey':
        command     => "rpm --import ${fluentd::repo_gpgkey}",
        path        => '/usr/bin',
        refreshonly => true,
      }

      # TODO: Remove this dependency. Gem provider requires this package.
      package { 'rubygems':
        ensure => present,
      }
    }

    'debian': {
      apt::source { $fluentd::repo_name:
        location     => $fluentd::repo_url,
        repos        => 'contrib',
        architecture => 'amd64',
        release      => $fluentd::distro_codename,
        key          => {
          id     => $fluentd::repo_gpgkeyid,
          source => $fluentd::repo_gpgkey,
        },
        include      => {
          'src' => false,
          'deb' => true,
        },
        before       => Package[$fluentd::package_name],
      }
    }

    default: {
      fail("Upsupported osfamily ${::osfamily}")
    }
  }

  package { $fluentd::package_name:
    ensure  => $fluentd::package_ensure,
  }

  package { $fluentd::plugin_names:
    ensure   => $fluentd::plugin_ensure,
    provider => tdagent,
  }
}
