# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe ClassArgumentInActiveRecordQuery do
      it_behaves_like 'a deprecation warning classifier' do
        let(:deprecation_warning) { 'Passing a class as a value in an Active Record query is deprecated and will be removed. Pass a string instead.' }
        let(:deprecated) { 'Class argument in ActiveRecord query' }
        let(:summary) { 'Passing a class as a value in an Active Record query is deprecated and will be removed' }
        let(:message) { 'Passing a class as a value in an Active Record query is deprecated and will be removed. Pass a string instead.' }
      end
    end
  end
end
