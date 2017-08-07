# frozen_string_literal: true

require 'spec_helper'

module RailsDeprecationLogAnalyser
  module Formatter
    RSpec.describe CheckstyleFormatter do
      let(:output) { StringIO.new }
      let(:xml) do
        formatter.write(output)
        output.string
      end

      subject(:formatter) { described_class.new }

      describe '#deprecation_warning' do
        let(:deprecated) { 'Something' }
        let(:summary) { 'A thing was deprecated' }
        let(:method_name) { 'do_a_thing' }
        let(:file_name_1) { 'some_file.rb' }
        let(:file_name_2) { 'some_other_file.rb' }
        let(:line_number) { 99 }
        let(:call_site_message_1) { "(called from #{method_name} at #{file_name_1}:#{line_number})" }
        let(:call_site_message_2) { "(called from #{method_name} at #{file_name_2}:#{line_number})" }
        let(:message_1) { "A thing was deprecated #{call_site_message_1}" }
        let(:message_2) { "A thing was deprecated #{call_site_message_2}" }
        let(:call_site_1) { DeprecationCallSite.new(call_site_message_1) }
        let(:call_site_2) { DeprecationCallSite.new(call_site_message_2) }
        let(:warning_1) do
          DeprecationWarning.new(
            deprecated: deprecated,
            summary: summary,
            message: message_1,
            call_site: call_site_1
          )
        end
        let(:warning_2) do
          DeprecationWarning.new(
            deprecated: deprecated,
            summary: summary,
            message: message_2,
            call_site: call_site_2
          )
        end

        context 'when logging a deprecation warning' do
          let(:checkstyle_xml) do
            <<~XML
            <?xml version='1.0'?>
            <checkstyle>
              <file name='#{file_name_1}'>
                <error line='#{line_number}' severity='warning' message='#{message_1}' source='com.puppycrawl.tools.checkstyle.#{deprecated}'/>
              </file>
            </checkstyle>
            XML
          end

          it 'creates the expected xml document' do
            formatter.deprecation_warning(warning_1, [message_1])
            expect(xml).to eq checkstyle_xml.chomp
          end
        end

        context 'when logging multiple deprecation warnings in different files' do
          let(:checkstyle_xml) do
            <<~XML
            <?xml version='1.0'?>
            <checkstyle>
              <file name='#{file_name_1}'>
                <error line='#{line_number}' severity='warning' message='#{message_1}' source='com.puppycrawl.tools.checkstyle.#{deprecated}'/>
              </file>
              <file name='#{file_name_2}'>
                <error line='#{line_number}' severity='warning' message='#{message_2}' source='com.puppycrawl.tools.checkstyle.#{deprecated}'/>
              </file>
            </checkstyle>
            XML
          end

          it 'creates the expected xml document' do
            formatter.deprecation_warning(warning_1, [message_1])
            formatter.deprecation_warning(warning_2, [message_2])
            expect(xml).to eq checkstyle_xml.chomp
          end
        end

        context 'when logging multiple deprecation warnings in the same file' do
          let(:file_name_2) { file_name_1 }
          let(:checkstyle_xml) do
            <<~XML
            <?xml version='1.0'?>
            <checkstyle>
              <file name='#{file_name_1}'>
                <error line='#{line_number}' severity='warning' message='#{message_1}' source='com.puppycrawl.tools.checkstyle.#{deprecated}'/>
                <error line='#{line_number}' severity='warning' message='#{message_2}' source='com.puppycrawl.tools.checkstyle.#{deprecated}'/>
              </file>
            </checkstyle>
            XML
          end

          it 'creates the expected xml document' do
            formatter.deprecation_warning(warning_1, [message_1])
            formatter.deprecation_warning(warning_2, [message_2])
            expect(xml).to eq checkstyle_xml.chomp
          end
        end
      end
    end
  end
end