# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class ConnectionTables < Base
      def match?(line)
        line.include?('#tables currently returns both tables and views. This behavior is deprecated and will be changed with Rails 5.1 to only return tables. Use #data_sources instead.')
      end

      def skip?
        true
      end

      protected

      def lines_to_consume
        1
      end
    end
  end
end