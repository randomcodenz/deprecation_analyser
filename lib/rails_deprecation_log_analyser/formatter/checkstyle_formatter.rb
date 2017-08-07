# frozen_string_literal: true

require 'rexml/document'

module RailsDeprecationLogAnalyser
  module Formatter
    class CheckstyleFormatter
      OUTPUT_INDENT = 2

      def deprecation_warning(warning, log_lines)
        file = files[warning.file]
        error(file).add_attributes(error_attributes(warning))
      end

      def write(output)
        document.write(output, OUTPUT_INDENT)
      end

      private

      def document
        @document ||= REXML::Document.new.tap do |d|
          d << REXML::XMLDecl.new
        end
      end

      def checkstyle
        @checkstyle ||= REXML::Element.new('checkstyle', document)
      end

      def files
        @file ||= Hash.new do |hash, key|
          hash[key] = REXML::Element.new('file', checkstyle).tap do |f|
            f.attributes['name'] = key
          end
        end
      end

      def error(file)
        REXML::Element.new('error', file)
      end

      def error_attributes(warning)
        {
          'line' => warning.line_number,
          'severity' => 'warning',
          'message' => warning.message,
          'source' => 'com.puppycrawl.tools.checkstyle.' + warning.deprecated
        }
      end
    end
  end
end
