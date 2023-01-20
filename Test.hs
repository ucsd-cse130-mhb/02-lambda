--------------------------------------------------------------------------------
-- DO NOT MODIFY ANYTHING IN THIS FILE -----------------------------------------
--------------------------------------------------------------------------------

{-# LANGUAGE ScopedTypeVariables #-}

import Data.IORef
import Test.Tasty.HUnit
import System.Exit
import Control.Exception
import Test.Tasty
import Language.Elsa
import System.FilePath

main :: IO ()
main = runTests [unit1]

unit1 :: Score -> TestTree
unit1 sc = testGroup "Unit 1"
  [ mkTest
      (check "01_pair.lc")
      "or_ff_tt"
      True
      15
      "booleans: or_ff_tt"
  , mkTest
      (check "01_pair.lc")
      "snd_snd_pairs"
      True
      15
      "pairs: snd_snd_pairs"
  , mkTest
      (check "01_pair.lc")
      "third_triple"
      True
      15
      "tuples: third_triple"
  , mkTest
      (check "02_minus.lc")
      "skip1_false"
      True
      10
      "skip1_false"
  , mkTest
      (check "02_minus.lc")
      "skip1_true_zero"
      True
      10
      "skip1_true_zero"
  , mkTest
      (check "02_minus.lc")
      "skip1_true_one"
      True
      10
      "skip1_true_one"
  , mkTest
      (check "02_minus.lc")
      "decr_zero"
      True
      5
      "decr_zero"
  , mkTest
      (check "02_minus.lc")
      "decr_one"
      True
      5
      "decr_one"
  , mkTest
      (check "02_minus.lc")
      "decr_two"
      True
      5
      "decr_two"

  , mkTest
      (check "02_minus.lc")
      "sub_two_zero"
      True
      5
      "sub_two_zero"
  , mkTest
      (check "02_minus.lc")
      "sub_two_one"
      True
      5
      "sub_two_one"
  , mkTest
      (check "02_minus.lc")
      "sub_two_two"
      True
      5
      "sub_two_two"
  , mkTest
      (check "02_minus.lc")
      "sub_two_three"
      True
      5
      "sub_two_three"
  , mkTest
      (check "02_minus.lc")
      "isz_zero"
      True
      5
      "isz_zero"
  , mkTest
      (check "02_minus.lc")
      "isz_one"
      True
      5
      "isz_one"

  , mkTest
      (check "02_minus.lc")
      "eq_zero_zero"
      True
      5
      "eq_zero_zero"
  , mkTest
      (check "02_minus.lc")
      "eq_zero_one"
      True
      5
      "eq_zero_one"
  , mkTest
      (check "02_minus.lc")
      "eq_one_two"
      True
      5
      "eq_one_two"
  , mkTest
      (check "02_minus.lc")
      "eq_two_two"
      True
      5
      "eq_two_two"

  , mkTest
      (check "03_fact.lc")
      "fact_zero"
      True
      15
      "fact_zero"
  , mkTest
      (check "03_fact.lc")
      "fact_one"
      True
      15
      "fact_one"
  , mkTest
      (check "03_fact.lc")
      "fact_two"
      True
      15
      "fact_two"
  , mkTest
      (check "03_fact.lc")
      "fact_three"
      True
      15
      "fact_three"
  ]
  where
    mkTest :: (Show b, Eq b) => (a -> IO b) -> a -> b -> Int -> String -> TestTree
    mkTest = scoreTest' sc

--------------------------------------------------------------------------------
-- | runElsa checks if the single eval-target `x` in file `f` is OK.
--------------------------------------------------------------------------------
check :: FilePath -> Id -> IO Bool
check f x = do
  r <- runElsaId (testDir </> f) x
  return (r == Just (OK (Bind x ())))

testDir :: FilePath
testDir = "tests"

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

type Score = IORef (Int, Int)

runTests :: [Score -> TestTree] -> IO ()
runTests groups = do
  sc <- initScore
  defaultMain--WithIngredients (includingOptions coreOptions : defaultIngredients)
    (tests sc groups) `catch` (\(e :: ExitCode) -> do
      (n, tot) <- readIORef sc
      putStrLn ("OVERALL SCORE = " ++ show n ++ " / "++ show tot)
      throwIO e)

tests :: Score -> [Score -> TestTree] -> TestTree
tests x gs = testGroup "Tests" [ g x | g <- gs ]

--------------------------------------------------------------------------------
-- | Construct a single test case
--------------------------------------------------------------------------------
scoreTest'
 :: (Show b, Eq b) => Score -> (a -> IO b) -> a -> b -> Int -> String -> TestTree
--------------------------------------------------------------------------------
scoreTest' sc f x expR points name =
  testCase name $ do
    updateTotal sc points
    actR <- f x
    if actR == expR
      then updateCurrent sc points
      else assertFailure "Wrong Result"

updateTotal :: Score -> Int -> IO ()
updateTotal sc n = modifyIORef sc (\(x, y) -> (x, y + n))

updateCurrent :: Score -> Int -> IO ()
updateCurrent sc n = modifyIORef sc (\(x, y) -> (x + n, y))

initScore :: IO Score
initScore = newIORef (0, 0)
