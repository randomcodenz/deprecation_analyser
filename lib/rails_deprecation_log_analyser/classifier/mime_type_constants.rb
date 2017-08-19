# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class MimeTypeConstants < Base
      def match?(log_line)
        log_line.include?('Accessing mime types via constants is deprecated. Please change `Mime::HTML` to `Mime[:html]`.')
      end

      protected

      def lines_to_consume
        1
      end

      def build_deprecation_warning(lines)
        warning = DeprecationWarning.new(
          deprecated: 'Mime types via constants',
          summary: 'Accessing mime types via constants is deprecated',
          message: 'Accessing mime types via constants is deprecated. Please change `Mime::HTML` to `Mime[:html]`.',
          call_site: build_call_site(lines.first)
        )
      end
    end
  end
end