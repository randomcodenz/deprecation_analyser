# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class StringConditionalOptions < Base
      def match?(log_line)
        log_line.include?('Passing string to be evaluated in :if and :unless conditional options is deprecated and will be removed in Rails 5.2 without replacement.')
      end

      protected

      def lines_to_consume
        1
      end

      def build_deprecation_warning(lines)
        warning = DeprecationWarning.new(
          deprecated: 'strings in :if and :unless conditional options',
          summary: 'Passing string to be evaluated in :if and :unless conditional options is deprecated and will be removed in Rails 5.2 without replacement.',
          message: 'Passing string to be evaluated in :if and :unless conditional options is deprecated and will be removed in Rails 5.2 without replacement. Pass a symbol for an instance method, or a lambda, proc or block, instead.',
          call_site: build_call_site(lines.first)
        )
      end
    end
  end
end
