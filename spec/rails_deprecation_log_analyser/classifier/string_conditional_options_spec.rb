# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe 'string_conditional_options' do
      it_behaves_like 'a simple classifier' do
        let(:classifier_name) { 'string_conditional_options' }
        let(:deprecation_warning) { 'Passing string to be evaluated in :if and :unless conditional options is deprecated and will be removed in Rails 5.2 without replacement. Pass a symbol for an instance method, or a lambda, proc or block, instead.' }
      end
    end
  end
end
