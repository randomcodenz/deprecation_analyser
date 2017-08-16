# frozen_string_literal: true

require 'spec_helper'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe Unknown do
      let(:lines) { ['Line 1', 'Line 2', 'Line 3'] }
      let(:filter) { double('filter') }
      let(:classifier_result) { unknown_classifier.process(lines, filter) }

      subject(:unknown_classifier) { described_class.new('') }

      describe '#process' do
        before { allow(filter).to receive(:clean) { |line| line } }

        it 'creates an unknown deprecation warning' do
          expect(classifier_result.deprecation_warning).to have_attributes(:deprecated => 'Unknown', :message => lines[0])
        end

        it 'returns the first lines from the lines processed' do
          expect(classifier_result.log_lines).to eq [lines[0]]
        end
      end
    end
  end
end