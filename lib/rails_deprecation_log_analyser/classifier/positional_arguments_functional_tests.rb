# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class PositionalArgumentsFunctionalTests < Base
      def match?(log_line)
        log_line.include?('Using positional arguments in functional tests has been deprecated')
      end

      protected

      def lines_to_consume
        10
      end

      def build_deprecation_warning(lines)
        warning = DeprecationWarning.new(
          deprecated: 'Positional arguments in functional tests',
          summary: 'Using positional arguments in functional tests has been deprecated in favour of keywork arguments.',
          message: 'Using positional arguments in functional tests has been deprecated in favour of keywork arguments. Replace: get :show, { id: 1 }, nil, { notice: "This is a flash message" } with: get :show, params: { id: 1 }, flash: { notice: "This is a flash message" }.',
          call_site: build_call_site(lines.last)
        )
      end
    end
  end
end
