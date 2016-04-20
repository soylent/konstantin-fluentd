require File.expand_path('../../../../fluent/config', __FILE__)

module Puppet::Parser::Functions
  # Generates Fluentd configuration from Hash.
  newfunction(:fluent_config, :type => :rvalue) do |args|
    header = "# This file is managed by Puppet, do not edit manually.\n"
    FluentConfig.generate(args.first, header)
  end
end
