# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe 'equality_comparison_beween_parameters_and_hash' do
      it_behaves_like 'a simple classifier' do
        let(:classifier_name) { 'equality_comparison_beween_parameters_and_hash' }
        let(:deprecation_warning) { "Comparing equality between `ActionController::Parameters` and a `Hash` is deprecated and will be removed in Rails 5.1. Please only do comparisons between instances of `ActionController::Parameters`. If you need to compare to a hash, first convert it using `ActionController::Parameters#new`." }
      end
    end
  end
end
