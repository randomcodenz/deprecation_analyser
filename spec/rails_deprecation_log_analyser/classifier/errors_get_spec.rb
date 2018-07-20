# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe 'errors_get' do
      it_behaves_like 'a simple classifier' do
        let(:classifier_name) { 'errors_get' }
        let(:deprecation_warning) { 'ActiveModel::Errors#get is deprecated and will be removed in Rails 5.1. To achieve the same use model.errors[:customer_billing].' }
      end
    end
  end
end
