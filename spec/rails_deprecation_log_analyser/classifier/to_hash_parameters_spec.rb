# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe ToHashParameters do
      it_behaves_like 'a deprecation warning classifier' do
        let(:deprecation_warning) { '#to_hash unexpectedly ignores parameter filtering, and will change to enforce it in Rails 5.1. Enable `raise_on_unfiltered_parameters` to respect parameter filtering, which is the default in new applications. For the existing deprecated behaviour, call #to_unsafe_h instead.' }
        let(:deprecated) { '#to_hash on parameters' }
        let(:summary) { '#to_hash unexpectedly ignores parameter filtering, and will change to enforce it in Rails 5.1.' }
        let(:message) { '#to_hash unexpectedly ignores parameter filtering, and will change to enforce it in Rails 5.1. Enable `raise_on_unfiltered_parameters` to respect parameter filtering, which is the default in new applications. For the existing deprecated behaviour, call #to_unsafe_h instead.' }
      end
    end
  end
end
