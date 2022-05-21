{-# LANGUAGE DeriveGeneric, DeriveAnyClass, OverloadedStrings #-}

module Indices (readIndices)
where
    
import Data.Aeson
import GHC.Generics
import Data.ByteString.Internal (c2w)
import qualified Data.ByteString.Lazy as B
import Data.Maybe (catMaybes)
import Data.Foldable

loadCollection :: FilePath -> IO B.ByteString
loadCollection = B.readFile

readIndices :: String -> [Integer] -> IO ()
readIndices fileName ids = do
    res <- loadCollection fileName
    let byLine = B.split (c2w '\n') res
    let indices = catMaybes $ map (\line -> decode line :: Maybe Index) byLine
    let webUrls = []
    print (forLoop(indices, ids))
    print indices

forLoop :: ([Index], [Integer]) -> [String]
forLoop ([], _) = []
forLoop ([_], []) = []
forLoop (index:indices, ids) = 
    if elem (getId(index)) ids
    then [getUrl(index)] ++ forLoop(indices, ids)
    else forLoop(indices, ids)

getId :: Index -> Integer
getId (Index myId _) = myId

getUrl :: Index -> String
getUrl (Index _ url) = url

data Index = Index { myId :: Integer, url :: String } deriving (Show,Generic)

instance FromJSON Index where
  parseJSON (Object v) =
    Index
      <$> (v .: "myId")
      <*> (v .: "url")