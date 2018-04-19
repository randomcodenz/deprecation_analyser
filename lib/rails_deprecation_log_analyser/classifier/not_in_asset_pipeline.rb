# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  module Classifier
    class NotInAssetPipeline < Base
      def match?(log_line)
        log_line.include?('Falling back to an asset that may be in the public folder.')
      end

      protected

      def lines_to_consume
        5
      end

      def build_deprecation_warning(lines)
        warning = DeprecationWarning.new(
          deprecated: 'Asset not present in the asset pipeline',
          summary: 'Falling back to an asset that may be in the public folder.',
          message: 'The asset specified is not present in the asset pipeline. This behavior is deprecated and will be removed. Falling back to an asset that may be in the public folder. To bypass the asset pipeline and preserve this behavior, use the `skip_pipeline: true` option',
          call_site: build_call_site(lines.last)
        )
      end
    end
  end
end
