module Main (main) where

import Test.Hspec

import qualified FnMatch


main :: IO ()
main = do 
    hspec $ do
      describe "FnMatch" $ do
        it "matches a pattern" $ do
          FnMatch.fnmatch "abc" "abc" [] `shouldBe` True
        it "doesn't match a pattern" $ do
          FnMatch.fnmatch "abc" "def" [] `shouldBe` False
        it "matches a pattern with a ?" $ do
          FnMatch.fnmatch "a?c" "abc" [] `shouldBe` True
        it "matches a pattern with a *" $ do
          FnMatch.fnmatch "a*c" "abc" [] `shouldBe` True
        -- we pass a FlagCaseFold to fnmatch 
        it "matches a pattern with a case fold flag" $ do
          FnMatch.fnmatch "a*c" "ABC" [FnMatch.FlagCaseFold] `shouldBe` True
          FnMatch.fnmatch "a*c" "ABC" [] `shouldBe` False
