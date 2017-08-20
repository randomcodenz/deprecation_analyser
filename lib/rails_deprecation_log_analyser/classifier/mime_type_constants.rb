# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class MimeTypeConstants < Base
      def match?(log_line)
        log_line.include?('Accessing mime types via constants is deprecated.')
      end

      protected

      def lines_to_consume
        1
      end

      def build_deprecation_warning(lines)
        warning = DeprecationWarning.new(
          deprecated: 'Mime types via constants',
          summary: 'Accessing mime types via constants is deprecated',
          message: 'Accessing mime types via constants is deprecated. ' + correction(lines.first),
          call_site: build_call_site(lines.first)
        )
      end

      private

      def correction(line)
        if line.include?('Mime::HTML')
          'Please change `Mime::HTML` to `Mime[:html]`.'
        else
          'Please change `Mime::JS` to `Mime[:js]`.'
        end
      end
    end
  end
end