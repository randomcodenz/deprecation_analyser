# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class ConnectionTables < Base
      def match?(line)
        line.include?('#tables currently returns both tables and views. This behavior is deprecated and will be changed with Rails 5.1 to only return tables. Use #data_sources instead.')
      end

      def process(lines, filter)
        log_line = lines.take(1).first

        # Supress the deprecation by returning nil deprecation warning
        # TODO: Supression of warnings should be done somewhere else
        ClassifierResult.new([log_line], nil)
      end
    end
  end
end