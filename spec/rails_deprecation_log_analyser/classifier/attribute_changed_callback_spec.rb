# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe 'attribute_changed_callback' do
      it_behaves_like 'a simple classifier' do
        let(:classifier_name) { 'attribute_changed_callback' }
        let(:deprecation_warning) { 'The behavior of `attribute_changed?` inside of after callbacks will be changing in the next version of Rails. The new return value will reflect the behavior of calling the method after `save` returned (e.g. the opposite of what it returns now). To maintain the current behavior, use `saved_change_to_attribute?` instead.' }
      end
    end
  end
end
