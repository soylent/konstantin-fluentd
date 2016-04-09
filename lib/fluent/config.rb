# Generates Fluentd configuration from a Hash.
#
# @note This file must be compatible with Ruby 1.8.7 in order to work on EL6.
module FluentConfig
  BUILTIN_PARAMETERS = ['type', 'id', 'label', 'log_level'].freeze
  BUILTIN_PARAMETER_PREFIX = '@'.freeze
  TAG_PATTERN = 'tag_pattern'.freeze
  BODY_PADDING = '  '.freeze

  class << self
    # Generates Fluentd configuration from a Hash.
    #
    # @param config [Hash] the configuration
    # @return [String] the Fluentd configuration
    def generate(config, header = '')
      # @note Hash iteration order is arbitrary in ruby 1.8.7
      #   https://projects.puppetlabs.com/issues/16266
      config.keys.sort.inject(header.dup) do |result, plugin_type|
        plugin_configs = array_wrap(config.fetch(plugin_type))

        plugin_configs.each do |plugin_config|
          tag_pattern = plugin_config.delete(TAG_PATTERN)
          result << directive_tag(plugin_type, tag_pattern) do
            plugin_config.keys.sort.inject('') do |body, parameter|
              body << directive_body(parameter, plugin_config.fetch(parameter))
            end
          end
        end

        result
      end
    end

    private

    def array_wrap(value)
      if value.is_a?(Hash)
        [value]
      else
        Array(value)
      end
    end

    def directive_tag(name, attr)
      name_and_attr = [name, attr].compact.join(' ')
      body = left_pad(yield, BODY_PADDING) if block_given?
      "<#{name_and_attr}>\n#{body}</#{name}>\n"
    end

    def directive_body(parameter, value)
      if value.is_a?(Hash) || value.is_a?(Array)
        generate(parameter => value)
      else
        "#{format_parameter(parameter)} #{value}\n"
      end
    end

    def left_pad(text, padding)
      text.each_line.inject('') do |result, line|
        result << padding << line
      end
    end

    def format_parameter(parameter)
      if BUILTIN_PARAMETERS.include?(parameter)
        BUILTIN_PARAMETER_PREFIX + parameter
      else
        parameter
      end
    end
  end
end
