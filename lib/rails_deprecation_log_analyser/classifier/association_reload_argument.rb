# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class AssociationReloadArgument < Base
      def match?(log_line)
        log_line.include?('Passing an argument to force an association to reload')
      end

      protected

      def lines_to_consume
        1
      end

      def build_deprecation_warning(lines)
        warning = DeprecationWarning.new(
          deprecated: 'Association reload argument',
          summary: 'Passing an argument to force an association to reload is now deprecated and will be removed in Rails 5.1.',
          message: 'Passing an argument to force an association to reload is now deprecated and will be removed in Rails 5.1. Please call `reload` on the result collection proxy instead.',
          call_site: build_call_site(lines.first)
        )
      end
    end
  end
end
