# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class WithIndifferentAccess < Base
      def match?(log_line)
        log_line.include?('Method with_indifferent_access is deprecated and will be removed in Rails 5.1, as `ActionController::Parameters` no longer inherits from hash.')
      end

      protected

      def lines_to_consume
        1
      end

      def build_deprecation_warning(lines)
        warning = DeprecationWarning.new(
          deprecated: 'Method with_indifferent_access on ActionController::Parameters',
          summary: 'Method with_indifferent_access on ActionController::Parameters is deprecated. Using this deprecated behavior exposes potential security problems.',
          message: 'Method with_indifferent_access on ActionController::Parameters is deprecated. Instead, consider using one of these documented methods which are not deprecated: http://api.rubyonrails.org/v5.0.3/classes/ActionController/Parameters.html',
          call_site: build_call_site(lines.first)
        )
      end
    end
  end
end
