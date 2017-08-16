# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class ClassifierResult
      attr_reader :log_lines, :deprecation_warning

      def initialize(log_lines, deprecation_warning = nil)
        @log_lines = log_lines
        @deprecation_warning = deprecation_warning
      end
    end
  end
end