module Lib
  ( someFunc
  )
where

-- import Parser
import Reader
import System.IO

someFunc :: IO ()
someFunc = do
  putStr "test123"
  --parse