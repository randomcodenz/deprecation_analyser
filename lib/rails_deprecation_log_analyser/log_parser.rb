# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  class LogParser
    class StalledParserError < StandardError
    end

    attr_reader :configuration

    def initialize(configuration)
      @configuration = configuration
    end

    def parse
      cursor = configuration.log_cursor

      loop do
        index = cursor.index
        filter = configuration.find_filter(cursor.peek)

        classify(cursor, filter)

        if cursor.index == index
          raise StalledParserError, 'log cursor has not advanced within a loop iteration'
        end
      end
    end

    private

    def classify(cursor, filter)
      log_other(cursor, filter)
      log_deprecation_warning(cursor, filter)
    end

    def log_other(cursor, filter)
      return unless filter.nil?

      configuration.log_analysis.other(cursor.take.first)
    end

    def log_deprecation_warning(cursor, filter)
      return if filter.nil?

      classifier = configuration.find_classifier(cursor.peek)
      classifier_result = classifier.process(cursor, filter)
      configuration.log_analysis.deprecation(classifier_result)
    end
  end
end