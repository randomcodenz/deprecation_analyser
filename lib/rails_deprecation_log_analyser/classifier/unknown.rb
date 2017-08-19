# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class Unknown < Base
      def match?(line)
        true
      end

      protected

      def lines_to_consume
        1
      end

      def build_deprecation_warning(lines)
        warning = DeprecationWarning.new(
          deprecated: 'Unknown',
          summary: 'Unknown deprecation warning',
          message: lines.first,
          call_site: build_call_site(lines.first)
        )
      end
    end
  end
end