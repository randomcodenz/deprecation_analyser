# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'
require 'YAML'

module RailsDeprecationLogAnalyser
  module Classifier
    ClassifierRegistry = Struct.new(:classifiers) do
      def register(classifier)
        classifiers.push(classifier)
      end
    end

    RSpec.describe SimpleClassifier do
      it_behaves_like 'a deprecation warning classifier' do
        let(:deprecation_warning) { 'Passing an argument to force an association to reload is now deprecated and will be removed in Rails 5.1. Please call `reload` on the result collection proxy instead.' }
        let(:log_line_includes) { 'Passing an argument to force an association to reload' }
        let(:lines_to_consume) { 1 }
        let(:deprecated) { 'Association reload argument' }
        let(:summary) { 'Passing an argument to force an association to reload is now deprecated and will be removed in Rails 5.1.' }
        let(:message) { 'Passing an argument to force an association to reload is now deprecated and will be removed in Rails 5.1. Please call `reload` on the result collection proxy instead.' }

        subject(:classifier) { SimpleClassifier.new('', log_line_includes, lines_to_consume, deprecated, summary, message) }
      end

      describe '.register' do
        context 'when creating simple classifiers from yaml' do
          let(:classifiers_hash) { YAML.load(classifier_yaml) }
          let(:classifier_configuration) { classifiers_hash['association_reload_argument'] }
          let(:registry) { ClassifierRegistry.new([]) }

          before do
            allow(YAML).to receive(:load_from_file).and_return(classifiers_hash)
            SimpleClassifier.register('', registry)
          end

          it_behaves_like 'a deprecation warning classifier' do
            let(:classifier_yaml) do
              <<~YAML
              association_reload_argument:
                log_line_includes: 'Passing an argument to force an association to reload'
                lines_to_consume: 1
                deprecated: 'Association reload argument'
                summary: 'Passing an argument to force an association to reload is now deprecated and will be removed in Rails 5.1.'
                message: 'Passing an argument to force an association to reload is now deprecated and will be removed in Rails 5.1. Please call `reload` on the result collection proxy instead.'
              YAML
            end
            let(:deprecation_warning) { 'Passing an argument to force an association to reload is now deprecated and will be removed in Rails 5.1. Please call `reload` on the result collection proxy instead.' }
            let(:log_line_includes) { classifier_configuration['log_line_includes'] }
            let(:lines_to_consume) { classifier_configuration['lines_to_consume'] }
            let(:deprecated) { classifier_configuration['deprecated'] }
            let(:summary) { classifier_configuration['summary'] }
            let(:message) { classifier_configuration['message'] }

            subject(:classifier) { registry.classifiers.first }
          end

          context 'when there are multiple classifiers in the config' do
            let(:classifier_yaml) do
              <<~YAML
              association_reload_argument_1:
                log_line_includes: 'Passing an argument to force an association to reload'
                lines_to_consume: 1
                deprecated: 'Association reload argument'
                summary: 'Passing an argument to force an association to reload is now deprecated and will be removed in Rails 5.1.'
                message: 'Passing an argument to force an association to reload is now deprecated and will be removed in Rails 5.1. Please call `reload` on the result collection proxy instead.'

              association_reload_argument_2:
                log_line_includes: 'Passing an argument to force an association to reload'
                lines_to_consume: 1
                deprecated: 'Association reload argument'
                summary: 'Passing an argument to force an association to reload is now deprecated and will be removed in Rails 5.1.'
                message: 'Passing an argument to force an association to reload is now deprecated and will be removed in Rails 5.1. Please call `reload` on the result collection proxy instead.'

              association_reload_argument_3:
                log_line_includes: 'Passing an argument to force an association to reload'
                lines_to_consume: 1
                deprecated: 'Association reload argument'
                summary: 'Passing an argument to force an association to reload is now deprecated and will be removed in Rails 5.1.'
                message: 'Passing an argument to force an association to reload is now deprecated and will be removed in Rails 5.1. Please call `reload` on the result collection proxy instead.'
              YAML
            end

            subject(:classifiers) { registry.classifiers }

            it 'creates a classifier for each configuration' do
              expect(classifiers.length).to eq 3
              expect(classifiers).to all(be_an_instance_of(SimpleClassifier))
            end
          end
        end
      end
    end
  end
end
