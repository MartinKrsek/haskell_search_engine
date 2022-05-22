{-# LANGUAGE OverloadedStrings, DeriveGeneric, DeriveAnyClass #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

module Indexer (createIndices)
where
import Parser

import Data.Aeson
import Data.Aeson.Text (encodeToLazyText)
import GHC.Generics (Generic)
import Data.ByteString.Internal (c2w)
import qualified Data.ByteString.Lazy as B
import Data.Maybe (catMaybes)
import Data.Text.Lazy.IO as I

loadCollection :: FilePath -> IO B.ByteString
loadCollection = B.readFile

--function to create indices and parsedHtml json files 
createIndices :: FilePath -> IO ()
createIndices file = do
  res <- loadCollection file
  let byLine = B.split (c2w '\n') res
  let decoded = map (\line -> decode line :: Maybe WebPage) byLine
  let justDecoded = catMaybes decoded
  let indices = (getAllUrls (justDecoded,[1..]))
  I.writeFile "archive/indices.json" (encodeToLazyText indices)
  let parsedHtmls = getAllHtmls(justDecoded,[1..])
  I.writeFile "archive/parsedHtml.json" (encodeToLazyText parsedHtmls)

getUrl :: WebPage -> String
getUrl (WebPage url _) = url

--recursive function to recieve list index objects
getAllUrls :: ([WebPage], [Int]) -> [Index]
getAllUrls ([],_) = []
getAllUrls (webPage:webPages, index:indices) = [Index { indexId = index, indexUrl = getUrl webPage }] ++ getAllUrls(webPages,indices)

getHtml :: (WebPage) -> String
getHtml (WebPage _ html) = html

--recursive function to recieve list of parsed html objects
getAllHtmls :: ([WebPage], [Int]) -> [Parser.ParsedHtml]
getAllHtmls ([], _) = []
getAllHtmls (webPage:webPages, index:indices) = [parseHtmlAndCreateObject(index, getHtml webPage)] ++ getAllHtmls(webPages, indices)

data WebPage = WebPage { url :: String, html_content :: String } deriving (Show, Generic)
instance FromJSON WebPage

data Index = Index { indexId :: Int, indexUrl :: String } deriving (Show, Generic)
instance ToJSON Index