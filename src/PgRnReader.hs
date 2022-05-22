{-# LANGUAGE DeriveGeneric, DeriveAnyClass, OverloadedStrings #-}

module PgRnReader
  ( 
    readWebPages,
    loadCollection,
  )
where

import Control.Applicative
import Data.Aeson
import Data.ByteString.Internal (c2w)
import qualified Data.ByteString.Lazy as B
import Data.Char
import Data.Maybe (isJust, catMaybes)
import GHC.Generics (Generic)
import System.IO
import Data.Foldable
import Data.List.Split
import PgRnParser (parse,parseToGraph)
import PgRnWriter (writeGraph)


loadCollection :: FilePath -> IO B.ByteString
loadCollection = B.readFile

readWebPages :: FilePath -> IO [WebPage]
readWebPages file = do
  res <- loadCollection file
  let byLine = B.split (c2w '\n') res
  let decoded = map (\line -> decode line :: Maybe WebPage) byLine
  let r = catMaybes decoded
  forM_ r $ \s -> do
    let url = getUrl s
    let html = getHtml s
    parse url html
  return r


getUrl :: WebPage -> String
getUrl (WebPage url _) = url



getHtml :: WebPage -> String
getHtml (WebPage _ html) = html

getAnchors :: JSON -> [String]
getAnchors (JSON _ anchors) = anchors

getSite :: JSON -> String
getSite (JSON site _) = site

data WebPage = WebPage
  { url :: String,
    htmlContent :: String
  }
  deriving (Show)

instance FromJSON WebPage where
  
  parseJSON (Object v) =
    WebPage
      <$> (v .: "url")
      <*> (v .: "html_content")

data JSON=JSON
    {
        site::String,
        anchors::[String]
    }deriving(Show,Generic)

instance FromJSON JSON

count   :: Eq a => a -> [a] -> Int
count x =  length . filter (==x)

--tato funkcia spracuje kazdu vsupnu url
