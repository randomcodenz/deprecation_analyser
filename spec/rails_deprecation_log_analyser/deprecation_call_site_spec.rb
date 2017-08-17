# frozen_string_literal : true

require 'spec_helper'

module RailsDeprecationLogAnalyser
  RSpec.describe DeprecationCallSite do
    let(:source_directory) { '' }

    subject(:call_site) { DeprecationCallSite.new(line, source_directory) }

    context 'when the line does not contain any call site information' do
      let(:line) { 'Random line of text with no rails deprecation warning call site information' }

      it 'indicates no call site information was found' do
        expect(call_site).not_to be_found
      end

      it 'contains no call site details' do
        expect(call_site.file).to be_empty
        expect(call_site.line_number).to be_empty
      end

      it 'the method returns a default value' do
        expect(call_site.method).to eq DeprecationCallSite::UNKNOWN_METHOD
      end
    end

    context 'when the line contains call site information' do
      let(:method_name) { 'foo_bar' }
      let(:file_name) { '/some/random/file/path/foo.rb' }
      let(:line_number) { 998 }

      let(:line) { "Random line of text with some rails deprecation warning (called from #{method_name} at #{file_name}:#{line_number}) call site information" }

      it 'indicates the call site information was found' do
        expect(call_site).to be_found
      end

      it 'contains the call site details' do
        expect(call_site.file).to eq file_name
        expect(call_site.line_number).to eq line_number.to_s
      end

      it 'contains the method name' do
        expect(call_site.method).to eq method_name
      end

      context 'when a source directory is provided' do
        let(:source_directory) { '/some/random' }
        let(:relative_file_name) { 'file/path/foo.rb'}

        it 'the file path is relative to the source directory' do
          expect(call_site.file).to eq relative_file_name
        end
      end
    end

    describe '#<=>' do
      it 'to do'
    end
  end
end