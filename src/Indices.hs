{-# LANGUAGE DeriveGeneric, DeriveAnyClass, OverloadedStrings #-}

module Indices (readIndices)
where
    
import Data.Aeson
import GHC.Generics
import Data.ByteString.Internal (c2w)
import qualified Data.ByteString.Lazy as B
import Data.Maybe (catMaybes)
import Data.Foldable

getJSON :: FilePath -> IO B.ByteString
getJSON fileName = B.readFile fileName

readIndices :: FilePath -> [Int] -> IO ()
readIndices fileName ids = do
 d <- (eitherDecode <$> getJSON fileName) :: IO (Either String [Index])
 case d of
  Left err -> putStrLn err
  Right indices -> do
    let webUrls = forLoop(indices, ids)
    putStrLn "We found Your search on these websites:"
    print webUrls


forLoop :: ([Index], [Int]) -> [Index]
forLoop ([], _) = []
forLoop ([_], []) = []
forLoop (index:indices, ids) = 
    if elem (getId(index)) ids
    then [index] ++ forLoop(indices, ids)
    else forLoop(indices, ids)

getId :: Index -> Int
getId (Index myId _) = myId

data Index = Index { myId :: Int, url :: String } deriving (Show,Generic)
instance FromJSON Index