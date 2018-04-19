# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class LockingDiryRecord < Base
      def match?(log_line)
        log_line.include?('Locking a record with unpersisted changes is deprecated and will raise an exception in Rails 5.2.')
      end

      protected

      def lines_to_consume
        1
      end

      def build_deprecation_warning(lines)
        warning = DeprecationWarning.new(
          deprecated: 'Locking a dirty record',
          summary: 'Locking a record with unpersisted changes is deprecated and will raise an exception in Rails 5.2.',
          message: 'Locking a record with unpersisted changes is deprecated and will raise an exception in Rails 5.2. Use `save` to persist the changes, or `reload` to discard them explicitly.',
          call_site: build_call_site(lines.first)
        )
      end
    end
  end
end
