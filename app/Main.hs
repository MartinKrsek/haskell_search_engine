module Main where

import Lib
import Reader
import Inverser
import UserIO
import GHC.IO.Encoding

main :: IO ()
main = do
    setLocaleEncoding utf8
    readMyFile "archive/collectionFirst100.jl"
    inverse
    search
    putStr "Finished successfully!"