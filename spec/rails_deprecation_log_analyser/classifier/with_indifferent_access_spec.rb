# frozen_string_literal: true

require 'spec_helper'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe WithIndifferentAccess do
      let(:deprecation_leader) { 'DEPRECATION WARNING:' }
      let(:method) { 'assign_nested_attributes_for_one_to_one_association' }
      let(:file) { '/var/lib/jenkins/gems/ruby/2.3.0/gems/protected_attributes_continued-1.3.0/lib/active_record/mass_assignment_security/nested_attributes.rb' }
      let(:line_number) { '53' }
      let(:cleaned_log_line) { "Method with_indifferent_access is deprecated and will be removed in Rails 5.1, as `ActionController::Parameters` no longer inherits from hash. Using this deprecated behavior exposes potential security problems. If you continue to use this method you may be creating a security vulnerability in your app that can be exploited. Instead, consider using one of these documented methods which are not deprecated: http://api.rubyonrails.org/v5.0.3/classes/ActionController/Parameters.html (called from #{method} at #{file}:#{line_number})" }
      let(:deprecation_log_line) { "#{deprecation_leader} #{cleaned_log_line}" }
      let(:lines) { [deprecation_log_line, 'Random log line 1', 'Random log line 2'] }
      let(:filter) { double('filter') }
      let(:classifier_result) { classifier.process(lines, filter) }

      subject(:classifier) { described_class.new('') }

      describe '#match?' do
        context 'when the log line is a with_indifferent_access deprecation warning' do
          it 'matches' do
            expect(classifier.match?(deprecation_log_line)).to be true
          end
        end

        context 'when the log line is not a with_indifferent_access deprecation warning' do
          let(:cleaned_log_line) { "random deprecation message. This behavior is deprecated and will be changed with Rails 5.1 to only do something else. Use #other_thing instead. (called from #{method} at #{file}:#{line_number})" }

          it 'does not match' do
            expect(classifier.match?(deprecation_log_line)).to be false
          end
        end
      end

      describe '#process' do
        before { allow(filter).to receive(:clean).with(deprecation_log_line).and_return(cleaned_log_line) }

        it 'returns a with_indifferent_access deprecation warning' do
          expect(classifier_result.deprecation_warning).to have_attributes(
            :deprecated => 'Method with_indifferent_access on ActionController::Parameters',
            :summary => 'Method with_indifferent_access on ActionController::Parameters is deprecated. Using this deprecated behavior exposes potential security problems.',
            :message => 'Method with_indifferent_access on ActionController::Parameters is deprecated. Instead, consider using one of these documented methods which are not deprecated: http://api.rubyonrails.org/v5.0.3/classes/ActionController/Parameters.html',
            :method => method,
            :file => file,
            :line_number => line_number
          )
        end

        it 'returns the with_indifferent_access deprecation warning log line' do
          expect(classifier_result.log_lines).to eq [deprecation_log_line]
        end
      end
    end
  end
end
