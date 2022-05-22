{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_vector_algorithms (
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
version = Version [0,8,0,4] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "D:\\cabal\\store\\ghc-8.10.7\\vector-algori_-0.8.0.4-b29c744777ba6eb5e9dce92857497800a1e8a903\\bin"
libdir     = "D:\\cabal\\store\\ghc-8.10.7\\vector-algori_-0.8.0.4-b29c744777ba6eb5e9dce92857497800a1e8a903\\lib"
dynlibdir  = "D:\\cabal\\store\\ghc-8.10.7\\vector-algori_-0.8.0.4-b29c744777ba6eb5e9dce92857497800a1e8a903\\lib"
datadir    = "D:\\cabal\\store\\ghc-8.10.7\\vector-algori_-0.8.0.4-b29c744777ba6eb5e9dce92857497800a1e8a903\\share"
libexecdir = "D:\\cabal\\store\\ghc-8.10.7\\vector-algori_-0.8.0.4-b29c744777ba6eb5e9dce92857497800a1e8a903\\libexec"
sysconfdir = "D:\\cabal\\store\\ghc-8.10.7\\vector-algori_-0.8.0.4-b29c744777ba6eb5e9dce92857497800a1e8a903\\etc"

getBinDir     = catchIO (getEnv "vector_algorithms_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "vector_algorithms_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "vector_algorithms_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "vector_algorithms_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "vector_algorithms_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "vector_algorithms_sysconfdir") (\_ -> return sysconfdir)




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
