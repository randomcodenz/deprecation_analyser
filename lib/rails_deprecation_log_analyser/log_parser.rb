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
      lines = configuration.log_lines

      loop do
        index = lines.index
        filter = configuration.find_filter(lines.peek)

        classify(lines, filter)

        if lines.index == index
          raise StalledParserError, 'log line enumerator has not advanced within a loop iteration'
        end
      end
    end

    private

    def classify(lines, filter)
      log_other(lines, filter)
      log_deprecation_warning(lines, filter)
    end

    def log_other(lines, filter)
      return unless filter.nil?

      configuration.log_analysis.other(lines.take.first)
    end

    def log_deprecation_warning(lines, filter)
      return if filter.nil?

      classifier = configuration.find_classifier(lines.peek)
      classifier_result = classifier.process(lines, filter)
      configuration.log_analysis.deprecation_warning(classifier_result)
    end
  end
end