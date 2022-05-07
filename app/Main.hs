module Main where

import Data.Aeson
import qualified Data.ByteString.Lazy as B
import Lib
import Text.Regex.TDFA
import Reader

main :: IO ()
main = do 
    readMyFile "archive/test.txt"
    putStr "Finished successfully!"
