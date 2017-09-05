# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe ImplicitCallbackChainEscape do
      it_behaves_like 'a deprecation warning classifier' do
        let(:deprecation_warning) { 'Returning `false` in Active Record and Active Model callbacks will not implicitly halt a callback chain in Rails 5.1. To explicitly halt the callback chain, please use `throw :abort` instead.' }
        let(:deprecated) { 'Implicit escaping of callbacks' }
        let(:summary) { 'Returning `false` in Active Record and Active Model callbacks will not implicitly halt a callback chain in Rails 5.1.' }
        let(:message) { 'Returning `false` in Active Record and Active Model callbacks will not implicitly halt a callback chain in Rails 5.1. To explicitly halt the callback chain, please use `throw :abort` instead.' }
      end
    end
  end
end
