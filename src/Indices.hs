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

readIndices :: String -> [Int] -> IO ()
readIndices fileName ids = do
    res <- loadCollection fileName
    let byLine = B.split (c2w '\n') res
    let indices = catMaybes $ map (\line -> decode line :: Maybe Index) byLine
    let webUrls = forLoop(indices, ids)
    putStrLn "We found Your search on these websites: "
    forM_ webUrls $ \webUrl -> do
        print webUrl

forLoop :: ([Index], [Int]) -> [Index]
forLoop ([], _) = []
forLoop ([_], []) = []
forLoop (index:indices, ids) = 
    if elem (getId(index)) ids
    then [index] ++ forLoop(indices, ids)
    else forLoop(indices, ids)

getId :: Index -> Int
getId (Index myId _) = myId

getUrl :: Index -> String
getUrl (Index _ url) = url

data Index = Index { myId :: Int, url :: String } deriving (Show,Generic)

instance FromJSON Index where
  parseJSON (Object v) =
    Index
      <$> (v .: "myId")
      <*> (v .: "url")