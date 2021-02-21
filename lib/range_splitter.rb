# frozen_string_literal: true

class RangeSplitter
  # = Splits a range of dates for chunks
  #
  # It splits a range for chunks with defined length, yields the given block
  # for the each chunk and returns a list of results of each yield.
  #
  #   price_per_day = {
  #     Date.new(2020, 2, 3) => 10_000,
  #     Date.new(2020, 2, 4) => 10_100,
  #     Date.new(2020, 2, 5) => 10_200
  #   }
  #   results = slit_for_chunks(price_per_day, 2) do |date_from, date_to, amount|
  #     # process the chunk and return result
  #     # date_from - the first date of the chunk
  #     # date_to - the last date of the chunk
  #     # amount - the sum of amounts of the chunk
  #   end
  #
  # @param [Hash] price_per_day list of prices per date for the range as Date => Integer
  # @param [Integer] max_chunk_length the maximum length of the chunk
  # @return [Array] list of results of each yield
  def slit_for_chunks(price_per_day, max_chunk_length)
    # @TODO: complete the method
  end
end
