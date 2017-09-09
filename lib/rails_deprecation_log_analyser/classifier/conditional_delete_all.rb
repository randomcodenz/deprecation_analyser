# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class ConditionalDeleteAll < Base
      def match?(log_line)
        log_line.include?('Passing conditions to delete_all is deprecated')
      end

      protected

      def lines_to_consume
        1
      end

      def build_deprecation_warning(lines)
        warning = DeprecationWarning.new(
          deprecated: 'Conditional delete_all',
          summary: 'Passing conditions to delete_all is deprecated and will be removed in Rails 5.1.',
          message: 'Passing conditions to delete_all is deprecated and will be removed in Rails 5.1. To achieve the same use where(conditions).delete_all.',
          call_site: build_call_site(lines.first)
        )
      end
    end
  end
end
