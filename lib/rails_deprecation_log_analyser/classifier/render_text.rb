# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class RenderText < Base
      def match?(log_line)
        log_line.include?('`render :text` is deprecated because it does not actually render a `text/plain` response. Switch to `render plain: \'plain text\'` to render as `text/plain`, `render html: \'<strong>HTML</strong>\'` to render as `text/html`, or `render body: \'raw\'` to match the deprecated behavior and render with the default Content-Type, which is `text/html`.')
      end

      protected

      def lines_to_consume
        1
      end

      def build_deprecation_warning(lines)
        warning = DeprecationWarning.new(
          deprecated: '`render :text` response',
          summary: '`render :text` is deprecated because it does not actually render a `text/plain` response.',
          message: '`render :text` is deprecated because it does not actually render a `text/plain` response. Switch to `render plain: \'plain text\'` to render as `text/plain`, `render html: \'<strong>HTML</strong>\'` to render as `text/html`, or `render body: \'raw\'` to match the deprecated behavior and render with the default Content-Type, which is `text/html`.',
          call_site: build_call_site(lines.first)
        )
      end
    end
  end
end
