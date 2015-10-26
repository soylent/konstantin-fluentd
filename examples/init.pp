class { 'fluentd':
  config  => {
    source => [
      {
        type => 'unix',
        path => '/tmp/fluent.sock'
      }
    ],
    match => [
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

fluentd::plugin { 'fluent-plugin-elasticsearch': }
