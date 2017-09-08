# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class XhrXmlHttpRequest < Base
      def match?(log_line)
        log_line.include?('`xhr` and `xml_http_request` are deprecated')
      end

      protected

      def lines_to_consume
        3
      end

      def build_deprecation_warning(lines)
        warning = DeprecationWarning.new(
          deprecated: 'xhr and xml_http_request',
          summary: '`xhr` and `xml_http_request` are deprecated and will be removed in Rails 5.1',
          message: '`xhr` and `xml_http_request` are deprecated and will be removed in Rails 5.1. Switch to e.g. `post :create, ..., xhr: true`',
          call_site: build_call_site(lines.last)
        )
      end
    end
  end
end
