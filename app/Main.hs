module Main where

import Indexer
import Inverser
import UserIO
import GHC.IO.Encoding

main :: IO ()
main = do
 setLocaleEncoding utf8
 putStrLn "Hi, do You want to create new indices?(y/n)"
 createIndexes <- getLine
 if createIndexes == "y"
  then do
   createIndices "archive/collection.jl"
   inverse
   search
  else search