# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe 'pass_instance_to_exists' do
      it_behaves_like 'a simple classifier' do
        let(:classifier_name) { 'pass_instance_to_exists' }
        let(:deprecation_warning) { 'You are passing an instance of ActiveRecord::Base to `exists?`. Please pass the id of the object by calling `.id`.' }
      end
    end
  end
end
