# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class ImplicitCallbackChainEscape < Base
      def match?(log_line)
        log_line.include?('Returning `false` in Active Record and Active Model callbacks will not implicitly halt a callback chain in Rails 5.1. To explicitly halt the callback chain, please use `throw :abort` instead.')
      end

      protected

      def lines_to_consume
        1
      end

      def build_deprecation_warning(lines)
        warning = DeprecationWarning.new(
          deprecated: 'Implicit escaping of callbacks',
          summary: 'Returning `false` in Active Record and Active Model callbacks will not implicitly halt a callback chain in Rails 5.1.',
          message: 'Returning `false` in Active Record and Active Model callbacks will not implicitly halt a callback chain in Rails 5.1. To explicitly halt the callback chain, please use `throw :abort` instead.',
          call_site: build_call_site(lines.first)
        )
      end
    end
  end
end
