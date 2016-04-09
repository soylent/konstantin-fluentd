require 'fluent/config'
require 'active_support/core_ext/string/strip'

RSpec.describe FluentConfig do
  example do
    empty_config = {}
    fluent_config = described_class.generate(empty_config)
    expect(fluent_config).to be_empty
  end

  example do
    fluent_config = described_class.generate(
      'source' => {
        'type' => 'forward',
        'port' => 24224
      }
    )

    expect(fluent_config).to eq <<-CONFIG.strip_heredoc
      <source>
        port 24224
        @type forward
      </source>
    CONFIG
  end

  example do
    fluent_config = described_class.generate(
      'match' => {
        'path' => '/var/log/fluent/access',
        'tag_pattern' => 'myapp.access',
        'type' => 'file'
      }
    )

    expect(fluent_config).to eq <<-CONFIG.strip_heredoc
      <match myapp.access>
        path /var/log/fluent/access
        @type file
      </match>
    CONFIG
  end

  example do
    fluent_config = described_class.generate(
      'filter' => {
        'tag_pattern' => 'myapp.access',
        'type' => 'record_transformer',
        'record' => {
          'host_param' => '"#{Socket.gethostname}"'
        }
      }
    )

    expect(fluent_config).to eq <<-CONFIG.strip_heredoc
      <filter myapp.access>
        <record>
          host_param "\#{Socket.gethostname}"
        </record>
        @type record_transformer
      </filter>
    CONFIG
  end

  example do
    fluent_config = described_class.generate(
      'match' => {
        'tag_pattern' => 'pattern',
        'type' => 'roundrobin',
        'store' => [
          {
            'type' => 'tcp',
            'host' => '192.168.1.21'
          },
          {
            'type' => 'tcp',
            'host' => '192.168.1.22'
          }
        ]
      }
    )

    expect(fluent_config).to eq <<-CONFIG.strip_heredoc
      <match pattern>
        <store>
          host 192.168.1.21
          @type tcp
        </store>
        <store>
          host 192.168.1.22
          @type tcp
        </store>
        @type roundrobin
      </match>
    CONFIG
  end

  example do
    fluent_config = described_class.generate(
      'source' => {
        'type' => 'tail',
        'label' => '@SYSTEM'
      },
      'label' => {
        'tag_pattern' => '@SYSTEM',
        'filter' => {
          'tag_pattern' => 'var.log.middleware.**',
          'type' => 'grep'
        },
        'match' => {
          'tag_pattern' => '**',
          'type' => 's3'
        }
      }
    )

    expect(fluent_config).to eq <<-CONFIG.strip_heredoc
      <label @SYSTEM>
        <filter var.log.middleware.**>
          @type grep
        </filter>
        <match **>
          @type s3
        </match>
      </label>
      <source>
        @label @SYSTEM
        @type tail
      </source>
    CONFIG
  end

  example do
    fluent_config = described_class.generate(
      'match' => [
        { 'tag_pattern' => 'tag.9', 'type' => 'stdout' },
        { 'tag_pattern' => 'tag.0', 'type' => 'stdout' }
      ]
    )

    expect(fluent_config).to eq <<-CONFIG.strip_heredoc
      <match tag.9>
        @type stdout
      </match>
      <match tag.0>
        @type stdout
      </match>
    CONFIG
  end
end
