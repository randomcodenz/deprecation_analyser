# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'
require 'YAML'

module RailsDeprecationLogAnalyser
  module Classifier
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

      describe '.build_summary' do
        let(:expected_summary) { 'Passing an argument to force an association to reload is now deprecated and will be removed in Rails 5.1.' }
        let(:message) { 'Passing an argument to force an association to reload is now deprecated and will be removed in Rails 5.1. Please call `reload` on the result collection proxy instead.' }

        it 'returns the first sentence from the passed message' do
          expect(SimpleClassifier.build_summary(message)).to eq expected_summary
        end
      end

      describe '.build_classifier' do
        let(:warning) { 'Passing an argument to force an association to reload is now deprecated and will be removed in Rails 5.1. Please call `reload` on the result collection proxy instead.' }
        let(:log_line_includes) { 'Passing an argument to force an association to reload' }
        let(:lines_to_consume) { 1 }
        let(:title) { 'Association reload argument' }
        let(:short_message) { 'Passing an argument to force an association to reload is now deprecated and will be removed in Rails 5.1.' }
        let(:full_message) { 'Passing an argument to force an association to reload is now deprecated and will be removed in Rails 5.1. Please call `reload` on the result collection proxy instead.' }
        let(:config) do
          {
            'log_line_includes' => log_line_includes,
            'lines_to_consume' => lines_to_consume,
            'deprecated' => title,
            'summary' => short_message,
            'message' => full_message
          }
        end

        context 'when all parameters are present in config' do
          it_behaves_like 'a deprecation warning classifier' do
            let(:deprecation_warning) { warning }
            let(:deprecated) { title }
            let(:summary) { short_message }
            let(:message) { full_message }

            subject(:classifier) { SimpleClassifier.build_classifier('', config) }
          end
        end

        context 'when lines_to_consume is missing it defaults to 1' do
          before do
            config.delete('lines_to_consume')
          end

          it_behaves_like 'a deprecation warning classifier' do
            let(:deprecation_warning) { warning }
            let(:deprecated) { title }
            let(:summary) { short_message }
            let(:message) { full_message }

            subject(:classifier) { SimpleClassifier.build_classifier('', config) }
          end
        end

        context 'when summary is missing it defaults to first sentence of message' do
          before do
            config.delete('summary')
          end

          it_behaves_like 'a deprecation warning classifier' do
            let(:deprecation_warning) { warning }
            let(:deprecated) { title }
            let(:summary) { short_message }
            let(:message) { full_message }

            subject(:classifier) { SimpleClassifier.build_classifier('', config) }
          end
        end
      end

      describe '.register' do
        context 'when creating simple classifiers from yaml' do
          let(:classifiers_hash) { YAML.load(classifier_yaml) }
          let(:classifier_configuration) { classifiers_hash['association_reload_argument'] }
          let(:registry) { ClassifierRegistry.new }

          context 'when all of the parameters are present' do
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

              before do
                allow(YAML).to receive(:load_file).and_return(classifiers_hash)
                SimpleClassifier.register('', registry)
              end
            end
          end

          context 'when optional paramters are not in the yaml' do
            it_behaves_like 'a deprecation warning classifier' do
              let(:classifier_yaml) do
                <<~YAML
                association_reload_argument:
                  log_line_includes: 'Passing an argument to force an association to reload'
                  deprecated: 'Association reload argument'
                  message: 'Passing an argument to force an association to reload is now deprecated and will be removed in Rails 5.1. Please call `reload` on the result collection proxy instead.'
                YAML
              end
              let(:deprecation_warning) { 'Passing an argument to force an association to reload is now deprecated and will be removed in Rails 5.1. Please call `reload` on the result collection proxy instead.' }
              let(:log_line_includes) { classifier_configuration['log_line_includes'] }
              let(:lines_to_consume) { 1 }
              let(:deprecated) { classifier_configuration['deprecated'] }
              let(:summary) { SimpleClassifier.build_summary(classifier_configuration['message']) }
              let(:message) { classifier_configuration['message'] }

              subject(:classifier) { registry.classifiers.first }

              before do
                allow(YAML).to receive(:load_file).and_return(classifiers_hash)
                SimpleClassifier.register('', registry)
              end
            end
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

            before do
              allow(YAML).to receive(:load_file).and_return(classifiers_hash)
              SimpleClassifier.register('', registry)
            end

            it 'creates a classifier for each configuration' do
              expect(classifiers.length).to eq 3
              expect(classifiers).to all(be_an_instance_of(SimpleClassifier))
            end
          end

          context 'when loading classifiers from the configuration file' do
            subject(:classifiers) { registry.classifiers }

            before do
              SimpleClassifier.register('', registry)
            end

            it 'the file is valid' do
              expect(classifiers).to all(be_an_instance_of(SimpleClassifier))
            end
          end
        end
      end
    end
  end
end
