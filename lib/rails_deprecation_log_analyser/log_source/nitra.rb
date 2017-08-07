# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module LogSource
    class Nitra
      attr_reader :filters

      def initialize(log_file_path)
        @log_file_path = log_file_path
        @filters = [Filter::DeprecationWarning.new, Filter::DeprecationWarningWithTimestamp.new]
      end

      def log_lines
        File.foreach(log_file_path)
      end

      private

      attr_reader :log_file_path
    end
  end
end
