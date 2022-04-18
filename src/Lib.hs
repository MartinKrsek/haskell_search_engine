module Lib
  ( someFunc,
  )
where

import Parser
import System.IO

someFunc :: IO ()
someFunc = do
  handle <- openFile "archive/test.txt" ReadMode
  contents <- hGetLine handle
  putStr contents
  parseFile "archive/test.txt"
  hClose handle