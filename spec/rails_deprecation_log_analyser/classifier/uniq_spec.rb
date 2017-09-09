# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe Uniq do
      it_behaves_like 'a deprecation warning classifier' do
        let(:deprecation_warning) { 'uniq is deprecated and will be removed from Rails 5.1 (use distinct instead)' }
        let(:deprecated) { 'uniq' }
        let(:summary) { 'uniq is deprecated and will be removed from Rails 5.1' }
        let(:message) { 'uniq is deprecated and will be removed from Rails 5.1, use distinct instead' }
      end
    end
  end
end
