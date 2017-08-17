# frozen_string_literal: true

require 'spec_helper'

module RailsDeprecationLogAnalyser
  module Filter
    RSpec.describe DeprecationWarningWithTimestamp do
      subject(:filter) { DeprecationWarningWithTimestamp.new }

      describe '#match?' do
        let(:match_result) { filter.match?(line) }

        context 'when the line starts with `DEPRECATION WARNING: `' do
          let(:line) { 'DEPRECATION WARNING: Passing a class as a value in an Active Record query' }

          it 'indicates the line is not a match' do
            expect(match_result).to eq false
          end
        end

        context 'when the line starts with `{log timestamp} DEPRECATION WARNING: `' do
          let(:line) { '2017-07-24 07:39:02 DEPRECATION WARNING: Passing a class as a value in an Active Record query' }

          it 'indicates the line is a match' do
            expect(match_result).to eq true
          end
        end

        context 'when the line does not contain `{log timestamp} DEPRECATION WARNING: `' do
          let(:line) { 'Passing a class as a value in an Active Record query' }

          it 'indicates the line is not a match' do
            expect(match_result).to eq false
          end
        end
      end

      describe '#clean' do
        let(:clean_result) { filter.clean(line) }

        context 'when the line starts with `DEPRECATION WARNING: `' do
          let(:line) { 'DEPRECATION WARNING: Passing a class as a value in an Active Record query' }

          it 'does not alter the line' do
            expect(clean_result).to eq line
          end
        end

        context 'when the line starts with `{log timestamp} DEPRECATION WARNING: `' do
          let(:line) { '2017-07-24 07:39:02 DEPRECATION WARNING: Passing a class as a value in an Active Record query' }

          it 'strips the `{log timestamp} DEPRECATION WARNING: ` leader from the line' do
            expect(clean_result).to eq 'Passing a class as a value in an Active Record query'
          end
        end

        context 'when the line does not contain `DEPRECATION WARNING: `' do
          let(:line) { 'Passing a class as a value in an Active Record query' }

          it 'does not alter the line' do
            expect(clean_result).to eq line
          end
        end
      end
    end
  end
end
