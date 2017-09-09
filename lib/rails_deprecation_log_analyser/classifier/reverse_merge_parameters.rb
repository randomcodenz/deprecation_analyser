# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class ReverseMergeParameters < Base
      def match?(log_line)
        log_line.include?('Method reverse_merge is deprecated and will be removed in Rails 5.1, as `ActionController::Parameters` no longer inherits from hash.')
      end

      protected

      def lines_to_consume
        1
      end

      def build_deprecation_warning(lines)
        warning = DeprecationWarning.new(
          deprecated: 'ActionController::Parameters#reverse_merge',
          summary: 'Method reverse_merge is deprecated and will be removed in Rails 5.1, as `ActionController::Parameters` no longer inherits from hash.',
          message: 'Method reverse_merge is deprecated and will be removed in Rails 5.1, as `ActionController::Parameters` no longer inherits from hash. Use one of these documented methods which are not deprecated: http://api.rubyonrails.org/v5.0.3/classes/ActionController/Parameters.html',
          call_site: build_call_site(lines.first)
        )
      end
    end
  end
end
