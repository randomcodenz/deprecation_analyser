# frozen_string_literal: true

require 'spec_helper'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe NotInAssetPipeline do
      let(:deprecation_leader) { 'DEPRECATION WARNING:' }
      let(:method) { 'some_method_name' }
      let(:file) { '/some/file_name.rb' }
      let(:line_number) { '53' }
      let(:deprecation_warning_lines) do
        ["The asset blah_blah is not present in the asset pipeline.Falling back to an asset that may be in the public folder.",
         "This behavior is deprecated and will be removed.",
         "To bypass the asset pipeline and preserve this behavior,",
         "use the `skip_pipeline: true` option.",
         " (called from #{method} at #{file}:#{line_number})"]
      end
      let(:cleaned_log_line) { deprecation_warning_lines.first }
      let(:deprecation_log_lines) do
        first_line = "#{deprecation_leader} #{cleaned_log_line}"
        [first_line].concat(deprecation_warning_lines.drop(1))
      end
      let(:deprecated) { 'Asset not present in the asset pipeline' }
      let(:summary) { 'Falling back to an asset that may be in the public folder.' }
      let(:message) { 'The asset specified is not present in the asset pipeline. This behavior is deprecated and will be removed. Falling back to an asset that may be in the public folder. To bypass the asset pipeline and preserve this behavior, use the `skip_pipeline: true` option' }
      let(:lines) { [] + deprecation_log_lines + ['Random log line 1', 'Random log line 2'] }
      let(:filter) { double('filter') }
      let(:classifier_result) { classifier.process(lines, filter) }

      subject(:classifier) { described_class.new('') }

      describe '#match?' do
        context 'when the log line contains the deprecation warning' do
          it 'matches' do
            expect(classifier.match?(deprecation_log_lines.first)).to be true
          end
        end

        context 'when the log line does not match the deprecation warning' do
          let(:cleaned_log_line) { "random deprecation message. This behavior is deprecated and will be changed with Rails 5.1 to only do something else. Use #other_thing instead. (called from #{method} at #{file}:#{line_number})" }

          it 'does not match' do
            expect(classifier.match?(deprecation_log_lines.first)).to be false
          end
        end
      end

      describe '#process' do
        before { allow(filter).to receive(:clean).with(deprecation_log_lines.first).and_return(cleaned_log_line) }

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

        it 'returns the deprecation warning log lines' do
          expect(classifier_result.log_lines).to eq deprecation_log_lines
        end
      end
    end
  end
end
