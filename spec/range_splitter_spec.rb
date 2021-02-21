# frozen_string_literal: true

require 'date'
require 'range_splitter'

RSpec.describe RangeSplitter do
  describe '#slit_for_chunks' do
    context 'when block is given and it returns a result' do
      subject do
        described_class.new.slit_for_chunks(price_per_day, max_chunk_length) do |date_from, date_to, amount|
          [date_from.to_s, date_to.to_s, amount.to_s].join(' / ')
        end
      end
      let(:max_chunk_length) { 2 }
      let(:price_per_day) do
        {
          Date.new(2020, 2, 3) => 10_000,
          Date.new(2020, 2, 4) => 10_100,
          Date.new(2020, 2, 5) => 10_200,
          Date.new(2020, 2, 6) => 10_300,
          Date.new(2020, 2, 7) => 10_400,
          Date.new(2020, 2, 8) => 10_500
        }
      end
      let(:expected_result) do
        [
          '2020-02-03 / 2020-02-04 / 20100',
          '2020-02-05 / 2020-02-06 / 20500',
          '2020-02-07 / 2020-02-08 / 20900',
        ]
      end

      it { is_expected.to eq(expected_result) }
    end

    context 'when the length of the range is 5 and the length limit is 7' do
      let(:max_chunk_length) { 7 }
      let(:price_per_day) do
        {
          Date.new(2020, 10, 11) => 10_000,
          Date.new(2020, 10, 12) => 10_300,
          Date.new(2020, 10, 13) => 10_200,
          Date.new(2020, 10, 14) => 10_000,
          Date.new(2020, 10, 15) => 10_400
        }
      end

      it 'yields the given block once with the first and last date of the range and amount' do
        expect { |b| subject.slit_for_chunks(price_per_day, max_chunk_length, &b) }.to(
          yield_with_args(Date.new(2020, 10, 11), Date.new(2020, 10, 15), 50_900)
        )
      end
    end

    context 'when the length of the range is 8 and the length limit is 5' do
      let(:max_chunk_length) { 5 }
      let(:price_per_day) do
        {
          Date.new(2020, 9, 15) => 10_000,
          Date.new(2020, 9, 20) => 10_000,
          Date.new(2020, 9, 16) => 10_200,
          Date.new(2020, 9, 19) => 10_200,
          Date.new(2020, 9, 22) => 10_300,
          Date.new(2020, 9, 18) => 10_300,
          Date.new(2020, 9, 21) => 10_400,
          Date.new(2020, 9, 17) => 10_400
        }
      end

      it 'yields the given block twice with dates and amounts for each chunk' do
        expect { |b| subject.slit_for_chunks(price_per_day, max_chunk_length, &b) }.to(
          yield_successive_args(
            [Date.new(2020, 9, 15), Date.new(2020, 9, 19), 51_100],
            [Date.new(2020, 9, 20), Date.new(2020, 9, 22), 30_700]
          )
        )
      end
    end
  end
end
