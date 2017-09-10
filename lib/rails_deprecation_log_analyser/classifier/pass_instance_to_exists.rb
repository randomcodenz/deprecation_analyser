# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class PassInstanceToExists < Base
      def match?(log_line)
        log_line.include?('You are passing an instance of ActiveRecord::Base to `exists?`')
      end

      protected

      def lines_to_consume
        1
      end

      def build_deprecation_warning(lines)
        warning = DeprecationWarning.new(
          deprecated: 'Passing instance to exists?',
          summary: 'You are passing an instance of ActiveRecord::Base to `exists?`.',
          message: 'You are passing an instance of ActiveRecord::Base to `exists?`. Please pass the id of the object by calling `.id`.',
          call_site: build_call_site(lines.first)
        )
      end
    end
  end
end
