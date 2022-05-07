
module Parser
  ( parse )
where
import Writer 
import Data.Char
import Text.HTML.TagSoup

stringToIoString :: String -> IO String
stringToIoString string = return string

{-
Method which takes id and html and parses given 
HTML to [String] of words.
-}
parse :: Integer -> String -> IO ()
parse id html = do
  src <- stringToIoString html
  let foundWords = fromBody $ parseTags src
  -- mapM_ print foundWords
  writeParsedFile id foundWords
  where fromBody = words . innerText . dropWhile (~/= "<body>") .takeWhile (~/= "</body>")