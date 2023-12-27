module Main where

import Criterion.Main

import qualified Data.ByteString as BS
import qualified FnMatch


main :: IO ()
main = defaultMain [
    bgroup "FnMatch" [
        bench "matches a pattern" $
          whnf (FnMatch.fnmatch "abc" "abc") []
      , bench "matches a long pattern with a *" $ 
          whnf (FnMatch.fnmatch "a*c" (BS.replicate 1000000 98 `BS.append` "c")) []
      ]
  ]