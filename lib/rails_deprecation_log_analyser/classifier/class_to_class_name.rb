# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class ClassToClassName < Base
      def match?(log_line)
        log_line.include?('Passing a class to the `class_name` is deprecated and will raise an ArgumentError in Rails 5.2')
      end

      protected

      def lines_to_consume
        1
      end

      def build_deprecation_warning(lines)
        warning = DeprecationWarning.new(
          deprecated: 'Passing a class to the `class_name`',
          summary: 'Passing a class to the `class_name` is deprecated and will raise an ArgumentError in Rails 5.2',
          message: 'Passing a class to the `class_name` is deprecated and will raise an ArgumentError in Rails 5.2. It eagerloads more classes than necessary and potentially creates circular dependencies. Please pass the class name as a string.',
          call_site: build_call_site(lines.first)
        )
      end
    end
  end
end
