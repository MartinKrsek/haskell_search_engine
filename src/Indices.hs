{-# LANGUAGE DeriveGeneric, DeriveAnyClass, OverloadedStrings #-}

module Indices (readIndices)
where
    
import Data.Aeson
import GHC.Generics
import qualified Data.ByteString.Lazy as B
import Data.Foldable

getJSON :: FilePath -> IO B.ByteString
getJSON fileName = B.readFile fileName

readIndices :: FilePath -> [Int] -> IO ()
readIndices fileName ids = do
 d <- (eitherDecode <$> getJSON fileName) :: IO (Either String [Index])
 case d of
  Left err -> putStrLn err
  Right indices -> do
    let webs = forLoop(indices, ids)
    putStrLn "We found Your search on these websites:"
    forM_ webs $ \web -> do
      print web

forLoop :: ([Index], [Int]) -> [Index]
forLoop ([], _) = []
forLoop ([_], []) = []
forLoop (index:indices, ids) = 
    if elem (getId(index)) ids
    then [index] ++ forLoop(indices, ids)
    else forLoop(indices, ids)

getId :: Index -> Int
getId (Index indexId _) = indexId

data Index = Index { indexId :: Int, indexUrl :: String } deriving (Show,Generic)
instance FromJSON Index