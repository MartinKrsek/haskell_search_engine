module Lib
  ( someFunc,
  )
where

import System.IO

someFunc :: IO ()
someFunc = do
  handle <- openFile "archive/test.txt" ReadMode
  contents <- hGetLine handle
  putStr contents
  hClose handle