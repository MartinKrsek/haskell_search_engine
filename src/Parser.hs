
module Parser
  ( parse )
where
import Writer 
import Data.List
import Data.Char
import Text.HTML.TagSoup
import Text.Regex.Posix
import Data.Typeable

stringToIoString :: String -> IO String
stringToIoString string = return string

{-
Method which takes id and html and parses given 
HTML to [String] of words and write these into file.
-}
parse :: Integer -> String -> IO ()
parse id html = do
  src <- parseTags <$> stringToIoString html
  let title = myMap src "<title>"
  let metaContent = concat $ map words $ map getContent $ sections (~== "<meta name=\"description\">") src
  let h1 = myMap src "<h1>"
  let h2 = myMap src "<h2>"
  let h3 = myMap src "<h3>"
  let h4 = myMap src "<h4>"
  let h5 = myMap src "<h5>"
  let h6 = myMap src "<h6>"
  let imgAlt = myImgMap src
  let span = myMap src "<span>"
  let div = myMap src "<div>"
  writeParsedFile id (nub $ title ++ metaContent ++ h1 ++ h2 ++ h3 ++ h4 ++ h5 ++ h6 ++ imgAlt ++ span ++ div)
  where getContent = fromAttrib "content" . head . filter isTagOpen
        getAlt = fromAttrib "alt" . head . filter isTagOpen
        removeEmpty = filter (not . null)
        myImgMap src = concat $ map words $ removeEmpty $ map getAlt $ sections (~== "<img>") src
        clear = dequote . unwords . words . map toLower . filter (`notElem` "{},.?!-:;\"\'|"). filter isAscii . fromTagText . head . filter isTagText
        myMap src tag = concat $ map words $ removeEmpty $ map clear $ sections (~== tag) src
        dequote ('\"':xs) | last xs == '\"' = init xs
        dequote x = x

