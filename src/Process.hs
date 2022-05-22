{-# LANGUAGE DeriveGeneric #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Process
(
    JSON(..),
    process,
    getAnchors,
    getSite,
    processAnc
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
import PgRnParser (parse,parseToGraph,parseToGraphAnc)
import PgRnWriter (writeGraph,writeCurrentAnchors)
import Control.Monad (when)
import Data.Text.Lazy.IO as I
import Data.Text.Lazy (Text)
import Main.Utf8
import Pagerank
lc :: FilePath -> IO B.ByteString
lc = B.readFile

count   :: Eq a => a -> [a] -> Int
count x =  length . filter (==x)

process :: FilePath -> [String] -> String -> IO ()
process file ancrs currenturl= do
  res <- lc file
  let byLine = B.split (c2w '\n') res
  let decoded = map (\line -> decode line :: Maybe JSON) byLine
  let r = catMaybes decoded
  forM_ r $ \s -> do
    let url = getSite s
    let anchors = getAnchors s
    let links = length anchors
    let references = count ("\""++url++"\"") ancrs
    when (url == currenturl) $ parseToGraph url links references anchors

processAnc :: FilePath -> [String] -> String -> IO ()
processAnc file ancrs currenturl= do
  res <- lc file
  let byLine = B.split (c2w '\n') res
  let decoded = map (\line -> decode line :: Maybe JSON) byLine
  let r = catMaybes decoded
  forM_ r $ \s -> do
    let url = getSite s
    let anchors = getAnchors s
    let links = length anchors
    let references = count ("\""++url++"\"") ancrs
    when (url == currenturl) $ parseToGraphAnc url links references

getAnchors :: JSON -> [String]
getAnchors (JSON _ anchors) = anchors

getSite :: JSON -> String
getSite (JSON url _) = url

data JSON=JSON
    {
        url::String,
        anchors::[String]
    }deriving(Show,Generic)

instance FromJSON JSON
