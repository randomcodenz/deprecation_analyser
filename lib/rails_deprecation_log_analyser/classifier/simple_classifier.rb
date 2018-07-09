# frozen_string_literal: true
require 'YAML'

module RailsDeprecationLogAnalyser
  module Classifier
    class SimpleClassifier < Base
      def initialize(source_directory, log_line_includes, lines_to_consume, deprecated, summary, message)
        super(source_directory)
        @log_line_includes = log_line_includes
        @lines_to_consume = lines_to_consume
        @deprecated = deprecated
        @summary = summary
        @message = message
      end

      def self.register(source_directory, registry)
        classifiers_config = YAML.load_file(File.join(__dir__, 'simple_classifiers.yml'))

        classifiers_config.each do |name, config|
          classifier = new(
            source_directory,
            config.fetch('log_line_includes'),
            config.fetch('lines_to_consume'),
            config.fetch('deprecated'),
            config.fetch('summary'),
            config.fetch('message'),
          )
          registry.register(name: name, classifier: classifier)
        end
      end

      def match?(log_line)
        log_line.include?(log_line_includes)
      end

      protected

      attr_reader :lines_to_consume

      def build_deprecation_warning(lines)
        warning = DeprecationWarning.new(
          deprecated: deprecated,
          summary: summary,
          message: message,
          call_site: build_call_site(lines.last)
        )
      end

      private

      attr_reader :log_line_includes, :deprecated, :summary, :message
    end
  end
end
