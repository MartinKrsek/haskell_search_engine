module Main where

import Data.Aeson
import qualified Data.ByteString.Lazy as B
import Lib
import Reader

main :: IO ()
main = do 
    readMyFile "archive/test.txt"
    putStr "Finished successfully!"
