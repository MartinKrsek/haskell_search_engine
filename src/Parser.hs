
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
  let title = concat $ map words $ map removePunctuation $ map g $ sections (~== "<title>") src
  let metaContent = concat $ map words $ map getContent $ sections (~== "<meta name=\"description\">") src
  let h1 = concat $ map words $ map removePunctuation $ map g $ sections (~== "<h1>") src
  let h2 = concat $ map words $ map removePunctuation $ map g $ sections (~== "<h2>") src
  let h3 = concat $ map words $ map removePunctuation $ map g $ sections (~== "<h3>") src
  let h4 = concat $ map words $ map removePunctuation $ map g $ sections (~== "<h4>") src
  let h5 = concat $ map words $ map removePunctuation $ map g $ sections (~== "<h5>") src
  let h6 = concat $ map words $ map removePunctuation $ map g $ sections (~== "<h6>") src
  let imgAlt = concat $ map words $ map removePunctuation $ map getAlt $ sections (~== "<img>") src
  let span = concat $ map words $ map removePunctuation $ map g $ sections (~== "<span>") src
  let div = concat $ map words $ map removePunctuation $ map g $ sections (~== "<div>") src
  writeParsedFile id (nub $ title ++ metaContent ++ h1 ++ h2 ++ h3 ++ h4 ++ h5 ++ h6 ++ imgAlt ++ span ++ div)
  where getContent = fromAttrib "content" . head . filter isTagOpen
        getAlt = fromAttrib "alt" . head . filter isTagOpen
        g = dequote . unwords . words . fromTagText . head . filter isTagText

        dequote ('\"':xs) | last xs == '\"' = init xs
        dequote x = x
 
removePunctuation :: String -> String
removePunctuation [] = []
removePunctuation (s:sx)
    | (isAlpha s) || (isSpace s) = Data.Char.toLower s : removePunctuation sx
    | otherwise                  = removePunctuation sx

getHrefLink :: TagRep t => t -> [Tag String] -> [String]
getHrefLink selector tags =
  map f $ sections (~== selector)  tags
  where
    f = fromAttrib "content" . head . filter isTagOpen

