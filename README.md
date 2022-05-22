# search-engine-pagerank
This is a implementation of PageRank algorithm for Functional Programing's team course project Haskell Search Engine


PageRank algorithm belongs to https://github.com/derekchiang

PageRank URL https://github.com/derekchiang/Haskell-Page-Rank

### Input
You will be asked to type path to your desired input
### For processing
Script will create these files while running in folder **data**
- anchors.txt
- current_anchors.txt
- graph.txt
- parsed_htmls.txt
- urls.txt
### Output
In folder **output**
- pagerank.txt

## Contents 
- **Pagerank.hs** -computes pagerank of graph
- **PgRnParser.hs** -html/json parsing
- **PgRnReader.hs** 
- **PgRnWriter.hs** 
- *Process.hs** -Page processing (graph nodes)

## Usage
You need to have **stack** installed on your machine in order to run this.
Run commands:
- stack build
- stack run