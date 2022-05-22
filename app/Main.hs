module Main where

--my modules
import Lib
import PgRnReader (readWebPages)
import Process (process,processAnc)
import Pagerank
--modules
import qualified Data.Text    as Text
import qualified Data.Text.IO as Text
import Data.List.Split
import Data.List (isInfixOf)
import Data.Foldable


main :: IO ()
main = do
    putStrLn "Please type the name of an input file"
    --nacitanie a parsovanie stranok
    input_file<-getLine
    readWebPages input_file
    putStrLn    "Webpages loaded and parsed"
    --nacitanie urls do listu
    ls <- readFile "data/urls.txt"
    let urls = lines ls
    --nacitanie anchor suboru
    anchor_list<-readFile "data/anchors.txt"
    let parsed_anchor_list = splitOn "," anchor_list
    putStrLn    "Anchors loaded and parsed"

    --hlavny cyklus pre kazdu url process, potom pre kazdy anchor zisti ci je v urls, ak nie, napis 0 1 ak ano, process current anchor
    forM_ urls $ \url -> do 
        process "data/parsed_htmls.txt" parsed_anchor_list url

        --nacitanie current_anchors suboru
        c_a<- readFile "data/current_anchors.txt"
        let parsed_c_a = splitOn "," c_a

        forM_ parsed_c_a $ \anc -> do 
            if anc `elem` urls
                then
                    processAnc "data/parsed_htmls.txt" parsed_anchor_list anc
                else
                    appendFile "data/graph.txt" "0 1\n"
        --po dokonceni cyklu vypocitaj pagerank
        f<-readFile "data/graph.txt"
        appendFile "output/pagerank.txt" (url ++" ")
        --dropFromList 0 iter_urls
        let all_pgrnk = show $ processPagerank f 15 0.85
        let pgrnk = drop 3 $ dropWhile (/= '(') $ takeWhile (/= ')')  all_pgrnk
        appendFile "output/pagerank.txt" (pgrnk++"\n")
        writeFile "data/graph.txt" ""
    
    --cistenie suborov na konci programu
    writeFile "data/anchors.txt" ""
    writeFile "data/current_anchors.txt" ""
    writeFile "data/parsed_htmls.txt" ""
    writeFile "data/urls.txt" ""
    putStrLn "Done. PageRank can be found in output/pagerank.txt"