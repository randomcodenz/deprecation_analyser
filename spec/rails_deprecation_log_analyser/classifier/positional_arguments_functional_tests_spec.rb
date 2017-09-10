# frozen_string_literal: true

require 'spec_helper'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe PositionalArgumentsFunctionalTests do
      let(:deprecation_leader) { 'DEPRECATION WARNING:' }
      let(:method) { 'some_method_name' }
      let(:file) { '/some/file_name.rb' }
      let(:line_number) { '53' }
      let(:deprecation_warning_lines) do
        ["Using positional arguments in functional tests has been deprecated,",
        "in favor of keyword arguments, and will be removed in Rails 5.1.",
        "",
        "Deprecated style:",
        "get :show, { id: 1 }, nil, { notice: \"This is a flash message\" }",
        "",
        "New keyword style:",
        "get :show, params: { id: 1 }, flash: { notice: \"This is a flash message\" },",
        "  session: nil # Can safely be omitted.",
        " (called from #{method} at #{file}:#{line_number})"]
      end
      let(:cleaned_log_line) { deprecation_warning_lines.first }
      let(:deprecation_log_lines) do
        first_line = "#{deprecation_leader} #{cleaned_log_line}"
        [first_line].concat(deprecation_warning_lines.drop(1))
      end
      let(:deprecated) { 'Positional arguments in functional tests' }
      let(:summary) { 'Using positional arguments in functional tests has been deprecated in favour of keyword arguments.' }
      let(:message) { 'Using positional arguments in functional tests has been deprecated in favour of keyword arguments. Replace: get :show, { id: 1 }, nil, { notice: "This is a flash message" } with: get :show, params: { id: 1 }, flash: { notice: "This is a flash message" }.' }
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
