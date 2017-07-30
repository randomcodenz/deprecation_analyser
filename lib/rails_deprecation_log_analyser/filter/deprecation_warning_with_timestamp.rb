# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Filter
    class DeprecationWarningWithTimestamp
      DEPRECATION_WARNING_REGEX = /^[ 0-9:\-]{20}DEPRECATION WARNING: /

      def match?(line:)
        match(line) != nil
      end

      def clean(line:)
        match = match(line)
        if(match)
          line.slice(match.end(0)..-1)
        else
          line
        end
      end

      private

      def match(line)
        line.match(DEPRECATION_WARNING_REGEX)
      end
    end
  end
end
