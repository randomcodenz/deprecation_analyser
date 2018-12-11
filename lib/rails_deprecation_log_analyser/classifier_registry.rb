# frozen_string_literal: true

module RailsDeprecationLogAnalyser
  class ClassifierRegistry

    def initialize
      @classifier_store = {}
    end

    def register(name:, classifier:)
      raise "Classifier named #{name} already exists" if classifier_store.has_key?(name)
      classifier_store[name] = classifier
    end

    def classifiers
      classifier_store.values
    end

    def classifier(name:)
      classifier_store[name]
    end

    private

    attr_reader :classifier_store
  end
end