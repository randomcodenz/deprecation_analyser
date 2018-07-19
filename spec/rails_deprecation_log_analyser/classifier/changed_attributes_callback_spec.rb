# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe 'changed_attributes_callback' do
      it_behaves_like 'a simple classifier' do
        let(:classifier_name) { 'changed_attributes_callback' }
        let(:deprecation_warning) { 'The behavior of `changed_attributes` inside of after callbacks will be changing in the next version of Rails. The new return value will reflect the behavior of calling the method after `save` returned (e.g. the opposite of what it returns now). To maintain the current behavior, use `saved_changes.transform_values(&:first)` instead.' }
      end
    end
  end
end
