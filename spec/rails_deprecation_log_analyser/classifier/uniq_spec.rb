# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe 'uniq' do
      it_behaves_like 'a simple classifier' do
        let(:classifier_name) { 'uniq' }
        let(:deprecation_warning) { 'uniq is deprecated and will be removed from Rails 5.1 (use distinct instead)' }
      end
    end
  end
end
