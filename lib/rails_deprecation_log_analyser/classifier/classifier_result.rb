# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class ClassifierResult
      attr_reader :log_lines, :deprecation_warning

      def initialize(log_lines, deprecation_warning = nil)
        @log_lines = log_lines
        @deprecation_warning = deprecation_warning
      end

      def digest
        Digest::SHA1.hexdigest(digest_content)
      end

      private

      def digest_content
        deprecation_warning_digest_content
          .concat(log_lines)
          .join
      end

      def deprecation_warning_digest_content
        return [] if deprecation_warning.nil?

        [
          deprecation_warning.deprecated,
          deprecation_warning.summary,
          deprecation_warning.message,
          deprecation_warning.method,
          deprecation_warning.file,
          deprecation_warning.line_number
        ]
      end
    end
  end
end