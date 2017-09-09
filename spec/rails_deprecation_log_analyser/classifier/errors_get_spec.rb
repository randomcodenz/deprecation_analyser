# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe ErrorsGet do
      it_behaves_like 'a deprecation warning classifier' do
        let(:deprecation_warning) { 'ActiveModel::Errors#get is deprecated and will be removed in Rails 5.1. To achieve the same use model.errors[:customer_billing].' }
        let(:deprecated) { 'ActiveModel::Errors#get' }
        let(:summary) { 'ActiveModel::Errors#get is deprecated and will be removed in Rails 5.1.' }
        let(:message) { 'ActiveModel::Errors#get is deprecated and will be removed in Rails 5.1. To achieve the same use model.errors[:attribute_name].' }
      end
    end
  end
end
