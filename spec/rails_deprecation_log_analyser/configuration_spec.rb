# frozen_string_literal: true

require 'spec_helper'

module RailsDeprecationLogAnalyser
  RSpec.describe Configuration do
    let(:parser_config) { nil }
    let(:formatters) { [] }
    let(:source_directory) { '' }

    subject(:config) { Configuration.new(parser_config, formatters, source_directory) }

    describe '#find_classifier' do
      let(:log_line) { 'blah' }

      context 'when there is a classifier for the log line' do
        it 'finds the first matching classifier'
      end

      context 'when there are no classifiers for the log line' do
        it 'returns the default classifier' do
          expect(config.find_classifier(log_line)).to be_an_instance_of(RailsDeprecationLogAnalyser::Classifier::Unknown)
        end
      end
    end
  end
end