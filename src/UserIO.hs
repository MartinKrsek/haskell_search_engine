{-# LANGUAGE OverloadedStrings, DeriveGeneric, DeriveAnyClass #-}

-- sources: https://commentedcode.org/blog/2017/05/09/haskell-project-show-compare-and-filter/


module UserIO
    (
        search,
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
import Indices

-- | Type of each JSON entry in record syntax.
data InverseIndex =
  InverseIndex { word  :: String
         , listOfWebIds   :: [Int]
           } deriving (Show,Generic)

-- Instances to convert our type to/from JSON.

instance FromJSON InverseIndex
-- instance ToJSON InverseIndex

-- | Location of the local copy, in case you have it,
--   of the JSON file.
jsonFile :: FilePath
jsonFile = "archive/inverseIndex.json"

-- Read the local copy of the JSON file.
getJSON :: IO B.ByteString
getJSON = B.readFile jsonFile

search :: IO()
search = do
    -- Get JSON data and decode it
 d <- (eitherDecode <$> getJSON) :: IO (Either String [InverseIndex])
 -- If d is Left, the JSON was malformed.
 -- In that case, we report the error.
 case d of
  Left err -> System.IO.putStrLn err
  Right ps -> logicFunction ps

logicFunction ps = do
 System.IO.putStrLn "Hello, What are you looking for?"
 searchFor <- System.IO.getLine
 System.IO.putStrLn "Let me search..."
 let keywords = getWords searchFor
 let webIds = nub (getIndexes (keywords, ps))
 printWebsitesByIds "archive/indices.json" webIds

getIndexes :: ([String], [InverseIndex]) -> [Int]
getIndexes ([],[]) = []
getIndexes ([],fx) = []
getIndexes (keyword:keywords, indexes) =  (findMatchingIndex(keyword, indexes)) ++ getIndexes (keywords, indexes)

findMatchingIndex :: (String, [InverseIndex]) -> [Int]
findMatchingIndex ( _ , []) = []
findMatchingIndex ([], fx) = []
findMatchingIndex (keyword, index:indexes) = 
 if keywordEqualsIndex (keyword, index)
 then (listOfWebIds index)
 else findMatchingIndex (keyword, indexes)

keywordEqualsIndex :: (String, InverseIndex) -> Bool
keywordEqualsIndex ([], fx) = False
keywordEqualsIndex (keyword, inverseIndex) = keyword == word inverseIndex

keywordIsPrefix :: (String, InverseIndex) -> Bool
keywordIsPrefix ([], fx) = False
keywordIsPrefix (keyword, inverseIndex) = (pack keyword) `Data.Text.isPrefixOf` pack(word inverseIndex)

getWords :: (String) -> [String]
getWords [] = []
getWords (str) = (nub $ Data.List.words $ removePunctuation str)
 
removePunctuation :: String -> String
removePunctuation [] = []
removePunctuation (s:sx)
    | (isAlpha s) || (isSpace s) = Data.Char.toLower s : removePunctuation sx
    | otherwise                  = removePunctuation sx