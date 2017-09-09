# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class ErrorsSet < Base
      def match?(log_line)
        log_line.include?('ActiveModel::Errors#[]= is deprecated and will be removed in Rails 5.1')
      end

      protected

      def lines_to_consume
        1
      end

      def build_deprecation_warning(lines)
        warning = DeprecationWarning.new(
          deprecated: 'ActiveModel::Errors#[]=',
          summary: 'ActiveModel::Errors#[]= is deprecated and will be removed in Rails 5.1.',
          message: 'ActiveModel::Errors#[]= is deprecated and will be removed in Rails 5.1. Use model.errors.add(:attribute_name, "Error message") instead.',
          call_site: build_call_site(lines.first)
        )
      end
    end
  end
end
