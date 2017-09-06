# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe ExceptParameters do
      it_behaves_like 'a deprecation warning classifier' do
        let(:deprecation_warning) { 'Method except! is deprecated and will be removed in Rails 5.1, as `ActionController::Parameters` no longer inherits from hash. Using this deprecated behavior exposes potential security problems. If you continue to use this method you may be creating a security vulnerability in your app that can be exploited. Instead, consider using one of these documented methods which are not deprecated: http://api.rubyonrails.org/v5.0.3/classes/ActionController/Parameters.html' }
        let(:deprecated) { 'ActionController::Parameters#except!' }
        let(:summary) { 'Method except! is deprecated and will be removed in Rails 5.1, as `ActionController::Parameters` no longer inherits from hash.' }
        let(:message) { 'Method except! is deprecated and will be removed in Rails 5.1, as `ActionController::Parameters` no longer inherits from hash. Using this deprecated behavior exposes potential security problems. If you continue to use this method you may be creating a security vulnerability in your app that can be exploited. Instead, consider using one of these documented methods which are not deprecated: http://api.rubyonrails.org/v5.0.3/classes/ActionController/Parameters.html' }
      end
    end
  end
end
