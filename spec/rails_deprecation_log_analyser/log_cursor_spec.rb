#frozen_string_literal: true

require 'spec_helper'

module RailsDeprecationLogAnalyser
  RSpec.describe LogCursor do
    let(:first) { 1 }
    let(:second) { 2 }
    let(:third) { 3 }
    let(:log) { [first, second, third] }

    subject(:cursor) { described_class.new(log) }

    context 'when creating a new LogCursor' do
      it 'initialises index to -1' do
        expect(cursor.index).to eq -1
      end
    end

    describe '#peek' do
      context 'when #take has not been called' do
        it 'returns the first line' do
          expect(cursor.peek).to eq first
        end

        it 'does not change the index' do
          expect(cursor.index).to eq -1
        end

        it 'always returns the same value' do
          expect(cursor.peek).to eq cursor.peek
        end
      end

      context 'when #take has been called' do
        before { cursor.take }

        it 'returns the next line' do
          expect(cursor.peek).to eq second
        end

        it 'does not change the index' do
          expect(cursor.index).to eq 0
        end

        it 'always returns the same value' do
          expect(cursor.peek).to eq cursor.peek
        end
      end

      context 'when the cursor is at the end of the log' do
        before { cursor.take(3) }

        it 'returns nil' do
          expect(cursor.peek).to be_nil
        end
      end
    end

    describe '#take' do
      context 'when the number of lines to take has not been specified' do
        it 'returns the next line' do
          expect(cursor.take).to match [first]
        end

        it 'increments the index by 1' do
          expect { cursor.take }.to change { cursor.index }.from(-1).to(0)
        end
      end

      context 'when the number of lines to take has been specified' do
        before { cursor.take }

        it 'returns the specified number of lines from the current cursor position' do
          expect(cursor.take(2)).to match [second, third]
        end

        it 'increments the index by the number of lines specified' do
          expect { cursor.take(2) }.to change { cursor.index }.from(0).to(2)
        end
      end

      context 'when #peek has been called before #take' do
        before { cursor.peek }

        context 'when taking 1 line' do
          it 'returns the peeked line' do
            expect(cursor.take).to match [first]
          end
        end

        context 'when taking n lines' do
          it 'the first line returned is the peeked line' do
            expect(cursor.take(2)).to match [first, second]
          end
        end
      end

      context 'when the cursor is at the end of the log' do
        before { cursor.take(3) }

        it 'raise a StopIteration error' do
          expect { cursor.take }.to raise_error(StopIteration)
        end
      end

      context 'when the number of lines to take is more than the number of lines remaining' do
        it 'returns the number of lines available' do
          expect(cursor.take(5)).to match [first, second, third]
        end

        it 'moves the cursor to the end of the log' do
          cursor.take(5)
          expect(cursor.peek).to eq nil
          expect { cursor.take }.to raise_error(StopIteration)
        end
      end
    end
  end
end