# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe PassInstanceToExists do
      it_behaves_like 'a deprecation warning classifier' do
        let(:deprecation_warning) { 'You are passing an instance of ActiveRecord::Base to `exists?`. Please pass the id of the object by calling `.id`.' }
        let(:deprecated) { 'Passing instance to exists?' }
        let(:summary) { 'You are passing an instance of ActiveRecord::Base to `exists?`.' }
        let(:message) { 'You are passing an instance of ActiveRecord::Base to `exists?`. Please pass the id of the object by calling `.id`.' }
      end
    end
  end
end
