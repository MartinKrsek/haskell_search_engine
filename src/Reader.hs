{-# LANGUAGE OverloadedStrings, DeriveGeneric, DeriveAnyClass #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

module Reader (readMyFile)
where

import Control.Applicative
import Data.Aeson
import Data.Aeson.Text (encodeToLazyText)
import GHC.Generics
import Data.ByteString.Internal (c2w)
import qualified Data.ByteString.Lazy as B
import Data.Char
import Data.Maybe (isJust, catMaybes)
import GHC.Generics ()
import System.IO
import Data.Foldable
import Parser
import Data.Text.Lazy.IO as I
import Text.HTML.TagSoup
import Data.List
import Data.Char

loadCollection :: FilePath -> IO B.ByteString
loadCollection = B.readFile

readMyFile :: FilePath -> IO ()
readMyFile file = do
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

getAllUrls :: ([WebPage], [Int]) -> [Index]
getAllUrls ([],_) = []
getAllUrls (webPage:webPages, index:indices) = [Index { indexId = index, indexUrl = getUrl webPage }] ++ getAllUrls(webPages,indices)

getHtml :: (WebPage) -> String
getHtml (WebPage _ html) = html

getAllHtmls :: ([WebPage], [Int]) -> [Parser.ParsedHtml]
getAllHtmls ([], _) = []
getAllHtmls (webPage:webPages, index:indices) = parseHtml(index, getHtml webPage) ++ getAllHtmls(webPages, indices)

data WebPage = WebPage { url :: String, htmlContent :: String } deriving (Show)

data Index = Index { indexId :: Int, indexUrl :: String } deriving (Show, Generic)
instance ToJSON Index

instance FromJSON Index where
  parseJSON (Object v) =
    Index
      <$> (v .: "myId")
      <*> (v .: "url")

instance FromJSON WebPage where
  parseJSON (Object v) =
    WebPage
      <$> (v .: "url")
      <*> (v .: "html_content")