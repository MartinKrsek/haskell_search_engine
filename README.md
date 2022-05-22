  <a href="https://github.com/MartinKrsek/haskell_search_engine/blob/master/README.sk.md">
  Readme po slovensky 
  <img src="img/flagSk.png" alt="Slovak flag" width="15" height="10">
  </a>

# __Haskell search engine__
We welcome You on github repository of our project. This is our school team project where we implement search engine with use of haskell.

# __Getting started__
This is an example of how to set up and run this project locally.
## __Prerequisites__
 - [stack](https://docs.haskellstack.org/en/stable/README/) installed
 - download and unpack files from [folder](https://datasetsearch.research.google.com/search?query=html%20pages&docid=L2cvMTFqbnpkbGhsbQ%3D%3D) into _archive/folder_ directory

## __Usage__
__Important note:__
Indexing does take too long depending on file size. We do strongly encourage You to use provided file _archive/collectionFirst100.jl_. You can do so by changing line `createIndices "archive/collection.jl"` for `createIndices "archive/collectionFirst100.jl"` inside _Main.hs_ file. You can also use prepared python file _head.py_ to export first N lines of file and use this, smaller file.
 - In root folder run commands:
    - ```stack build```
    - ```stack run```
 - After this, You should see message: ```Hi, do You want to create new indices?(y/n)```
   - If You enter _'y'_ and hit `Enter` new indices will be created and saved into files(this can take couple of seconds):
      - _archive/inverseIndex.json_
      - _archive/indices.json_
      - _archive/parsedHtml.json_
   - If You enter _'n'_ and press `Enter` old indices will be used(if existing).
 - You can preview example index json files in _archive/{fileName}Sample.json_.
 - After indexing was successful, You will see new prompt: ```What are you looking for?```. Enter anything You want to search for and hit Enter again. Our search does work only for ASCII characters, words of 2 < length < 20.
 - You should see result of websearch on Your screen.

## __Roadmap__
- [x] Web parsing
    - [x] Words
    - [x] Urls
- [x] Indexer
    - [x] Forward
    - [x] Inverse
- [x] PageRank

__Important note:__ PageRank is implemented, but is not functionaly connected to the rest of program. You can see its readme and its implementation inside this github but in branch [pagerank](https://github.com/MartinKrsek/haskell_search_engine/tree/pagerank) 

## __Contributors__
 - [Bc. Dominik Fullajtár](https://github.com/fullajtar)
 - [Bc. Samuel Balaščík](https://github.com/cybjorge)
 - [Bc. Martin Kršek](https://github.com/MartinKrsek)

## __Need help?__
If You have any unanswered questions, please contact us on:
 - [Bc. Martin Kršek](mailto:martin.krsek1@gmail.com?subject=[GitHub]%20Haskell%20search%20engine)