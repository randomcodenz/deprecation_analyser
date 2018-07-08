# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class Base
      attr_reader :source_directory

      def initialize(source_directory)
        @source_directory = source_directory
      end

      def self.register(source_directory, registry)
        registry.register(new(source_directory))
      end

      def process(cursor, filter)
        lines = cursor.take(lines_to_consume)

        clean_lines = [filter.clean(lines[0])]
        clean_lines.concat(lines[1..-1])

        warning = build_deprecation_warning(clean_lines)

        ClassifierResult.new(lines, warning)
      end

      protected

      def build_call_site(log_line)
        DeprecationCallSite.new(log_line, source_directory)
      end
    end
  end
end