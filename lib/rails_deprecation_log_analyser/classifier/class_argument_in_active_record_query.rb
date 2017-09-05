# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class ClassArgumentInActiveRecordQuery < Base
      def match?(log_line)
        log_line.include?('Passing a class as a value in an Active Record query is deprecated and will be removed. Pass a string instead.')
      end

      protected

      def lines_to_consume
        1
      end

      def build_deprecation_warning(lines)
        warning = DeprecationWarning.new(
          deprecated: 'Class argument in ActiveRecord query',
          summary: 'Passing a class as a value in an Active Record query is deprecated and will be removed',
          message: 'Passing a class as a value in an Active Record query is deprecated and will be removed. Pass a string instead.',
          call_site: build_call_site(lines.first)
        )
      end
    end
  end
end
