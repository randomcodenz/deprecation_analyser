# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe 'locking_diry_record' do
      it_behaves_like 'a simple classifier' do
        let(:classifier_name) { 'locking_diry_record' }
        let(:deprecation_warning) { 'Locking a record with unpersisted changes is deprecated and will raise an exception in Rails 5.2. Use `save` to persist the changes, or `reload` to discard them explicitly.' }
      end
    end
  end
end
