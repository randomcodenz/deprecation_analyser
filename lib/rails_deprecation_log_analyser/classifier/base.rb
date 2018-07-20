# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class Base
      attr_reader :source_directory

      def initialize(source_directory)
        @source_directory = source_directory
      end

      def self.register(source_directory, registry)
        class_name = name.gsub(/^.*::/, '')
        registry.register(name: class_name, classifier: new(source_directory))
      end

      def process(cursor, filter)
        lines = cursor.take(lines_to_consume)

        skip(lines) || classifiy(lines, filter)
      end

      def skip?
        false
      end

      protected

      def build_call_site(log_line)
        DeprecationCallSite.new(log_line, source_directory)
      end

      def skip(lines)
        return unless skip?

        ClassifierResult.new(lines, nil)
      end

      def classifiy(lines, filter)
        return if skip?

        clean_lines = [filter.clean(lines[0])]
        clean_lines.concat(lines[1..-1])

        warning = build_deprecation_warning(clean_lines)

        ClassifierResult.new(lines, warning)
      end
    end
  end
end