module Main where

import Data.Aeson
import qualified Data.ByteString.Lazy as B
import Lib
import Text.Regex.TDFA
import Reader
import Inverser

main :: IO ()
main = do 
    -- readMyFile "archive/testBig.txt"
    inverse
    putStr "Finished successfully!"
