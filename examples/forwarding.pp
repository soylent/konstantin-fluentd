include fluentd

fluentd::config { '600_forwarding.conf':
  config => {
    'source' => {
      'type' => unix,
      'path' => '/tmp/td-agent/td-agent.sock',
    },
    'match'  => {
      'tag_pattern' => 'test.*',
      'type'        => forward,
      'server'      => [
        {
          'host' => 'localhost',
          'port' => 24224
        },
        {
          'host' => 'localhost',
          'port' => 24225
        },
      ]
    }
  }
}
