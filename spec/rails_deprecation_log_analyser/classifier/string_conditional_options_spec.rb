# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe StringConditionalOptions do
      it_behaves_like 'a deprecation warning classifier' do
        let(:deprecation_warning) { 'Passing string to be evaluated in :if and :unless conditional options is deprecated and will be removed in Rails 5.2 without replacement. Pass a symbol for an instance method, or a lambda, proc or block, instead.' }
        let(:deprecated) { 'strings in :if and :unless conditional options' }
        let(:summary) { 'Passing string to be evaluated in :if and :unless conditional options is deprecated and will be removed in Rails 5.2 without replacement.' }
        let(:message) { 'Passing string to be evaluated in :if and :unless conditional options is deprecated and will be removed in Rails 5.2 without replacement. Pass a symbol for an instance method, or a lambda, proc or block, instead.' }
      end
    end
  end
end
