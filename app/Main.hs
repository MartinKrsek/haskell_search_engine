module Main where

import Lib
import Reader
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
   readMyFile "archive/collection.jl"
   inverse
   search
  else do
   search