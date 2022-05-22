{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_happy (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [1,20,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "D:\\cabal\\store\\ghc-8.10.7\\happy-1.20.0-4aa8e680efc8255c936b9aca92c4ab487a4ca8e8\\bin"
libdir     = "D:\\cabal\\store\\ghc-8.10.7\\happy-1.20.0-4aa8e680efc8255c936b9aca92c4ab487a4ca8e8\\lib"
dynlibdir  = "D:\\cabal\\store\\ghc-8.10.7\\happy-1.20.0-4aa8e680efc8255c936b9aca92c4ab487a4ca8e8\\lib"
datadir    = "D:\\cabal\\store\\ghc-8.10.7\\happy-1.20.0-4aa8e680efc8255c936b9aca92c4ab487a4ca8e8\\share"
libexecdir = "D:\\cabal\\store\\ghc-8.10.7\\happy-1.20.0-4aa8e680efc8255c936b9aca92c4ab487a4ca8e8\\libexec"
sysconfdir = "D:\\cabal\\store\\ghc-8.10.7\\happy-1.20.0-4aa8e680efc8255c936b9aca92c4ab487a4ca8e8\\etc"

getBinDir     = catchIO (getEnv "happy_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "happy_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "happy_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "happy_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "happy_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "happy_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '\\'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/' || c == '\\'
