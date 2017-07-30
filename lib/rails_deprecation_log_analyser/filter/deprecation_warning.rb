# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Filter
    class DeprecationWarning
      DEPRECATION_WARNING_LEADER = 'DEPRECATION WARNING: '

      def match?(line:)
        line.start_with?(DEPRECATION_WARNING_LEADER)
      end

      def clean(line:)
        if match?(line: line)
          line.slice(DEPRECATION_WARNING_LEADER.length..-1)
        else
          line
        end
      end
    end
  end
end
