# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe 'redirect_to_back' do
      it_behaves_like 'a simple classifier' do
        let(:classifier_name) { 'redirect_to_back' }
        let(:deprecation_warning) { '`redirect_to :back` is deprecated and will be removed from Rails 5.1. Please use `redirect_back(fallback_location: fallback_location)` where `fallback_location` represents the location to use if the request has no HTTP referer information.' }
      end
    end
  end
end
