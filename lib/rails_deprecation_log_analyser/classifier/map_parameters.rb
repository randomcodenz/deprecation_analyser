# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class MapParameters < Base
      def match?(log_line)
        log_line.include?('Method map is deprecated and will be removed in Rails 5.1, as `ActionController::Parameters` no longer inherits from hash. Using this deprecated behavior exposes potential security problems. If you continue to use this method you may be creating a security vulnerability in your app that can be exploited.')
      end

      protected

      def lines_to_consume
        1
      end

      def build_deprecation_warning(lines)
        warning = DeprecationWarning.new(
          deprecated: 'ActionController::Parameters#map',
          summary: 'Method map is deprecated and will be removed in Rails 5.1, as `ActionController::Parameters` no longer inherits from hash. Using this deprecated behavior exposes potential security problems. If you continue to use this method you may be creating a security vulnerability in your app that can be exploited.',
          message: 'Method map is deprecated and will be removed in Rails 5.1, as `ActionController::Parameters` no longer inherits from hash. Using this deprecated behavior exposes potential security problems. If you continue to use this method you may be creating a security vulnerability in your app that can be exploited. Instead, consider using one of these documented methods which are not deprecated: http://api.rubyonrails.org/v5.0.3/classes/ActionController/Parameters.html',
          call_site: build_call_site(lines.first)
        )
      end
    end
  end
end
