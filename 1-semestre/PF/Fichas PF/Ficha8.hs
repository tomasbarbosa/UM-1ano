module Ficha8 where

data Frac = F Integer Integer

-- máximo divisor comum
mdc :: Integer -> Integer -> Integer
mdc x y
    | x == y = x
    | x > y = mdc (x-y) y
    | x < y = mdc x (y-x)

--1
--a)
--normaliza
normaliza :: Frac -> Frac
normaliza (F x y) = F (s*a) b
    where d = mdc (abs x) (abs y)
          a = div (abs x) d
          b = div (abs y) d
          s = (signum x) + (signum y)

--b)
instance Eq Frac where
    f1 == f2 = (a == x) && (b == y)
      where
        (F a b) = normaliza f1
        (F x y) = normaliza f2

instance Ord Frac where
    f1 <= f2 = a*y <= x*b
      where
        (F a b) = normaliza f1
        (F x y) = normaliza f2
        

