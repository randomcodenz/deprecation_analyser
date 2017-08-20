# frozen_string_literal: true

require 'spec_helper'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe ImplicitCallbackChainEscape do
      let(:deprecation_leader) { 'DEPRECATION WARNING:' }
      let(:method) { 'random_method' }
      let(:file) { '/var/lib/jenkins/random_file.rb' }
      let(:line_number) { '93' }
      let(:cleaned_log_line) { "Returning `false` in Active Record and Active Model callbacks will not implicitly halt a callback chain in Rails 5.1. To explicitly halt the callback chain, please use `throw :abort` instead. (called from #{method} at #{file}:#{line_number})" }
      let(:deprecation_log_line) { "#{deprecation_leader} #{cleaned_log_line}" }
      let(:lines) { [deprecation_log_line, 'Random log line 1', 'Random log line 2'] }
      let(:filter) { double('filter') }
      let(:classifier_result) { classifier.process(lines, filter) }

      subject(:classifier) { described_class.new('') }

      describe '#match?' do
        context 'when the log line is an implicit callback chain escape deprecation warning' do
          it 'matches' do
            expect(classifier.match?(deprecation_log_line)).to be true
          end
        end

        context 'when the log line is not an implicit callback chain escape deprecation warning' do
          let(:cleaned_log_line) { "random deprecation message. This behavior is deprecated and will be changed with Rails 5.1 to only do something else. Use #other_thing instead. (called from #{method} at #{file}:#{line_number})" }

          it 'does not match' do
            expect(classifier.match?(deprecation_log_line)).to be false
          end
        end
      end

      describe '#process' do
        before { allow(filter).to receive(:clean).with(deprecation_log_line).and_return(cleaned_log_line) }

        it 'returns an implicit callback chain escape deprecation warning' do
          expect(classifier_result.deprecation_warning).to have_attributes(
            :deprecated => 'Implicit escaping of callbacks',
            :summary => 'Returning `false` in Active Record and Active Model callbacks will not implicitly halt a callback chain in Rails 5.1.',
            :message => 'Returning `false` in Active Record and Active Model callbacks will not implicitly halt a callback chain in Rails 5.1. To explicitly halt the callback chain, please use `throw :abort` instead.',
            :method => method,
            :file => file,
            :line_number => line_number
          )
        end

        it 'returns the implicit callback chain escape deprecation warning log line' do
          expect(classifier_result.log_lines).to eq [deprecation_log_line]
        end
      end
    end
  end
end
