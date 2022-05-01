module Parser
  ( parse )
where
import Data.Char
import Text.HTML.TagSoup

stringToIoString :: String -> IO String
stringToIoString string = return string

{-
Method which takes url and html and writes them to new file.
-}
htmlToWordList :: String -> String -> IO ()
htmlToWordList url html = do
  putStrLn url
  src <- stringToIoString html
  let lastModifiedDateTime = fromFooter $ parseTags src
  mapM_ print lastModifiedDateTime
  where fromFooter = words . innerText

parse :: String -> String -> IO ()
parse url html = htmlToWordList url html