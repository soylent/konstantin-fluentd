include fluentd

fluentd::plugin { 'fluent-plugin-elasticsearch': }

fluentd::config { '500_elasticsearch.conf':
  config => {
    'source' => [
      {
        'type' => 'forward',
      },
      {
        'type' => 'syslog',
        'port' => 42185,
        'tag'  => 'syslog',
      },
    ],
    'match'  => {
      'tag_pattern'     => 'syslog.**',
      'type'            => 'elasticsearch',
      'logstash_format' => true,
      'index_name'      => 'foo',
      'type_name'       => 'bar',
    }
  }
}
