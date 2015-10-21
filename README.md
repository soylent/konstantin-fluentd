# Fluentd

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Install, configure, and manage Fluentd data collector.

## Module Description

* Installs `td-agent` RPM package
* Generates configuration file `td-agent.conf`
* Manages `td-agent` service
* Installs Fluentd gem plugins

## Usage

```puppet
class { 'fluentd':
  plugin_names => ['fluent-plugin-elasticsearch'],
  config       => {
    source => [
      {
        type => 'unix',
        path => '/tmp/fluent.sock'
      }
    ],
    match  => [
      {
        tag_pattern     => '**',
        type            => 'elasticsearch',
        index_name      => 'foo',
        type_name       => 'bar',
        logstash_format => true
      }
    ]
  }
}
```

## Reference

### Classes

#### Public Classes

* `fluentd`: Main class, includes all other classes.

#### Private Classes

* `fluentd::install`: Handles the packages.
* `fluentd::config`: Handles the configuration file.
* `fluentd::service`: Handles the service.

### Parameters

The following parameters are available in the `fluentd` class:

#### `repo_name`

Default value: 'treasuredata'

#### `repo_url`

Default value: 'http://packages.treasuredata.com/2/redhat/$releasever/$basearch'

#### `repo_enabled`

Default value: true

#### `repo_gpgcheck`

Default value: true

#### `repo_gpgkey`

Default value: 'https://packages.treasuredata.com/GPG-KEY-td-agent'

#### `repo_gpgkeyid`

Default value: 'C901622B5EC4AF820C38AB861093DB45A12E206F'

#### `package_name`

Default value: 'td-agent'

#### `package_ensure`

Default value: present

#### `plugin_names`

Default value: []

#### `plugin_ensure`

Default value: present

#### `service_name`

Default value: 'td-agent'

#### `service_ensure`

Default value: running

#### `service_enable`

Default value: true

#### `service_manage`

Default value: true

#### `config_file`

Default value: '/etc/td-agent/td-agent.conf'

#### `config_template`

Default value: 'fluentd/td-agent.conf.erb'

#### `config`

## Limitations

Tested only on CentOS 7, Ubuntu 14.04, Debian 7.8

## Development

Bug reports and pull requests are welcome!

### TODO:

* Support Ubuntu
* Support Debian
* Support Fluentd filter plugins
* Remove `rubygems` package dependency
