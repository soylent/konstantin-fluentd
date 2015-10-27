include fluentd

fluentd::plugin { 'fluent-plugin-elasticsearch': }

fluentd::config { 'elasticsearch.conf':
  config => {
    'source' => {
      'type' => 'unix',
      'path' => '/tmp/fluent.sock',
    },
    'match'  => {
      'tag_pattern'     => '**',
      'type'            => 'elasticsearch',
      'index_name'      => 'foo',
      'type_name'       => 'bar',
      'logstash_format' => true,
    }
  }
}
