# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class ErrorsGet < Base
      def match?(log_line)
        log_line.include?('ActiveModel::Errors#get is deprecated and will be removed in Rails 5.1')
      end

      protected

      def lines_to_consume
        1
      end

      def build_deprecation_warning(lines)
        warning = DeprecationWarning.new(
          deprecated: 'ActiveModel::Errors#get',
          summary: 'ActiveModel::Errors#get is deprecated and will be removed in Rails 5.1.',
          message: 'ActiveModel::Errors#get is deprecated and will be removed in Rails 5.1. To achieve the same use model.errors[:attribute_name].',
          call_site: build_call_site(lines.first)
        )
      end
    end
  end
end
