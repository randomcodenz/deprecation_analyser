# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class Base
      attr_reader :source_directory

      def initialize(source_directory)
        @source_directory = source_directory
      end

      protected

      def build_call_site(log_line)
        DeprecationCallSite.new(log_line, source_directory)
      end
    end
  end
end