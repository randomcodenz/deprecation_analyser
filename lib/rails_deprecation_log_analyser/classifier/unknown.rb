# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class Unknown < Base
      def match?(line)
        true
      end

      def process(lines, filter)
        log_line = lines.take(1).first

        warning = DeprecationWarning.new(
          deprecated: 'Unknown',
          summary: 'Unknown deprecation warning',
          message: filter.clean(log_line),
          call_site: build_call_site(log_line)
        )

        ClassifierResult.new([log_line], warning)
      end
    end
  end
end