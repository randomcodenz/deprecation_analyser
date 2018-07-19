# frozen_string_literal: true

require 'spec_helper'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.shared_examples 'a deprecation warning classifier' do
      let(:deprecation_leader) { 'DEPRECATION WARNING:' }
      let(:method) { 'assign_nested_attributes_for_one_to_one_association' }
      let(:file) { '/var/lib/jenkins/gems/ruby/2.3.0/gems/protected_attributes_continued-1.3.0/lib/active_record/mass_assignment_security/nested_attributes.rb' }
      let(:line_number) { '53' }
      let(:cleaned_log_line) { "#{deprecation_warning} (called from #{method} at #{file}:#{line_number})" }
      let(:deprecation_log_line) { "#{deprecation_leader} #{cleaned_log_line}" }
      let(:deprecated) { 'Method with_indifferent_access on ActionController::Parameters' }
      let(:summary) { 'Method with_indifferent_access on ActionController::Parameters is deprecated. Using this deprecated behavior exposes potential security problems.' }
      let(:message) { 'Method with_indifferent_access on ActionController::Parameters is deprecated. Instead, consider using one of these documented methods which are not deprecated: http://api.rubyonrails.org/v5.0.3/classes/ActionController/Parameters.html' }
      let(:lines) { [deprecation_log_line, 'Random log line 1', 'Random log line 2'] }
      let(:filter) { double('filter') }
      let(:classifier_result) { classifier.process(lines, filter) }

      subject(:classifier) { described_class.new('') }

      describe '#match?' do
        context 'when the log line contains the deprecation warning' do
          it 'matches' do
            expect(classifier.match?(deprecation_log_line)).to be true
          end
        end

        context 'when the log line does not match the deprecation warning' do
          let(:cleaned_log_line) { "random deprecation message. This behavior is deprecated and will be changed with Rails 5.1 to only do something else. Use #other_thing instead. (called from #{method} at #{file}:#{line_number})" }

          it 'does not match' do
            expect(classifier.match?(deprecation_log_line)).to be false
          end
        end
      end

      describe '#process' do
        before { allow(filter).to receive(:clean).with(deprecation_log_line).and_return(cleaned_log_line) }

        it 'returns a deprecation warning' do
          expect(classifier_result.deprecation_warning).to have_attributes(
            :deprecated => deprecated,
            :summary => summary,
            :message => message,
            :method => method,
            :file => file,
            :line_number => line_number
          )
        end

        it 'returns the deprecation warning log line' do
          expect(classifier_result.log_lines).to eq [deprecation_log_line]
        end
      end
    end

    RSpec.shared_examples 'a simple classifier' do
      let(:config_path) { File.join(__dir__, 'simple_classifiers.yml').gsub(/\/spec/, '/lib') }
      let(:classifiers_hash) { YAML.load_file(config_path) }
      let(:classifier_configuration) { classifiers_hash[classifier_name] }
      let(:registry) { ClassifierRegistry.new }

      before do
        SimpleClassifier.register('', registry)
      end

      it_behaves_like 'a deprecation warning classifier' do
        let(:deprecated) { classifier_configuration['deprecated'] }
        let(:summary) { classifier_configuration['summary'] || SimpleClassifier.build_summary(message) }
        let(:message) { classifier_configuration['message'] }

        subject(:classifier) { registry.classifier(name: classifier_name) }
      end
    end
  end
end
