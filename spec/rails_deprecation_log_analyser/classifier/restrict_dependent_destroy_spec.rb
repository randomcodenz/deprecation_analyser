# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe RestrictDependentDestory do
      it_behaves_like 'a deprecation warning classifier' do
        let(:deprecation_warning) { "The error key `:'restrict_dependent_destroy.many'` has been deprecated and will be removed in Rails 5.1. Please use `:'restrict_dependent_destroy.has_many'` instead." }
        let(:deprecated) { 'Restrict dependent destroy - many' }
        let(:summary) { "The error key `:'restrict_dependent_destroy.many'` has been deprecated and will be removed in Rails 5.1." }
        let(:message) { "The error key `:'restrict_dependent_destroy.many'` has been deprecated and will be removed in Rails 5.1. Please use `:'restrict_dependent_destroy.has_many'` instead." }
      end
    end
  end
end
