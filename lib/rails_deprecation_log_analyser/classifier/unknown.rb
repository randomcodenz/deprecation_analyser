# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class Unknown
      attr_reader :source_directory

      def initialize(source_directory)
        @source_directory = source_directory
      end

      def match?(line)
        true
      end

      def process(lines, filter)
        log_line = lines.take(1).first

        call_site = DeprecationCallSite.new(log_line, source_directory)

        warning = DeprecationWarning.new(
          deprecated: 'Unknown',
          summary: 'Unknown deprecation warning',
          message: filter.clean(log_line),
          call_site: call_site
        )

        ClassifierResult.new([log_line], warning)
      end
    end
  end
end