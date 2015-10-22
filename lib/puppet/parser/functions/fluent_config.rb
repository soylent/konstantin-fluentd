module Puppet::Parser::Functions
  newfunction(:fluent_plugin_config, type: :rvalue) do |args|
    plugin_type = args[0]
    plugin_config = args[1]

    tag_pattern = plugin_config.delete('tag_pattern')

    config_body = plugin_config.each_with_object('') do |(key, value), result|
      if value.is_a?(Array)
        value.each do |plugin_sub_config|
          result << function_fluent_plugin_config([key, plugin_sub_config])
        end
      else
        result << [key, value].join(' ') << "\n"
      end
    end

    config_format = %{
      <%<plugin_type>s %<tag_pattern>s>
        %<config_body>s
      </%<plugin_type>s>
    }

    format(config_format,
      plugin_type: plugin_type,
      tag_pattern: tag_pattern,
      config_body: config_body
    )
  end

  newfunction(:fluent_config, type: :rvalue) do |args|
    config = args[0]

    config.each_with_object('') do |(plugin_type, plugin_configs), result|
      plugin_configs.each do |plugin_config|
        result << function_fluent_plugin_config([plugin_type, plugin_config])
      end
    end
  end
end
