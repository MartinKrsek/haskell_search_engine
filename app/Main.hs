module Main where

import Lib
import Reader
import Inverser
import Indices
import UserIO

main :: IO ()
main = do 
    -- readMyFile "archive/testBig.txt"
    -- inverse
    readIndices "archive/indices.json" [1,3]
    -- search
    putStr "Finished successfully!"
