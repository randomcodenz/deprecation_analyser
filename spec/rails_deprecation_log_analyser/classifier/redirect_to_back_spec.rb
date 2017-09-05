# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe RedirectToBack do
      it_behaves_like 'a deprecation warning classifier' do
        let(:deprecation_warning) { '`redirect_to :back` is deprecated and will be removed from Rails 5.1. Please use `redirect_back(fallback_location: fallback_location)` where `fallback_location` represents the location to use if the request has no HTTP referer information.' }
        let(:deprecated) { '`redirect_to :back` is deprecated' }
        let(:summary) { '`redirect_to :back` is deprecated and will be removed from Rails 5.1.' }
        let(:message) { '`redirect_to :back` is deprecated and will be removed from Rails 5.1. Please use `redirect_back(fallback_location: fallback_location)` where `fallback_location` represents the location to use if the request has no HTTP referer information.' }
      end
    end
  end
end
