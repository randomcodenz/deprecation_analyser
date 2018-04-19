# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe AttributeWasCallback do
      it_behaves_like 'a deprecation warning classifier' do
        let(:deprecation_warning) { 'The behavior of `attribute_was` inside of after callbacks will be changing in the next version of Rails. The new return value will reflect the behavior of calling the method after `save` returned (e.g. the opposite of what it returns now). To maintain the current behavior, use `attribute_before_last_save` instead.' }
        let(:deprecated) { '"attribute_was" inside of after callbacks' }
        let(:summary) { 'The behavior of `attribute_was` inside of after callbacks will be changing in the next version of Rails.' }
        let(:message) { 'The behavior of `attribute_was` inside of after callbacks will be changing in the next version of Rails. The new return value will reflect the behavior of calling the method after `save` returned (e.g. the opposite of what it returns now). To maintain the current behavior, use `attribute_before_last_save` instead.' }
      end
    end
  end
end
