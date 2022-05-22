{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_regex_posix_clib (
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
version = Version [2,7] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "D:\\cabal\\store\\ghc-8.10.7\\regex-posix-c_-2.7-cf5b873c807f4417b42f9bf7612ab37cb2341195\\bin"
libdir     = "D:\\cabal\\store\\ghc-8.10.7\\regex-posix-c_-2.7-cf5b873c807f4417b42f9bf7612ab37cb2341195\\lib"
dynlibdir  = "D:\\cabal\\store\\ghc-8.10.7\\regex-posix-c_-2.7-cf5b873c807f4417b42f9bf7612ab37cb2341195\\lib"
datadir    = "D:\\cabal\\store\\ghc-8.10.7\\regex-posix-c_-2.7-cf5b873c807f4417b42f9bf7612ab37cb2341195\\share"
libexecdir = "D:\\cabal\\store\\ghc-8.10.7\\regex-posix-c_-2.7-cf5b873c807f4417b42f9bf7612ab37cb2341195\\libexec"
sysconfdir = "D:\\cabal\\store\\ghc-8.10.7\\regex-posix-c_-2.7-cf5b873c807f4417b42f9bf7612ab37cb2341195\\etc"

getBinDir     = catchIO (getEnv "regex_posix_clib_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "regex_posix_clib_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "regex_posix_clib_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "regex_posix_clib_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "regex_posix_clib_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "regex_posix_clib_sysconfdir") (\_ -> return sysconfdir)




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
