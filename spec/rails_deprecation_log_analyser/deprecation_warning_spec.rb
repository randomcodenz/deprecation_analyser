# frozen_string_literal: true

require 'spec_helper'

module RailsDeprecationLogAnalyser
  RSpec.describe DeprecationWarning do
    let(:deprecated) { 'Deprecated Thing' }
    let(:summary) { 'A thing is deprecated' }
    let(:message) { 'Thing is deprecated. Please use DifferentThing' }
    let(:method_name) { 'some_method' }
    let(:file_name) { '/some/random/file.rb' }
    let(:line_number) { '99' }
    let(:call_site) { DeprecationCallSite.new("(called from #{method_name} at #{file_name}:#{line_number})", '')}

    let(:deprecated_2) { deprecated }
    let(:summary_2) { summary }
    let(:message_2) { message }
    let(:method_name_2) { method_name }
    let(:file_name_2) { file_name }
    let(:line_number_2) { line_number }
    let(:call_site_2) { DeprecationCallSite.new("(called from #{method_name_2} at #{file_name_2}:#{line_number_2})", '')}
    let(:another_warning) { described_class.new(deprecated: deprecated_2, summary: summary_2, message: message_2, call_site: call_site_2) }

    subject(:warning) { described_class.new(deprecated: deprecated, summary: summary, message: message, call_site: call_site) }

    context 'when call_site is nil' do
      let(:call_site) { nil }

      it 'call_site returns a null object' do
        expect(warning.call_site).to eq DeprecationCallSite.null
      end
    end

    describe '#digest' do
      context 'when two instances have the same content' do
        it 'the digest is identical' do
          expect(warning.digest).to eq another_warning.digest
        end
      end

      context 'when two instances have different deprecated values' do
        let(:deprecated_2) { 'Deprecated Whatsit' }

        it 'the digest is different' do
          expect(warning.digest).not_to eq another_warning.digest
        end
      end

      context 'when two instances have different summary values' do
        let(:summary_2) { 'A whatsit is deprecated' }

        it 'the digest is different' do
          expect(warning.digest).not_to eq another_warning.digest
        end
      end

      context 'when two instances have different message values' do
        let(:message_2) { 'Whatsit is deprecated. Please use OtherWhatsit' }

        it 'the digest is different' do
          expect(warning.digest).not_to eq another_warning.digest
        end
      end

      context 'when two instances have different method values' do
        let(:method_name_2) { 'different_method' }

        it 'the digest is different' do
          expect(warning.digest).not_to eq another_warning.digest
        end
      end

      context 'when two instances have different file values' do
        let(:file_name_2) { '/some/different/file.rb' }

        it 'the digest is different' do
          expect(warning.digest).not_to eq another_warning.digest
        end
      end

      context 'when two instances have different line_number values' do
        let(:line_number_2) { '97' }

        it 'the digest is different' do
          expect(warning.digest).not_to eq another_warning.digest
        end
      end
    end

    describe '#<=>' do
      it 'to do'
    end
  end
end