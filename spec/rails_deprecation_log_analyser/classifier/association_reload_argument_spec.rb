# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe 'association_reload_argument' do
      it_behaves_like 'a simple classifier' do
        let(:classifier_name) { 'association_reload_argument' }
        let(:deprecation_warning) { 'Passing an argument to force an association to reload is now deprecated and will be removed in Rails 5.1. Please call `reload` on the result collection proxy instead.' }
      end
    end
  end
end
