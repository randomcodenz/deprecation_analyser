# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe 'class_argument_in_active_record_query' do
      it_behaves_like 'a simple classifier' do
        let(:classifier_name) { 'class_argument_in_active_record_query' }
        let(:deprecation_warning) { 'Passing a class as a value in an Active Record query is deprecated and will be removed. Pass a string instead.' }
      end
    end
  end
end
