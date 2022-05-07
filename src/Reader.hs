{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

module Reader
  ( 
    readMyFile,
    loadCollection,
  )
where

import Control.Applicative
import Data.Aeson
import Data.ByteString.Internal (c2w)
import qualified Data.ByteString.Lazy as B
import Data.Char
import Data.Maybe (isJust, catMaybes)
import GHC.Generics ()
import System.IO
import Data.Foldable
import Parser
import Writer 

loadCollection :: FilePath -> IO B.ByteString
loadCollection = B.readFile

readMyFile :: FilePath -> IO [WebPage]
readMyFile file = do
  res <- loadCollection file
  let byLine = B.split (c2w '\n') res
  let decoded = map (\line -> decode line :: Maybe WebPage) byLine
  let r = catMaybes decoded
  let a = zip [1..] r
  forM_ a $ \s -> do
    let url = getUrl (snd(s))
    let id = fst(s)
    let html = getHtml (snd(s))
    writeIndices id url
    parse id html
  return r

getUrl :: WebPage -> String
getUrl (WebPage url _) = url

getHtml :: WebPage -> String
getHtml (WebPage _ html) = html

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