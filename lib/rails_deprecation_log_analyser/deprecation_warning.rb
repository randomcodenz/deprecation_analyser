# frozen_string_literal: true

require 'forwardable'
require 'digest'

module RailsDeprecationLogAnalyser
  class DeprecationWarning
    include Comparable
    extend Forwardable

    def_delegator :call_site, :found, :call_site_found
    def_delegators :call_site, :method, :file, :line_number

    attr_reader :deprecated, :summary, :message, :call_site

    def initialize(deprecated:, summary:, message:, call_site: nil)
      @deprecated = deprecated
      @summary = summary
      @message = message
      @call_site = call_site || DeprecationCallSite.null
    end

    def digest
      Digest::SHA1.hexdigest(digest_content.join)
    end

    def <=>(other)
      return nil if other.nil?
      return nil unless other.respond_to?(:deprecated) &&
        other.respond_to?(:summary) &&
        other.respond_to?(:message) &&
        other.respond_to?(:call_site)

      compare = (deprecated <=> other.deprecated)
      compare = (summary <=> other.summary) if compare.nil? || compare.zero?
      compare = (message <=> other.message) if compare.nil? || compare.zero?
      compare = (call_site <=> other.call_site) if compare.nil? || compare.zero?
      compare
    end

    private

    def digest_content
      [
        deprecated,
        summary,
        message,
        method,
        file,
        line_number
      ]
    end

  end
end