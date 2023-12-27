module FnMatch (fnmatch) where

import Foreign.C
import qualified Data.ByteString as BS
import qualified Data.ByteString.Unsafe as BU
import GHC.IO (unsafePerformIO)


foreign import ccall "fnmatch" c_fnmatch 
  :: CString -> CString -> CInt -> IO CInt

fnmatch :: BS.ByteString -> BS.ByteString -> Int -> Bool
fnmatch pattern str flags = unsafePerformIO $
  BU.unsafeUseAsCString pattern $ \c_pattern ->
    BU.unsafeUseAsCString str $ \c_str -> do
      result <- c_fnmatch c_pattern c_str (fromIntegral flags)
      return (result == 0)