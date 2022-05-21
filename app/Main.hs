module Main where

import Lib
import Reader
import Inverser
import Indices

main :: IO ()
main = do 
    -- readMyFile "archive/testBig.txt"
    -- inverse
    readIndices "archive/indices.json" [1,3]
    putStr "Finished successfully!"
