# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe MimeTypeConstants do
      context 'when the log line is an access html mime types via constants deprecation warning' do
        it_behaves_like 'a deprecation warning classifier' do
          let(:deprecation_warning) { 'Accessing mime types via constants is deprecated. Please change `Mime::HTML` to `Mime[:html]`.' }
          let(:deprecated) { 'Mime types via constants' }
          let(:summary) { 'Accessing mime types via constants is deprecated' }
          let(:message) { 'Accessing mime types via constants is deprecated. Please change `Mime::HTML` to `Mime[:html]`.' }
        end
      end

      context 'when the log line is an access js mime types via constants deprecation warning' do
        it_behaves_like 'a deprecation warning classifier' do
          let(:deprecation_warning) { 'Accessing mime types via constants is deprecated. Please change `Mime::JS` to `Mime[:js]`.' }
          let(:deprecated) { 'Mime types via constants' }
          let(:summary) { 'Accessing mime types via constants is deprecated' }
          let(:message) { 'Accessing mime types via constants is deprecated. Please change `Mime::JS` to `Mime[:js]`.' }
        end
      end
    end
  end
end