# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class EqualityComparisonBeweenParametersAndHash < Base
      def match?(log_line)
        log_line.include?('Comparing equality between `ActionController::Parameters` and a `Hash` is deprecated and will be removed in Rails 5.1.')
      end

      protected

      def lines_to_consume
        1
      end

      def build_deprecation_warning(lines)
        warning = DeprecationWarning.new(
          deprecated: 'Equality comparison between `ActionController::Parameters` and `Hash`',
          summary: 'Comparing equality between `ActionController::Parameters` and a `Hash` is deprecated and will be removed in Rails 5.1.',
          message: 'Comparing equality between `ActionController::Parameters` and a `Hash` is deprecated and will be removed in Rails 5.1. Please only do comparisons between instances of `ActionController::Parameters`. If you need to compare to a hash, first convert it using `ActionController::Parameters#new`.',
          call_site: build_call_site(lines.first)
        )
      end
    end
  end
end
