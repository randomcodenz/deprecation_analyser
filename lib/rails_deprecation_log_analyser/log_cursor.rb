# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  class LogCursor
    attr_reader :index

    def initialize(log_lines)
      @log_lines = log_lines.each
      @index = -1
    end

    def peek
      next_line = log_lines.next if next_line.nil?
    end

    def take(n = 1)
      lines = [next_line].compact
      next_line = nil

      while lines.count <= n do
        lines << log_lines.next
      end

      @index += n
      lines
    end

    private

    attr_reader :log_lines
    attr_accessor :next_line
  end
end