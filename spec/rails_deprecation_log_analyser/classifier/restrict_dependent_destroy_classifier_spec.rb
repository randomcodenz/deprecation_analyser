# frozen_string_literal: true

require 'spec_helper'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe RestrictDependentDestoryClassifier do
      let(:deprecation_leader) { 'DEPRECATION WARNING:' }
      let(:method) { 'random_method' }
      let(:file) { '/var/lib/jenkins/random_file.rb' }
      let(:line_number) { '41' }
      let(:cleaned_log_line) { "The error key `:'restrict_dependent_destroy.many'` has been deprecated and will be removed in Rails 5.1. Please use `:'restrict_dependent_destroy.has_many'` instead. (called from #{method} at #{file}:#{line_number})" }
      let(:deprecation_log_line) { "#{deprecation_leader} #{cleaned_log_line}" }
      let(:lines) { [deprecation_log_line, 'Random log line 1', 'Random log line 2'] }
      let(:filter) { double('filter') }
      let(:classifier_result) { classifier.process(lines, filter) }

      subject(:classifier) { described_class.new('') }

      describe '#match?' do
        context 'when the log line is a restrict and dependent destroy deprecation warning' do
          it 'matches' do
            expect(classifier.match?(deprecation_log_line)).to be true
          end
        end

        context 'when the log line is not a restrict and dependent destroy deprecation warning' do
          let(:cleaned_log_line) { "random deprecation message. This behavior is deprecated and will be changed with Rails 5.1 to only do something else. Use #other_thing instead. (called from #{method} at #{file}:#{line_number})" }

          it 'does not match' do
            expect(classifier.match?(deprecation_log_line)).to be false
          end
        end
      end

      describe '#process' do
        before { allow(filter).to receive(:clean).with(deprecation_log_line).and_return(cleaned_log_line) }

        it 'returns a restrict and dependent destroy deprecation warning' do
          expect(classifier_result.deprecation_warning).to have_attributes(
            :deprecated => "Restrict dependent destroy - many",
            :summary => "The error key `:'restrict_dependent_destroy.many'` has been deprecated and will be removed in Rails 5.1.",
            :message => "The error key `:'restrict_dependent_destroy.many'` has been deprecated and will be removed in Rails 5.1. Please use `:'restrict_dependent_destroy.has_many'` instead.",
            :method => method,
            :file => file,
            :line_number => line_number
          )
        end

        it 'returns the restrict and dependent destroy deprecation warning log line' do
          expect(classifier_result.log_lines).to eq [deprecation_log_line]
        end
      end
    end
  end
end
