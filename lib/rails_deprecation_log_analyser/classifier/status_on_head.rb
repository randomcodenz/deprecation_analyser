# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class StatusOnHead < Base
      def match?(log_line)
        log_line.include?('The :status option on `head` has been deprecated')
      end

      protected

      def lines_to_consume
        1
      end

      def build_deprecation_warning(lines)
        warning = DeprecationWarning.new(
          deprecated: ':status option on `head`',
          summary: 'The :status option on `head` has been deprecated and will be removed in Rails 5.1.',
          message: 'The :status option on `head` has been deprecated and will be removed in Rails 5.1. Please pass the status as a separate parameter before the options, instead.',
          call_site: build_call_site(lines.first)
        )
      end
    end
  end
end
