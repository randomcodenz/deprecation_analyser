# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe ConditionalDeleteAll do
      it_behaves_like 'a deprecation warning classifier' do
        let(:deprecation_warning) { 'Passing conditions to delete_all is deprecated and will be removed in Rails 5.1. To achieve the same use where(conditions).delete_all.' }
        let(:deprecated) { 'Conditional delete_all' }
        let(:summary) { 'Passing conditions to delete_all is deprecated and will be removed in Rails 5.1.' }
        let(:message) { 'Passing conditions to delete_all is deprecated and will be removed in Rails 5.1. To achieve the same use where(conditions).delete_all.' }
      end
    end
  end
end
