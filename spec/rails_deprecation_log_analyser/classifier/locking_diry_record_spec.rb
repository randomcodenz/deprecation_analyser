# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe LockingDiryRecord do
      it_behaves_like 'a deprecation warning classifier' do
        let(:deprecation_warning) { 'Locking a record with unpersisted changes is deprecated and will raise an exception in Rails 5.2. Use `save` to persist the changes, or `reload` to discard them explicitly.' }
        let(:deprecated) { 'Locking a dirty record' }
        let(:summary) { 'Locking a record with unpersisted changes is deprecated and will raise an exception in Rails 5.2.' }
        let(:message) { 'Locking a record with unpersisted changes is deprecated and will raise an exception in Rails 5.2. Use `save` to persist the changes, or `reload` to discard them explicitly.' }
      end
    end
  end
end
