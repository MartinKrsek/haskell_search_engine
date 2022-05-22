  <a href="https://github.com/MartinKrsek/haskell_search_engine/blob/master/README.md">
  English readme
  <img src="img/flagEn.png" alt="Slovak flag" width="15" height="10">
  </a>

# __Haskell vyhľadávač__
Vítame Vás na github repozitári nášho projektu. Toto je náš semestrálny tímový projekt kde sme implementovali vyhľadávač pomocou haskellu.

# __Začíname__
Tu je príklad, ako nastaviť a spustiť tento projekt lokálne.
## __Prerekvizity__
 - nainštalovaný [stack](https://docs.haskellstack.org/en/stable/README/)
 - stiahnutý a rozbalený [priečinok](https://datasetsearch.research.google.com/search?query=html%20pages&docid=L2cvMTFqbnpkbGhsbQ%3D%3D) v priečinku _archive/folder_

## __Používateľska príručka__
__Dôležitá poznámka:__
Indexovanie trvá na veľkých súboroch dlho. Preto veľmi odporúčame využitie poskytnutého súboru _archive/collectionFirst100.jl_. Môžete tak urobiť zmenou riadku `createIndices "archive/collection.jl"` na `createIndices "archive/collectionFirst100.jl"` vo vnútri _Main.hs_ súboru. Taktiež môžete využiť pripravený python súbor _head.py_ na vytvorenie vlastného súboru z N prvých riadkov pôvodného súboru.
 - V hlavnom priečinku spustite príkazy:
    - ```stack build```
    - ```stack run```
 - Mali by ste vidieť správu: ```Hi, do You want to create new indices?(y/n)```
   - Pokiaľ zadáte _'y'_ a stlačíte `Enter` nové indexy budú vypočítané a uložené do súborov(tento proces môže trvať niekoľko sekúnd):
      - _archive/inverseIndex.json_
      - _archive/indices.json_
      - _archive/parsedHtml.json_
   - Pokiaľ zadáte _'n'_ a stlačíte `Enter` staré indexy budú použité(ak existujú).
 - Môžete si prehliadať príkladové index json súbory v _archive/{fileName}Sample.json_.
 - Po dokončení indexovania, uvidíte novú požiadavku od programu: ```What are you looking for?```. Zadajte akékoľvek slovo, ktoré si želáte vyhľadávať a stlačte enter. Nás vyhľadávač funguje iba na ASCII charakteroch a na slová v dĺžkovom rozmädzí 2 až 20.
 - Mali by ste vidieť výsledok vyhľadávania na Vašej obrazovke.

## __Roadmap__
- [x] Web parsing
    - [x] Words
    - [x] Urls
- [x] Indexer
    - [x] Forward
    - [x] Inverse
- [x] PageRank

__Important note:__ PageRank je implementovaný, ale funkcionálne nieje prepojený so zvyškom programu. Môžete vidieť readme a implementáciu na [pagerank](https://github.com/MartinKrsek/haskell_search_engine/tree/pagerank) branchi nášho projektu.

## __Tím__
 - [Bc. Dominik Fullajtár](https://github.com/fullajtar)
 - [Bc. Samuel Balaščík](https://github.com/cybjorge)
 - [Bc. Martin Kršek](https://github.com/MartinKrsek)

## __Potrebujete pomoc?__
Pokiaľ máte akékoľvek nezodpovedané otázky, neváhajte ma kontaktovať:
 - [Bc. Martin Kršek](mailto:martin.krsek1@gmail.com?subject=[GitHub]%20Haskell%20search%20engine)