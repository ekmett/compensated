{-# LANGUAGE RankNTypes #-}
import Criterion.Main

import Numeric.Compensated

class Square a where sqr :: a -> a
instance Square Float where sqr x = x * x
instance Square Double where sqr x = x * x
instance Compensable a => Square (Compensated a) where sqr = square

group :: String -> (forall a . (Floating a, Square a) => a -> a) -> Benchmark
group name f = bgroup name
  [ bench "Float" $ whnf f (0.2 :: Float)
  , bench "Double" $ whnf f (0.2 :: Double)
  , bench "Compensated Float" $ whnf f (0.2 :: Compensated Float)
  , bench "Compensated Double" $ whnf f (0.2 :: Compensated Double)
  , bench "Overcompensated Float" $ whnf f (0.2 :: Overcompensated Float)
  , bench "Overcompensated Double" $ whnf f (0.2 :: Overcompensated Double)
  ]

main :: IO ()
main = defaultMain
  [ group "(+)" (0.1 +)
  , group "(-)" (0.1 -)
  , group "(*)" (0.1 *)
  , group "negate" $ negate
  , group "square" $ sqr
  , group "(/)" $ (0.1 /)
  , group "recip" $ recip
  , group "sqrt" $ sqrt
  ]
