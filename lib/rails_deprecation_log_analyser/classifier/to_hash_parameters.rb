# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class ToHashParameters < Base
      def match?(log_line)
        log_line.include?('#to_hash unexpectedly ignores parameter filtering, and will change to enforce it in Rails 5.1. Enable `raise_on_unfiltered_parameters` to respect parameter filtering, which is the default in new applications. For the existing deprecated behaviour, call #to_unsafe_h instead.')
      end

      protected

      def lines_to_consume
        1
      end

      def build_deprecation_warning(lines)
        warning = DeprecationWarning.new(
          deprecated: '#to_hash on parameters',
          summary: '#to_hash unexpectedly ignores parameter filtering, and will change to enforce it in Rails 5.1.',
          message: '#to_hash unexpectedly ignores parameter filtering, and will change to enforce it in Rails 5.1. Enable `raise_on_unfiltered_parameters` to respect parameter filtering, which is the default in new applications. For the existing deprecated behaviour, call #to_unsafe_h instead.',
          call_site: build_call_site(lines.first)
        )
      end
    end
  end
end
