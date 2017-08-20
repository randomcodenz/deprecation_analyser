# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class RedirectToBack < Base
      def match?(log_line)
        log_line.include?('`redirect_to :back` is deprecated and will be removed from Rails 5.1. Please use `redirect_back(fallback_location: fallback_location)` where `fallback_location` represents the location to use if the request has no HTTP referer information.')
      end

      protected

      def lines_to_consume
        1
      end

      def build_deprecation_warning(lines)
        warning = DeprecationWarning.new(
          deprecated: '`redirect_to :back` is deprecated',
          summary: '`redirect_to :back` is deprecated and will be removed from Rails 5.1.',
          message: '`redirect_to :back` is deprecated and will be removed from Rails 5.1. Please use `redirect_back(fallback_location: fallback_location)` where `fallback_location` represents the location to use if the request has no HTTP referer information.',
          call_site: build_call_site(lines.first)
        )
      end
    end
  end
end
