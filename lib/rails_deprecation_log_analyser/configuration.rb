# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  class Configuration

    def initialize(parser_config, formatters, source_directory)
      @parser_config = parser_config
      @formatters = formatters

      source_directory = source_directory || ''
      @classifiers = build_classifiers(source_directory)
      @unknown = build_unknown(source_directory)
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

    attr_reader :parser_config, :classifiers, :formatters, :unknown

    def build_classifiers(source_directory)
      [
        Classifier::ConnectionTables.new(source_directory),
        Classifier::MimeTypeConstants.new(source_directory)
      ]
    end

    def build_unknown(source_directory)
      Classifier::Unknown.new(source_directory)
    end
  end
end