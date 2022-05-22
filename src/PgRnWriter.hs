{-# LANGUAGE DeriveGeneric, DeriveAnyClass, OverloadedStrings #-}

module PgRnWriter 
(
    writeParsedPages,
    writeGraph,
    writeCurrentAnchors,
    writeGraphAnc
) 
where

import Prelude
import GHC.Generics
import Data.Aeson (ToJSON)
import Data.Text.Lazy (Text)
import qualified Data.Text.Lazy.IO as I
import Data.Aeson.Text (encodeToLazyText)
import Main.Utf8
import Data.Foldable
import Prelude (writeFile)

writeParsedPages :: String -> [String] -> IO ()
writeParsedPages url htmlWords = withUtf8 $ do
    let parsedHtml = ParsedHtml { url = url, anchors = htmlWords}
    I.appendFile "data/parsed_htmls.txt" $ encodeToLazyText parsedHtml
    I.appendFile "data/parsed_htmls.txt" "\n"
    appendFile "data/urls.txt" url
    appendFile "data/urls.txt" "\n"

writeGraph ::String-> Int -> Int -> [String]->IO()
writeGraph url inbound outbound current_anchors= withUtf8 $ do
    let parsegGraph = ParsedGraph { page= url,inn = inbound, out = outbound}
    appendFile "data/graph.txt" (show inbound ++" "++ show outbound)
    appendFile "data/graph.txt" "\n"
    I.writeFile "data/current_anchors.txt" $ encodeToLazyText current_anchors

writeGraphAnc ::String-> Int -> Int ->IO()
writeGraphAnc url inbound outbound = withUtf8 $ do
    let parsegGraph = ParsedGraph { page= url,inn = inbound, out = outbound}
    appendFile "data/graph.txt" (show inbound ++" "++ show outbound)
    appendFile "data/graph.txt" "\n"

writeCurrentAnchors::[String]->IO()
writeCurrentAnchors current_anchors = withUtf8 $ do
    I.appendFile "data/current_anchors.txt" $ encodeToLazyText current_anchors

data ParsedGraph = ParsedGraph { page ::String, inn :: Int, out :: Int } deriving (Show, Generic)
data ParsedHtml = ParsedHtml { url :: String, anchors :: [String] } deriving (Show, Generic)
instance ToJSON ParsedHtml
instance ToJSON ParsedGraph