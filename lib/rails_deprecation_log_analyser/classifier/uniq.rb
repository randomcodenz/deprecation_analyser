# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class Uniq < Base
      def match?(log_line)
        log_line.include?('uniq is deprecated and will be removed from Rails 5.1')
      end

      protected

      def lines_to_consume
        1
      end

      def build_deprecation_warning(lines)
        warning = DeprecationWarning.new(
          deprecated: 'uniq',
          summary: 'uniq is deprecated and will be removed from Rails 5.1',
          message: 'uniq is deprecated and will be removed from Rails 5.1, use distinct instead',
          call_site: build_call_site(lines.first)
        )
      end
    end
  end
end
