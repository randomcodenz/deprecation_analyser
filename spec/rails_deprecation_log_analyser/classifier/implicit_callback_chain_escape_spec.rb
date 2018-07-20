# frozen_string_literal: true

require 'spec_helper'
require 'rails_deprecation_log_analyser/classifier/shared_examples'

module RailsDeprecationLogAnalyser
  module Classifier
    RSpec.describe 'implicit_callback_chain_escape' do
      it_behaves_like 'a simple classifier' do
        let(:classifier_name) { 'implicit_callback_chain_escape' }
        let(:deprecation_warning) { 'Returning `false` in Active Record and Active Model callbacks will not implicitly halt a callback chain in Rails 5.1. To explicitly halt the callback chain, please use `throw :abort` instead.' }
      end
    end
  end
end
