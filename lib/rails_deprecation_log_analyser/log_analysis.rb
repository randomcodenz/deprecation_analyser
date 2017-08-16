# frozen_string_literal: true

require 'set'
require 'digest'

module RailsDeprecationLogAnalyser
  class LogAnalysis
    attr_reader :deprecation_warning_formatters, :deprecation_log_formatters, :other_formatters

    def initialize(formatters)
      @deprecation_warning_formatters = formatters.select { |f| f.respond_to?(:deprecation_warning) }
      @deprecation_log_formatters = formatters.select { |f| f.respond_to?(:deprecation_log) }
      @other_formatters = formatters.select { |f| f.respond_to?(:other) }
      @deprecation_warning_tracker = Set.new if deprecation_warning_formatters.any?
      @deprecation_log_tracker = Set.new if deprecation_log_formatters.any?
      @other_tracker = Set.new if other_formatters.any?
    end

    def deprecation(classifier_result)
      deprecation_warning(classifier_result.deprecation_warning)
      deprecation_log(classifier_result.log_lines)
    end

    def other(log_lines)
      return if other_formatters.empty?
      return unless other_tracker.add?(digest(log_lines))

      other_formatters.each do |f|
        f.other(log_lines)
      end
    end

    private

    attr_reader :deprecation_warning_tracker, :deprecation_log_tracker, :other_tracker

    def deprecation_warning(deprecation_warning)
      return if deprecation_warning.nil? || deprecation_warning_formatters.empty?
      return unless deprecation_warning_tracker.add?(deprecation_warning.digest)

      deprecation_warning_formatters.each do |f|
        f.deprecation_warning(deprecation_warning)
      end
    end

    def deprecation_log(log_lines)
      return if log_lines&.empty? || deprecation_log_trackers.empty?
      return unless deprecation_log_tracker.add?(digest(log_lines))

      deprecation_log_formatters.each do |f|
        f.deprecation_log(log_lines)
      end
    end

    def digest(log_lines)
      Digest::SHA1.hexdigest(log_lines.join)
    end
  end
end