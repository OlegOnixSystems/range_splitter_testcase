## Testcase: RangeSplitter
* *Complexity: 3/5*
* *Approximate time for to do: 20 min.*

### ToDo
* Fork the repository
* Make changes in your copy
* Make a pull request for review

### Description
Complete the method `RangeSplitter.split_for_chunks`, all cases of `spec/range_splitter_spec.rb` should 
be passed. Method `split_for_chunks` receives two parameters:
* `price_per_day` - list of amounts per date as Date => Integer;
* `max_chunk_length` - integer of the maximum length of the chunk.

The method should split `price_per_day` for chunks by `max_chunk_length`, yield the given block with 
the first date of the chunk, last date of the chunk and sum of amounts of the chunk. The method should 
collect and return the results of each yield.
