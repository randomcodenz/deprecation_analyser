# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  class Configuration

    attr_reader :source_directory

    def initialize(parser_config, formatters, source_directory)
      @parser_config = parser_config
      @classifiers = []
      @formatters = formatters
      @source_directory = source_directory
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
      Classifier::Unknown.new(source_directory)
    end
  end
end