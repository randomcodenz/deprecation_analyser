# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class MimeTypeConstants < Base
      def match?(log_line)
        log_line.include?('Accessing mime types via constants is deprecated. Please change `Mime::HTML` to `Mime[:html]`.')
      end

      def process(lines, filter)
        log_line = lines.take(1).first

        warning = DeprecationWarning.new(
          :deprecated => 'Mime types via constants',
          :summary => 'Accessing mime types via constants is deprecated',
          :message => 'Accessing mime types via constants is deprecated. Please change `Mime::HTML` to `Mime[:html]`.',
          call_site: build_call_site(log_line)
        )

        ClassifierResult.new([log_line], warning)
      end
    end
  end
end