{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TemplateHaskell #-}
import Test.QuickCheck
--import Numeric.QD
import Numeric.Compensated
import System.Exit

{-
instance Arbitrary QuadDouble where
  arbitrary = do
    s <- genBool
    a <- genDouble
    b <- genDouble
    c <- genDouble
    d <- genDouble
    e <- chooseInt (-150, 150)
    let f = 2 ^^ e
    return $ if s then negate else id $ fromDouble (a * f) + fromDouble (b * f * 1e-15) + fromDouble (c * f * 1e-30) + fromDouble (d * f * 1e-45)
-}

instance Arbitrary (Compensated Double) where
  arbitrary = do
    s <- arbitrary
    a <- arbitrary
    b <- arbitrary
    e <- chooseInt (-200, 200)
    let f = 2 ^^ e
        g = 2 ^^ negate 54
    return $ (if s then negate else id) $ add (a * f) (b * f * g) compensated

instance Arbitrary (Compensated (Compensated Double)) where
  arbitrary = do
    s <- arbitrary
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    d <- arbitrary
    e <- chooseInt (-200, 200)
    let f = 2 ^^ e
        g = 2 ^^ negate 54
    return $ (if s then negate else id) $ add (add (a * f) (b * f * g) compensated) (add (c * f * g^2) (d * f * g^3) compensated) compensated

type R = Compensated (Compensated Double)
epsilon = 2 ^^ negate 107
epsilon2 = 2 ^^ negate 215

tadd2 :: R -> R -> Bool
tadd2 = \a b ->
  let rounded = toRational (a + b)
      exact = toRational a + toRational b
  in  abs (rounded - exact) <= epsilon2 * abs exact

tsplit :: Double -> Double -> Bool
tsplit x y = let a = add x y compensated in a == split a (+)

tsplit2 :: Compensated Double -> Compensated Double -> Bool
tsplit2 x y = let a = add x y compensated in a == split a (+)

ttimes :: Compensated Double -> Compensated Double -> Bool
ttimes a b =
  let rounded = toRational (times a b compensated)
      exact = toRational a * toRational b
  in  abs (rounded - exact) <= epsilon2 * abs exact

tmul :: Compensated Double -> Compensated Double -> Bool
tmul = \a b ->
  let rounded = toRational (a * b)
      exact = toRational a * toRational b
  in  abs (rounded - exact) <= epsilon * abs exact

tmul2 :: R -> R -> Bool
tmul2 = \a b ->
  let rounded = toRational (a * b)
      exact = toRational a * toRational b
  in  abs (rounded - exact) <= epsilon2 * abs exact

prop_add2 = withMaxSuccess 100100 tadd2
prop_split = withMaxSuccess 100100 tsplit
prop_split2 = withMaxSuccess 100100 tsplit2
prop_times = withMaxSuccess 100100 ttimes
prop_mul = withMaxSuccess 100100 tmul
prop_mul2 = withMaxSuccess 100100 tmul2

return []
main = do
  let a,b :: Compensated Double
      a = compensated (-211.11871471905192) 8.926709967512482e-15
      b = compensated 3.9220612083458963e-19 (-1.80497973320049e-35)
      rounded = toRational (times a b compensated)
      exact = toRational a * toRational b
      err = logBase 2 . fromRational $ abs (rounded - exact) / abs exact
  print err
  ok <- $quickCheckAll
  if ok then exitSuccess else exitFailure
