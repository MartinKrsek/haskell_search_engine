{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

module Parser
  ( writeToFile,
    parseFile,
    loadCollection,
  )
where

import Control.Applicative
import Data.Aeson
import Data.ByteString.Internal (c2w)
import qualified Data.ByteString.Lazy as B
import Data.Char
import Data.Maybe (isJust)
import GHC.Generics ()
import System.IO
import Text.Regex.TDFA (AllMatches (getAllMatches), (=~))

writeToFile :: IO ()
writeToFile = do
  writeFile "girlfriendcaps.txt" "test123"

loadCollection :: FilePath -> IO B.ByteString
loadCollection = B.readFile

parseFile :: FilePath -> IO [Maybe WebPage]
parseFile file = do
  res <- loadCollection file
  let byLine = B.split (c2w '\n') res
  let decoded = map (\line -> decode line :: Maybe WebPage) byLine
  -- let r = filter isJust decoded
  let asd = maybe "" getHtml (head decoded)
  putStr asd
  return decoded

getUrl :: WebPage -> String
getUrl (WebPage url _) = url

getHtml :: WebPage -> String
getHtml (WebPage _ html) = html

parseHtml :: String -> IO ()
parseHtml string = do
  -- getAllMatches (string =~ "(?<=This is).*?(?=sentence)")
  putStr "test"

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