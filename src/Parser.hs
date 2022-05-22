{-# LANGUAGE DeriveGeneric, DeriveAnyClass #-}
module Parser
  ( parseHtmlAndCreateObject, ParsedHtml )
where
import Data.List (nub)
import Data.Char (toLower, isAscii)
import Text.HTML.TagSoup
import GHC.Generics (Generic)
import Data.Aeson (ToJSON)

stringToIoString :: String -> IO String
stringToIoString string = return string

{-
function which takes id and html content, parses html content and returns created object with
provided id and parsed html words
-}
parseHtmlAndCreateObject :: (Int, String) -> ParsedHtml
parseHtmlAndCreateObject (id, html) = do
  let src = parseTags html
  let title = myMap src "<title>"
  let metaContent = myMetaContent src
  let h1 = myMap src "<h1>"
  let h2 = myMap src "<h2>"
  let h3 = myMap src "<h3>"
  let h4 = myMap src "<h4>"
  let h5 = myMap src "<h5>"
  let h6 = myMap src "<h6>"
  let imgAlt = myImgMap src 
  let span = myMap src "<span>"
  let div = myMap src "<div>"
  ParsedHtml { webId = id, listOfWords = nub $ title ++ metaContent ++ h1 ++ h2 ++ h3 ++ h4 ++ h5 ++ h6 ++ imgAlt ++ span ++ div }
  where getContent = dequote . unwords . words . map toLower . removeNonLetters . filter isAscii . fromAttrib "content" . head . filter isTagOpen
        getAlt = dequote . unwords . words . map toLower . removeNonLetters . filter isAscii . fromAttrib "alt" . head . filter isTagOpen
        ----sanitizer methods----
        --remove empty arrays(this fixes problem where head function reads empty array)
        removeEmpty = filter (not . null)
        removeShort = filter ((> 2) . length)
        --remove words longer than 20 words(this removes also lot of JS code)
        removeLong = filter ((< 20) . length) 
        removeNonLetters = filter (`notElem` "{},.?!+*%$#@^&_+=`~-:;\"\'|")
        myMetaContent src = removeLong $ removeShort $ concat $ map words $ removeEmpty $ map getContent $ sections (~== "<meta name=\"description\">") src
        myImgMap src = removeLong $ removeShort $ concat $ map words $ removeEmpty $ map getAlt $ sections (~== "<img>") src
        clearBefore =  filter isTagText
        --clear had to be split, to resolve problem where head reads empty array
        clearAfter = dequote . unwords . words . map toLower . removeNonLetters . filter isAscii . fromTagText . head
        --function which gets provided tags from src and sanitizes output
        myMap src tag = removeLong $ removeShort $ concat $ map words $ removeEmpty $ map clearAfter $ removeEmpty $ map clearBefore $ sections (~== tag) src
        dequote ('\"':xs) | last xs == '\"' = init xs
        dequote x = x
        ----end of sanitizer methods----

data ParsedHtml = ParsedHtml { webId :: Int, listOfWords :: [String] } deriving (Show, Generic)
instance ToJSON ParsedHtml