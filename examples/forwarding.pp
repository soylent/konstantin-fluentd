include fluentd

fluentd::config { '600_forwarding.conf':
  config => {
    'source' => {
      'type' => unix,
      'path' => '/tmp/td-agent/td-agent.sock',
    },
    'match'  => {
      'tag_pattern' => '**',
      'type'        => forward,
      'server'      => [
        { 'host' => 'example1.com', 'port' => 24224 },
        { 'host' => 'example2.com', 'port' => 24224 },
      ]
    }
  }
}
