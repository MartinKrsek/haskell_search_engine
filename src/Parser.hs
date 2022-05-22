{-# LANGUAGE DeriveGeneric, DeriveAnyClass #-}
module Parser
  ( parseHtml, ParsedHtml )
where
import Data.List
import Data.Char
import Text.HTML.TagSoup
import Text.Regex.Posix
import Data.Typeable
import GHC.Generics
import Data.Aeson (ToJSON)

stringToIoString :: String -> IO String
stringToIoString string = return string

{-
Method which takes id and html and parses given 
HTML to [String] of words and write these into file.
-}
parseHtml :: (Int, String) -> [ParsedHtml]
parseHtml (id, html) = do
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
  [ParsedHtml { webId = id, listOfWords = nub $ title ++ metaContent ++ h1 ++ h2 ++ h3 ++ h4 ++ h5 ++ h6 ++ imgAlt ++ span ++ div }]
  where getContent = dequote . unwords . words . map toLower . removeNonLetters . filter isAscii . fromAttrib "content" . head . filter isTagOpen
        getAlt = dequote . unwords . words . map toLower . removeNonLetters . filter isAscii . fromAttrib "alt" . head . filter isTagOpen
        removeEmpty = filter (not . null)
        removeShort = filter ((> 2) . length) 
        removeLong = filter ((< 20) . length) 
        removeNonLetters = filter (`notElem` "{},.?!+*%$#@^&_+=`~-:;\"\'|")
        myMetaContent src = removeLong $ removeShort $ concat $ map words $ removeEmpty $ map getContent $ sections (~== "<meta name=\"description\">") src
        myImgMap src = removeLong $ removeShort $ concat $ map words $ removeEmpty $ map getAlt $ sections (~== "<img>") src
        clearBefore =  filter isTagText
        clearAfter = dequote . unwords . words . map toLower . removeNonLetters . filter isAscii . fromTagText . head
        myMap src tag = removeLong $ removeShort $ concat $ map words $ removeEmpty $ map clearAfter $ removeEmpty $ map clearBefore $ sections (~== tag) src
        dequote ('\"':xs) | last xs == '\"' = init xs
        dequote x = x

data ParsedHtml = ParsedHtml { webId :: Int, listOfWords :: [String] } deriving (Show, Generic)
instance ToJSON ParsedHtml