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

writeMyFile :: String -> [String] -> IO ()
writeMyFile url htmlWords = do
    let parsedHtml = ParsedHtml { url = url, listOfWords = htmlWords }
    Prelude.putStrLn ("Write to file: " ++ url)
    I.writeFile "myfile.json" (encodeToLazyText parsedHtml)

writeParsedHtmlToFile

data ParsedHtml = ParsedHtml { url :: String, listOfWords :: [String] } deriving (Show, Generic)
instance ToJSON ParsedHtml