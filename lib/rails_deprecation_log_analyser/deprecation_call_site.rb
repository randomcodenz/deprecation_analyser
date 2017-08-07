# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  class DeprecationCallSite
    CALL_SITE_REGEX = /\(called from (.*) at (.*):(\d*)\)/

    attr_reader :found, :method, :file, :line_number

    def initialize(line)
      matches = line.match(CALL_SITE_REGEX)
      if matches
        @found = true
        @method = matches[1]
        @file = matches[2]
        @line_number = matches[3]
      else
        @found = false
        @method = 'unknown_method'
        @file = 'unknown_file'
        @line_number = ''
      end
    end

    def found?
      found
    end

    def self.null
      new('')
    end
  end
end