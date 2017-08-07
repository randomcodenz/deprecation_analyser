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
  end
end