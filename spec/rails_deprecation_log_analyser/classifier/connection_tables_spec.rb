# frozen_string_literal: true

require 'spec_helper'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe ConnectionTables do
      let(:deprecation_leader) { 'DEPRECATION WARNING:' }
      let(:method) { 'clear_other_tables' }
      let(:file) { '/var/lib/jenkins/gems/ruby/2.3.0/gems/fixation-2.0.1/lib/fixation/fixtures.rb' }
      let(:line_number) { '51' }
      let(:cleaned_log_line) { "#tables currently returns both tables and views. This behavior is deprecated and will be changed with Rails 5.1 to only return tables. Use #data_sources instead. (called from #{method} at #{file}:#{line_number})" }
      let(:deprecation_log_line) { "#{deprecation_leader} #{cleaned_log_line}" }
      let(:lines) { [deprecation_log_line, 'Random log line 1', 'Random log line 2'] }
      let(:filter) { double('filter') }
      let(:classifier_result) { classifier.process(lines, filter) }

      subject(:classifier) { described_class.new('') }

      describe '#match?' do
        context 'when the log line is a tables deprecation warning' do
          it 'matches' do
            expect(classifier.match?(deprecation_log_line)).to be true
          end
        end

        context 'when the log line is not a tables deprecation warning' do
          let(:cleaned_log_line) { "random deprecation message. This behavior is deprecated and will be changed with Rails 5.1 to only do something else. Use #other_thing instead. (called from #{method} at #{file}:#{line_number})" }

          it 'does not match' do
            expect(classifier.match?(deprecation_log_line)).to be false
          end
        end
      end

      describe '#process' do
        before { allow(filter).to receive(:clean).with(deprecation_log_line).and_return(cleaned_log_line) }

        it 'supresses the deprecation warning' do
          expect(classifier_result.deprecation_warning).to be_nil
        end

        it 'returns the #tables deprecation warning log line' do
          expect(classifier_result.log_lines).to eq [deprecation_log_line]
        end
      end
    end
  end
end