# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe 'xhr_xml_http_request' do
      it_behaves_like 'a deprecation warning classifier' do
        let(:classifier_name) { 'xhr_xml_http_request' }
        let(:config_path) { File.join(__dir__, 'simple_classifiers.yml').gsub(/\/spec/, '/lib') }
        let(:classifiers_hash) { YAML.load_file(config_path) }
        let(:classifier_configuration) { classifiers_hash[classifier_name] }
        let(:registry) { ClassifierRegistry.new }
        let(:deprecation_warning_lines) do
          ["`xhr` and `xml_http_request` are deprecated and will be removed in Rails 5.1.",
          "Switch to e.g. `post :create, params: { comment: { body: 'Honey bunny' } }, xhr: true`.",
          " (called from #{method} at #{file}:#{line_number})"]
        end
        let(:cleaned_log_line) { deprecation_warning_lines.first }
        let(:deprecation_log_lines) do
          first_line = "#{deprecation_leader} #{cleaned_log_line}"
          [first_line].concat(deprecation_warning_lines.drop(1))
        end
        let(:deprecated) { classifier_configuration['deprecated'] }
        let(:summary) { classifier_configuration['summary'] || SimpleClassifier.build_summary(message) }
        let(:message) { classifier_configuration['message'] }
        let(:lines) { [] + deprecation_log_lines + ['Random log line 1', 'Random log line 2'] }
        let(:filter) { double('filter') }
        let(:classifier_result) { classifier.process(lines, filter) }

        subject(:classifier) { registry.classifier(name: classifier_name) }

        before do
          SimpleClassifier.register('', registry)
        end
      end
    end
  end
end
