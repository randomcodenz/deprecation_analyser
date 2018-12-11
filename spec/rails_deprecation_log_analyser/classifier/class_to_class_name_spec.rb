# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe 'class_to_class_name' do
      it_behaves_like 'a simple classifier' do
        let(:classifier_name) { 'class_to_class_name' }
        let(:deprecation_warning) { 'Passing a class to the `class_name` is deprecated and will raise an ArgumentError in Rails 5.2. It eagerloads more classes than necessary and potentially creates circular dependencies. Please pass the class name as a string.' }
      end
    end
  end
end
