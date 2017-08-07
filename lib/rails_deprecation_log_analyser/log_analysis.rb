# frozen_string_literal: true

require 'set'
require 'digest'

module RailsDeprecationLogAnalyser
  class LogAnalysis
    attr_reader :deprecation_warning_formatters, :other_formatters

    def initialize(formatters)
      @deprecation_warning_formatters = formatters.select { |f| f.respond_to?(:deprecation_warning) }
      @other_formatters = formatters.select { |f| f.respond_to?(:other) }
      @deprecation_warning_tracker = Set.new if deprecation_warning_formatters.any?
      @other_tracker = Set.new if other_formatters.any?
    end

    def deprecation_warning(classifier_result)
      return unless deprecation_warning_tracker&.add?(classifier_result.digest)

      deprecation_warning_formatters.each do |f|
        f.deprecation_warning(classifier_result.deprecation_warning, classifier_result.log_lines)
      end
    end

    def other(log_lines)
      return unless other_tracker&.add?(digest(log_lines))

      other_formatters.each do |f|
        f.other(classifier_result.log_lines)
      end
    end

    private

    attr_reader :deprecation_warning_tracker, :other_tracker

    def digest(log_lines)
      Digest::SHA1.hexdigest(log_lines.join)
    end
  end
end