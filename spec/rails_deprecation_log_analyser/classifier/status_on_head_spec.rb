# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe 'status_on_head' do
      it_behaves_like 'a simple classifier' do
        let(:classifier_name) { 'status_on_head' }
        let(:deprecation_warning) { 'The :status option on `head` has been deprecated and will be removed in Rails 5.1. Please pass the status as a separate parameter before the options, instead' }
      end
    end
  end
end
