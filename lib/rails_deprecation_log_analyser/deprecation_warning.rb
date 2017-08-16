# frozen_string_literal: true

require 'forwardable'
require 'digest'

module RailsDeprecationLogAnalyser
  class DeprecationWarning
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
      Digest::SHA1.hexdigest(digest_content)
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