# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  class Configuration

    def initialize(parser_config, formatters)
      @parser_config = parser_config
      @classifiers = []
      @formatters = formatters
    end

    def log_lines
      @log_lines = LogLineEnumerator.new(parser_config.log_lines)
    end

    def find_filter(line)
      parser_config.filters.detect { |f| f.match?(line) }
    end

    def find_classifier(line)
      classifiers.detect { |c| c.match?(line) } || unknown
    end

    def log_analysis
      @log_analysis ||= LogAnalysis.new(formatters)
    end

    private

    attr_reader :parser_config, :classifiers, :formatters

    def unknown
      Classifier::Unknown.new
    end
  end
end