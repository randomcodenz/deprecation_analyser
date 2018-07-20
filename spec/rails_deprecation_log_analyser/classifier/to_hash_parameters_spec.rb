# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe 'to_hash_parameters' do
      it_behaves_like 'a simple classifier' do
        let(:classifier_name) { 'to_hash_parameters' }
        let(:deprecation_warning) { '#to_hash unexpectedly ignores parameter filtering, and will change to enforce it in Rails 5.1. Enable `raise_on_unfiltered_parameters` to respect parameter filtering, which is the default in new applications. For the existing deprecated behaviour, call #to_unsafe_h instead.' }
      end
    end
  end
end
