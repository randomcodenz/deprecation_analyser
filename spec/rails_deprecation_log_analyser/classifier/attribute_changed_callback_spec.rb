# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe AttributeChangedCallback do
      it_behaves_like 'a deprecation warning classifier' do
        let(:deprecation_warning) { 'The behavior of `attribute_changed?` inside of after callbacks will be changing in the next version of Rails. The new return value will reflect the behavior of calling the method after `save` returned (e.g. the opposite of what it returns now). To maintain the current behavior, use `saved_change_to_attribute?` instead.' }
        let(:deprecated) { '"attribute_changed?" inside of after callbacks' }
        let(:summary) { 'The behavior of `attribute_changed?` inside of after callbacks will be changing in the next version of Rails.' }
        let(:message) { 'The behavior of `attribute_changed?` inside of after callbacks will be changing in the next version of Rails. The new return value will reflect the behavior of calling the method after `save` returned (e.g. the opposite of what it returns now). To maintain the current behavior, use `saved_change_to_attribute?` instead.' }
      end
    end
  end
end
