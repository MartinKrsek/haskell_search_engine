module Main where

import Data.Aeson
import qualified Data.ByteString.Lazy as B
import Lib
import Reader
import Inverser
import UserIO

main :: IO ()
main = do 
    -- readMyFile "archive/testBig.txt"
    -- inverse
    search
    putStr "Finished successfully!"
