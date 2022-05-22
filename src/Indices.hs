{-# LANGUAGE DeriveGeneric, DeriveAnyClass, OverloadedStrings #-}

module Indices (printWebsitesByIds)
where
    
import Data.Aeson (FromJSON, eitherDecode)
import GHC.Generics (Generic)
import Data.Foldable (forM_)
import qualified Data.ByteString.Lazy as B

getJSON :: FilePath -> IO B.ByteString
getJSON fileName = B.readFile fileName

{-
function which takes filePath and list of integers and returns objects of Index from file which 
do match provided list of ids
-}
printWebsitesByIds :: FilePath -> [Int] -> IO ()
printWebsitesByIds fileName ids = do
 d <- (eitherDecode <$> getJSON fileName) :: IO (Either String [Index])
 case d of
  Left err -> putStrLn err
  Right indices -> do
    let webs = filterByIdIn(indices, ids)
    putStrLn "We found Your search on these websites:"
    forM_ webs $ \web -> do
      print web

{-
recursive function to fiter all objects matching provided list of ids
-}
filterByIdIn :: ([Index], [Int]) -> [Index]
filterByIdIn ([], _) = []
filterByIdIn ([_], []) = []
filterByIdIn (index:indices, ids) = 
    if elem (getId(index)) ids
    then [index] ++ filterByIdIn(indices, ids)
    else filterByIdIn(indices, ids)

getId :: Index -> Int
getId (Index indexId _) = indexId

data Index = Index { indexId :: Int, indexUrl :: String } deriving (Show,Generic)
instance FromJSON Index