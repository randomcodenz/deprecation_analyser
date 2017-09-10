# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe AssociationReloadArgument do
      it_behaves_like 'a deprecation warning classifier' do
        let(:deprecation_warning) { 'Passing an argument to force an association to reload is now deprecated and will be removed in Rails 5.1. Please call `reload` on the result collection proxy instead.' }
        let(:deprecated) { 'Association reload argument' }
        let(:summary) { 'Passing an argument to force an association to reload is now deprecated and will be removed in Rails 5.1.' }
        let(:message) { 'Passing an argument to force an association to reload is now deprecated and will be removed in Rails 5.1. Please call `reload` on the result collection proxy instead.' }
      end
    end
  end
end
