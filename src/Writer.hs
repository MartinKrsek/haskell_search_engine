{-# LANGUAGE DeriveGeneric, DeriveAnyClass, OverloadedStrings #-}
module Writer
  ( writeMyFile )
where
import GHC.Generics
import Data.Text
import Data.Aeson (ToJSON)
import Data.Text.Lazy (Text)
import Data.Text.Lazy.IO as I
import Data.Aeson.Text (encodeToLazyText)
import Main.Utf8

writeMyFile :: String -> [String] -> IO ()
writeMyFile url htmlWords = withUtf8 $ do
    let parsedHtml = ParsedHtml { url = url, listOfWords = htmlWords }
    I.appendFile "archive/output.json" $ encodeToLazyText parsedHtml
    I.appendFile "archive/output.json" $ "\n"

data ParsedHtml = ParsedHtml { url :: String, listOfWords :: [String] } deriving (Show, Generic)
instance ToJSON ParsedHtml