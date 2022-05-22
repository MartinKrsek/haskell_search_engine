module PgRnParser
(
    parse,
    parseToGraph,
    parseToGraphAnc
)
where



-- my modules
import PgRnWriter
import Text.HTML.TagSoup
import Data.Char

import Data.Maybe (catMaybes)
import Text.HTML.TagSoup.Match (getTagContent)
import Data.Foldable
import Control.Monad (liftM,when,unless)
import Data.Aeson (Value(Bool))
import Text.Regex.TDFA
import Control.Applicative (liftA2)
import Data.Text.Lazy.IO as I
import Data.Aeson.Text (encodeToLazyText)
import Main.Utf8
stringToIoString :: String -> IO String
stringToIoString  = return

anchorsFromHtml::String->String->IO()
anchorsFromHtml url html = do
  src <-stringToIoString html
  let links = map f $ sections (~== "<a>") $parseTags src
  let result = filter isStringUrl links
  unless (null result) $ writeParsedPages url result
  --writeAllAnchors result
  withUtf8 $ do
    I.appendFile "data/anchors.txt" $ encodeToLazyText result
   -- I.appendFile "data/urls.txt" $ encodeToLazyText url
  where
      f :: [Tag String] -> String
      f =  unwords . words . fromAttrib "href" . head . filter isTagOpen

isStringUrl:: String -> Bool
isStringUrl str  =  str=~"https?:\\/\\/(www\\.)?[-a-zA-Z0-9@:%._\\+~#=]{1,256}\\.[a-zA-Z0-9()]{1,6}\\b([-a-zA-Z0-9()@:%_\\+.~#?&//=]*)"::Bool

parse :: String -> String -> IO ()
parse url links = anchorsFromHtml url links

parseToGraph :: String->Int -> Int -> [String]-> IO()
parseToGraph url inbound outbound current_anchors= writeGraph url inbound outbound current_anchors

parseToGraphAnc :: String->Int -> Int -> IO()
parseToGraphAnc url inbound outbound= writeGraphAnc url inbound outbound