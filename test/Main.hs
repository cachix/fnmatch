module Main (main) where

import Test.Hspec

import qualified FnMatch


main :: IO ()
main = do 
    hspec $ do
      describe "FnMatch" $ do
        it "matches a pattern" $ do
          FnMatch.fnmatch "abc" "abc" 0 `shouldBe` True
        it "doesn't match a pattern" $ do
          FnMatch.fnmatch "abc" "def" 0 `shouldBe` False
        it "matches a pattern with a ?" $ do
          FnMatch.fnmatch "a?c" "abc" 0 `shouldBe` True
        it "matches a pattern with a *" $ do
          FnMatch.fnmatch "a*c" "abc" 0 `shouldBe` True