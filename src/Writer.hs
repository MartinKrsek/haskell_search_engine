{-# LANGUAGE DeriveGeneric, DeriveAnyClass, OverloadedStrings #-}
module Writer
  ( writeParsedFile, writeIndices )
where
import GHC.Generics
import Data.Text
import Data.Aeson (ToJSON)
import Data.Text.Lazy (Text)
import Data.Text.Lazy.IO as I
import Data.Aeson.Text (encodeToLazyText)
import Main.Utf8

writeParsedFile :: Integer -> [String] -> IO ()
writeParsedFile id htmlWords = withUtf8 $ do
    let parsedHtml = ParsedHtml { webId = id, listOfWords = htmlWords }
    I.appendFile "archive/parsedHtml.json" $ encodeToLazyText parsedHtml
    I.appendFile "archive/parsedHtml.json" $ "\n"
    
data ParsedHtml = ParsedHtml { webId :: Integer, listOfWords :: [String] } deriving (Show, Generic)
instance ToJSON ParsedHtml

writeIndices :: Integer -> String -> IO ()
writeIndices id url = withUtf8 $ do
    let index = Index { myId = id, url = url }
    I.appendFile "archive/indices.json" $ encodeToLazyText index
    I.appendFile "archive/indices.json" $ "\n"
    
data Index = Index { myId :: Integer, url :: String } deriving (Show, Generic)
instance ToJSON Index