# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe RenderText do
      it_behaves_like 'a deprecation warning classifier' do
        let(:deprecation_warning) { '`render :text` is deprecated because it does not actually render a `text/plain` response. Switch to `render plain: \'plain text\'` to render as `text/plain`, `render html: \'<strong>HTML</strong>\'` to render as `text/html`, or `render body: \'raw\'` to match the deprecated behavior and render with the default Content-Type, which is `text/html`.' }
        let(:deprecated) { '`render :text` response' }
        let(:summary) { '`render :text` is deprecated because it does not actually render a `text/plain` response.' }
        let(:message) { '`render :text` is deprecated because it does not actually render a `text/plain` response. Switch to `render plain: \'plain text\'` to render as `text/plain`, `render html: \'<strong>HTML</strong>\'` to render as `text/html`, or `render body: \'raw\'` to match the deprecated behavior and render with the default Content-Type, which is `text/html`.' }
      end
    end
  end
end
