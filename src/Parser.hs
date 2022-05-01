
module Parser
  ( parse )
where
import Writer 
import Data.Char
import Text.HTML.TagSoup

stringToIoString :: String -> IO String
stringToIoString string = return string

{-
Method which takes url and html and parses given 
HTML to [String] of words.
-}
htmlToWordList :: String -> String -> IO ()
htmlToWordList url html = do
  putStrLn url
  src <- stringToIoString html
  let foundWords = fromBody $ parseTags src
  mapM_ print foundWords
  writeMyFile url foundWords
  where fromBody = words . innerText

parse :: String -> String -> IO ()
parse url html = htmlToWordList url html