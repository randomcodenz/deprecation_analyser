# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  class Configuration

    def initialize(parser_config, formatters, source_directory)
      @parser_config = parser_config
      @formatters = formatters

      source_directory = source_directory || ''
      @classifiers = build_classifiers(source_directory)
      @unknown = build_unknown(source_directory)
    end

    def log_cursor
      @log_lines = LogCursor.new(parser_config.log_lines)
    end

    def find_filter(line)
      return nil if line.nil?
      parser_config.filters.detect { |f| f.match?(line) }
    end

    def find_classifier(line)
      classifiers.detect { |c| c.match?(line) } || unknown
    end

    def log_analysis
      @log_analysis ||= LogAnalysis.new(formatters)
    end

    private

    attr_reader :parser_config, :classifiers, :formatters, :unknown

    def build_classifiers(source_directory)
      [
        Classifier::AssociationReloadArgument.new(source_directory),
        Classifier::AttributeChangedCallback.new(source_directory),
        Classifier::AttributeWasCallback.new(source_directory),
        Classifier::ChangedAttributesCallback.new(source_directory),
        Classifier::ChangedInCallback.new(source_directory),
        Classifier::ClassArgumentInActiveRecordQuery.new(source_directory),
        Classifier::CollectParameters.new(source_directory),
        Classifier::ConditionalDeleteAll.new(source_directory),
        Classifier::ConnectionTables.new(source_directory),
        Classifier::DeepSymbolizeKeysParameters.new(source_directory),
        Classifier::EachWithObjectParameters.new(source_directory),
        Classifier::EqualityComparisonBeweenParametersAndHash.new(source_directory),
        Classifier::ErrorsGet.new(source_directory),
        Classifier::ErrorsSet.new(source_directory),
        Classifier::ExceptParameters.new(source_directory),
        Classifier::ImplicitCallbackChainEscape.new(source_directory),
        Classifier::LockingDiryRecord.new(source_directory),
        Classifier::MapParameters.new(source_directory),
        Classifier::MemberParameters.new(source_directory),
        Classifier::MimeTypeConstants.new(source_directory),
        Classifier::NotInAssetPipeline.new(source_directory),
        Classifier::PassInstanceToExists.new(source_directory),
        Classifier::PositionalArgumentsFunctionalTests.new(source_directory),
        Classifier::RedirectToBack.new(source_directory),
        Classifier::RenderText.new(source_directory),
        Classifier::RestrictDependentDestory.new(source_directory),
        Classifier::ReverseMergeParameters.new(source_directory),
        Classifier::StatusOnHead.new(source_directory),
        Classifier::SymbolizeKeysParameters.new(source_directory),
        Classifier::ToHashParameters.new(source_directory),
        Classifier::Uniq.new(source_directory),
        Classifier::WithIndifferentAccess.new(source_directory),
        Classifier::XhrXmlHttpRequest.new(source_directory)
      ]
    end

    def build_unknown(source_directory)
      Classifier::Unknown.new(source_directory)
    end
  end
end
