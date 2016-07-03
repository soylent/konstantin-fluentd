include fluentd

fluentd::config { '500_basic.conf':
  config => {
    'source' => {
      'type' => 'forward',
      'port' => 24224,
    },
    'match'  => {
      'tag_pattern' => 'fluentd.test.**',
      'type'        => 'stdout',
    }
  }
}
