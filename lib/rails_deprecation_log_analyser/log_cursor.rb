# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  class LogCursor
    attr_reader :index

    def initialize(log)
      @log = log.each
      @index = -1
      @end_reached = false
    end

    def peek
      @next_value ||= log.next
    rescue StopIteration
      @exhausted = true
      nil
    end

    def take(n = 1)
      raise StopIteration if exhausted || peek.nil?

      values = []
      while values.count < n && move_next do
        values << current_value
      end

      values
    end

    private

    attr_reader :log, :current_value, :next_value, :exhausted

    def move_next
      # If we have peeked then grab that value
      @current_value = @next_value
      @next_value = nil

      # Otherwise grab the next value from the log
      @current_value = log.next if current_value.nil?
      @index += 1
      true
    rescue StopIteration
      @exhausted = true
      false
    end
  end
end