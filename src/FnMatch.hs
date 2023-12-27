{-# LANGUAGE CApiFFI #-}

module FnMatch (fnmatch, FnMatchFlags (..)) where

import Data.Bits ((.|.))
import Data.ByteString qualified as BS
import Data.ByteString.Unsafe qualified as BU
import Foreign.C
import GHC.IO (unsafePerformIO)

foreign import capi "fnmatch.h fnmatch"
  c_fnmatch ::
    CString -> CString -> CInt -> IO CInt

data FnMatchFlags
  = FlagNoEscape
  | FlagPathName
  | FlagPeriod
  | FlagLeadingDir
  | FlagCaseFold
  | FlagExtMatch
  deriving (Eq, Show)

fnmatch :: BS.ByteString -> BS.ByteString -> [FnMatchFlags] -> Bool
fnmatch pattern str flags = unsafePerformIO $
  BU.unsafeUseAsCString pattern $ \c_pattern ->
    BU.unsafeUseAsCString str $ \c_str -> do
      result <- c_fnmatch c_pattern c_str flags'
      return (result == 0)
  where
    flags' = foldr (\flag acc -> acc .|. flag) 0 (map flagToCInt flags)
    flagToCInt FlagNoEscape = 1
    flagToCInt FlagPathName = 2
    flagToCInt FlagPeriod = 4
    flagToCInt FlagLeadingDir = 8
    flagToCInt FlagCaseFold = 16
    flagToCInt FlagExtMatch = 32
