# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe ErrorsSet do
      it_behaves_like 'a deprecation warning classifier' do
        let(:deprecation_warning) { 'ActiveModel::Errors#[]= is deprecated and will be removed in Rails 5.1. Use model.errors.add(:attribute_name, "Error message") instead.' }
        let(:deprecated) { 'ActiveModel::Errors#[]=' }
        let(:summary) { 'ActiveModel::Errors#[]= is deprecated and will be removed in Rails 5.1.' }
        let(:message) { 'ActiveModel::Errors#[]= is deprecated and will be removed in Rails 5.1. Use model.errors.add(:attribute_name, "Error message") instead.' }
      end
    end
  end
end
