module Exame2122again where

import Data.List

--1
replicate' :: Int -> a -> [a]
replicate' 0 a = []
replicate' n a 
    | n > 0 = a : replicate' (n-1) a
    | otherwise = []

--2
intersect' :: Eq a => [a] -> [a] -> [a]
intersect' l [] = []
intersect' [] l = []
intersect' (h:t) l 
    | h `elem` l = h : intersect' t l
    | otherwise = intersect' t l

--3
data LTree a = Tip a | Fork (LTree a) (LTree a)
data FTree a b = Leaf a | No b (FTree a b) (FTree a b)

conv :: LTree Int -> FTree Int Int
conv = snd . convAux 

convAux :: LTree Int -> (Int,FTree Int Int)
convAux (Tip a) = (a, Leaf a)
convAux (Fork e d) = (s, No s ee dd)
    where (se, ee) = convAux e
          (sd, dd) = convAux d
          s = se + sd

--4
type Mat a = [[a]]

triSup :: (Eq a,Num a) => Mat a -> Bool
triSup  = all (all (== 0) .uncurry take) . zip [0..]

--5
data SReais = AA Double Double | FF Double Double
 | AF Double Double | FA Double Double
 | Uniao SReais SReais

--a
instance Show SReais where
    show (AA  a b) = "]" ++ show a ++ "," ++ show b ++ "["
    show (AF  a b) = "]" ++ show a ++ "," ++ show b ++ "]"
    show (FA  a b) = "[" ++ show a ++ "," ++ show b ++ "["
    show (FF  a b) = "[" ++ show a ++ "," ++ show b ++ "]"
    show (Uniao a b) = show a ++ "U" ++ show b

--b
tira :: Double -> SReais -> SReais
tira x (AA a b)
    | x > a && x < b = Uniao (AA a x) (AA x b)
    | otherwise = AA a b
tira x (AF a b)
    | x > a && x < b = Uniao (AA a x) (AF x b)
    | x == b = AA a b
    | otherwise = AF a b
tira x (FA a b)
    | x > a && x < b = Uniao (FA a x) (AA x b)
    | x == a = AA a b
    | otherwise = FA a b 
tira x (FF a b)
    | x > a && x < b = Uniao (FA a x) (AF x b)
    | x == a = AF a b
    | x == b = FA a b
    | otherwise = FF a b 
tira x (Uniao a b) = Uniao (tira x a) (tira x b)

--6
func :: Float -> [(Float,Float)] -> [Float]
func x l = map snd (filter ((>x) . fst) l)

funcos :: Float -> [(Float,Float)] -> [Float]
funcos n [] = []
funcos n ((x,xs):t) 
    | x > n = xs : funcos n t
    | otherwise = funcos n t

--7
subseqSum :: [Int] -> Int -> Bool
subseqSum [] _ = False
subseqSum l x = any ((== x) . sum) (inits l) || subseqSum (tail l) x
