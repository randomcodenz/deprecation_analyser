# frozen_string_literal: true

require 'pathname'

module RailsDeprecationLogAnalyser
  class DeprecationCallSite
    include Comparable

    CALL_SITE_REGEX = /\(called from (.*) at (.*):(\d*)\)/
    UNKNOWN_METHOD = 'unknown_method'

    attr_reader :found, :method, :file, :line_number

    def initialize(line, source_directory)
      matches = line.match(CALL_SITE_REGEX)
      if matches
        @found = true
        @method = matches[1]
        @file = make_relative(matches[2], source_directory)
        @line_number = matches[3]
      else
        @found = false
        @method = UNKNOWN_METHOD
        @file = ''
        @line_number = ''
      end
    end

    def found?
      found
    end

    def self.null
      new('', '')
    end

    def <=>(other)
      return nil if other.nil?
      return nil unless other.respond_to?(:found) &&
        other.respond_to?(:method) &&
        other.respond_to?(:file) &&
        other.respond_to?(:line_number)

      compare = (found <=> other.found)
      compare = (method <=> other.method) if compare.nil? || compare.zero?
      compare = (file <=> other.file) if compare.nil? || compare.zero?
      compare = (line_number <=> other.line_number) if compare.nil? || compare.zero?
      compare
    end

    def hash
      [self.class.name, found, method, file, line_number].hash
    end

    private

    def make_relative(file, source_directory)
      return file if source_directory.empty?
      file_path = Pathname.new(file)
      source_directory_path = Pathname.new(source_directory)
      file_path.relative_path_from(source_directory_path).to_s
    end
  end
end