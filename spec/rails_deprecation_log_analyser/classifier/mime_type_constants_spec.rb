# frozen_string_literal: true

require 'spec_helper'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe MimeTypeConstants do
      let(:deprecation_leader) { 'DEPRECATION WARNING:' }
      let(:method) { 'handle_failed_login' }
      let(:file) { '/var/lib/jenkins/powershop/app/lib/access_control.rb' }
      let(:line_number) { '196' }
      let(:cleaned_log_line_html) { "Accessing mime types via constants is deprecated. Please change `Mime::HTML` to `Mime[:html]`. (called from #{method} at #{file}:#{line_number})" }
      let(:cleaned_log_line_js) { "Accessing mime types via constants is deprecated. Please change `Mime::JS` to `Mime[:js]`. (called from #{method} at #{file}:#{line_number})" }
      let(:deprecation_log_line) { "#{deprecation_leader} #{cleaned_log_line}" }
      let(:lines) { [deprecation_log_line, 'Random log line 1', 'Random log line 2'] }
      let(:filter) { double('filter') }
      let(:classifier_result) { classifier.process(lines, filter) }

      subject(:classifier) { described_class.new('') }

      describe '#match?' do
        context 'when the log line is an access html mime types via constants deprecation warning' do
          let(:cleaned_log_line) { cleaned_log_line_html }

          it 'matches' do
            expect(classifier.match?(deprecation_log_line)).to be true
          end
        end

        context 'when the log line is an access js mime types via constants deprecation warning' do
          let(:cleaned_log_line) { cleaned_log_line_js }

          it 'matches' do
            expect(classifier.match?(deprecation_log_line)).to be true
          end
        end

        context 'when the log line is not an access mime types via constants deprecation warning' do
          let(:cleaned_log_line) { "random deprecation message. This behavior is deprecated and will be changed with Rails 5.1 to only do something else. Use #other_thing instead. (called from #{method} at #{file}:#{line_number})" }

          it 'does not match' do
            expect(classifier.match?(deprecation_log_line)).to be false
          end
        end
      end

      describe '#process' do
        context 'when the warning is an access html mime type via constant' do
          let(:cleaned_log_line) { cleaned_log_line_html }

          before { allow(filter).to receive(:clean).with(deprecation_log_line).and_return(cleaned_log_line) }

          it 'returns an access mime types via constants deprecation warning' do
            expect(classifier_result.deprecation_warning).to have_attributes(
              :deprecated => 'Mime types via constants',
              :summary => 'Accessing mime types via constants is deprecated',
              :message => 'Accessing mime types via constants is deprecated. Please change `Mime::HTML` to `Mime[:html]`.',
              :method => method,
              :file => file,
              :line_number => line_number
            )
          end

          it 'returns the access mime types via constants deprecation warning log line' do
            expect(classifier_result.log_lines).to eq [deprecation_log_line]
          end
        end

        context 'when the warning is an access js mime type via constant' do
          let(:cleaned_log_line) { cleaned_log_line_js }

          before { allow(filter).to receive(:clean).with(deprecation_log_line).and_return(cleaned_log_line) }

          it 'returns an access mime types via constants deprecation warning' do
            expect(classifier_result.deprecation_warning).to have_attributes(
              :deprecated => 'Mime types via constants',
              :summary => 'Accessing mime types via constants is deprecated',
              :message => 'Accessing mime types via constants is deprecated. Please change `Mime::JS` to `Mime[:js]`.',
              :method => method,
              :file => file,
              :line_number => line_number
            )
          end

          it 'returns the access mime types via constants deprecation warning log line' do
            expect(classifier_result.log_lines).to eq [deprecation_log_line]
          end
        end
      end
    end
  end
end