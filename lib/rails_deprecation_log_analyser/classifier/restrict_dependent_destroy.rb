# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class RestrictDependentDestory < Base
      def match?(log_line)
        log_line.include?('The error key `:\'restrict_dependent_destroy.many\'` has been deprecated and will be removed in Rails 5.1. Please use `:\'restrict_dependent_destroy.has_many\'` instead.')
      end

      protected

      def lines_to_consume
        1
      end

      def build_deprecation_warning(lines)
        warning = DeprecationWarning.new(
          deprecated: 'Restrict dependent destroy - many',
          summary: 'The error key `:\'restrict_dependent_destroy.many\'` has been deprecated and will be removed in Rails 5.1.',
          message: 'The error key `:\'restrict_dependent_destroy.many\'` has been deprecated and will be removed in Rails 5.1. Please use `:\'restrict_dependent_destroy.has_many\'` instead.',
          call_site: build_call_site(lines.first)
        )
      end
    end
  end
end
