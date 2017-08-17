#frozen_string_literal: true

require 'spec_helper'

module RailsDeprecationLogAnalyser
  RSpec.describe LogCursor do
    context 'when creating a new LogCursor' do
      it 'initialises index to -1'
    end

    describe '#peek' do
      context 'when #take has not been called' do
        it 'returns the first line'
        it 'does not change the index'
        it 'always returns the same value'
      end

      context 'when #take has been called' do
        it 'returns the next line'
        it 'does not change the index'
        it 'always returns the same value'
      end

      context 'when the cursor is at the end of the log' do
        it 'returns nil'
      end
    end

    describe '#take' do
      context 'when the number of lines to take has not been specified' do
        it 'returns the next line'
        it 'increments the index by 1'
      end

      context 'when the number of lines to take has been specified' do
        it 'returns the specified number of lines from the current cursor position'
        it 'increments the index by the number of lines specified'
      end

      context 'when #peek has been called before #take' do
        context 'when taking 1 line' do
          it 'returns the peeked line'
        end

        context 'when taking n lines' do
          it 'the first line returned is the peeked line'
        end

        context 'when the cursor is at the end of the log' do
          it 'raise a StopIteration error'
        end

        context 'when the number of lines to take is more than the number of lines remaining' do
          it 'returns the number of lines available'
          it 'moves the cursor to the end of the log'
        end
      end
    end
  end
end