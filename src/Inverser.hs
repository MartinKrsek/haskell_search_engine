{-# LANGUAGE OverloadedStrings, DeriveGeneric, DeriveAnyClass #-}

-- sources: https://www.educative.io/edpresso/how-to-merge-lists-in-haskell
--          https://www.schoolofhaskell.com/school/starting-with-haskell/libraries-and-frameworks/text-manipulation/json
--          https://github.com/lduranovic99/Inverted-Index

module Inverser
    (
        inverse,
    )
where

import Data.Aeson
import Data.Text
import Control.Applicative
import Control.Monad
import qualified Data.ByteString.Lazy as B
import Data.List
import Data.Maybe
import GHC.Generics
import System.IO
import Data.List
import Data.Maybe
import Data.Char (isAlpha, toLower, isSpace)
import qualified Data.Set
import Data.Text.Lazy.IO as I
import Data.Aeson.Text (encodeToLazyText)

-- | Type of each JSON entry in record syntax.
data ForwardIndex =
  ForwardIndex { listOfWords  :: [String]
         , webId   :: Int
           } deriving (Show,Generic)

-- Instances to convert our type to/from JSON.

instance FromJSON ForwardIndex
instance ToJSON ForwardIndex

-- | Location of the local copy, in case you have it,
--   of the JSON file.
jsonFile :: FilePath
jsonFile = "archive/parsedHtml.json"

-- Read the local copy of the JSON file.
getJSON :: IO B.ByteString
getJSON = B.readFile jsonFile

inverse :: IO()
inverse = do
    -- Get JSON data and decode it
 d <- (eitherDecode <$> getJSON) :: IO (Either String [ForwardIndex])
 -- If d is Left, the JSON was malformed.
 -- In that case, we report the error.
 -- Otherwise, we perform the operation of
 -- our choice. In this case, just print it.
 case d of
  Left err -> System.IO.putStrLn err
  Right ps -> testfunction2 ps

getWords              :: [(Int, String)] -> [(Int, [String])]
getWords []           = []
getWords ((n,str):xs) = 
    (n, Data.List.words $ str) : getWords xs

getSomething :: [ForwardIndex] -> [(Int, [String])]
getSomething [] = []
getSomething ((forwardIndex):xs) = (webId forwardIndex, nub $ listOfWords forwardIndex) : getSomething xs

indexPages :: [(Int, [String])] -> [(String, Int)]
indexPages [] = []
indexPages (page:restOfPages) =
    (indexSinglePage page) ++ (indexPages restOfPages)

invertedIndex :: [(String, Int)] -> [(String, [Int])]
invertedIndex [] = []
invertedIndex fullList@(x:xs) = 
    (processSingleWord x) : (invertedIndex $ deleteWord x xs)
        where processSingleWord (word, pageNum) =
                  let newList = Data.List.filter (\(currWord, currPageNum) -> currWord == word) fullList
                      newWordList = nub $ Data.List.map (\(str, n) -> n) newList
                  in (word, newWordList)
              deleteWord _ [] = []
              deleteWord word wordList =
                  Data.List.filter (\(currWord, currPageNum) -> currWord /= (fst word)) wordList

indexSinglePage :: (Int, [String]) -> [(String, Int)]
indexSinglePage (pageNum, []) = []
indexSinglePage (pageNum, (firstWord:restOfWords)) = 
    (firstWord, pageNum) : indexSinglePage (pageNum, restOfWords)

data InversedIndex =
  InversedIndex { word  :: String
         , listOfWebIds   :: [Int]
           } deriving (Show,Generic,Data.Aeson.ToJSON)

createInversedClass :: ([(String, [Int])]) -> [InversedIndex]
createInversedClass [] = []
createInversedClass (element : restOfElements) = InversedIndex { word = fst element, listOfWebIds = snd element } : createInversedClass restOfElements

-- xs = pole ForwardIndex class
testfunction2 xs = do
 let  numberedWords = getSomething xs
      wordPagePairs = indexPages numberedWords
      finalList     = invertedIndex wordPagePairs
 let finalClasses = createInversedClass finalList
 I.writeFile "archive/inverseIndex.json" (encodeToLazyText finalClasses)