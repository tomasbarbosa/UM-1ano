module Exame2122 where

import Data.List
import Data.Char

import System.Random

--1
replicate' :: Int -> a -> [a]
replicate' 0 x = []
replicate' n x = x : replicate' (n-1) x

--2
intersect' :: Eq a => [a] -> [a] -> [a]
intersect' [] l = []
intersect' _ [] = []
intersect' (h:t) l
    | h `elem` l = h : intersect' l t
    | otherwise = intersect' l t


--3
data LTree a = Tip a | Fork (LTree a) (LTree a)
data FTree a b = Leaf a | No b (FTree a b) (FTree a b)

conv :: LTree Int -> FTree Int Int 
conv (Tip a) = Leaf a
conv (Fork l r) = No b (conv l) (conv r)
    where b = sumLTree l + sumLTree r
sumLTree :: LTree Int -> Int
sumLTree (Tip a) = a
sumLTree (Fork l r) = sumLTree l + sumLTree r


--4
type Mat a = [[a]]

triSup = all (all (==0)) . map (\(x,xs) -> take x xs) . zip [0..]

--5
data SReais = AA Double Double | FF Double Double
            | AF Double Double | FA Double Double
            | Uniao SReais SReais

--a

instance Show SReais where
    show (AA x y) = "]" ++ show x ++ "," ++ show y ++ "["
    show (FF x y) = "[" ++ show x ++ "," ++ show y ++ "]"
    show (AF x y) = "]" ++ show x ++ "," ++ show y ++ "]"
    show (FA x y) = "[" ++ show x ++ "," ++ show y ++ "["
    show (Uniao x y) = "(" ++ show x ++ "U" ++ show y ++")"

--b
tira :: Double -> SReais -> SReais
tira x (AA a b) 
    | (x > a && x < b) = Uniao (AA a x) (AA x b)
    | otherwise = (AA a b)
tira x (FF a b) 
    | (x > a && x < b) = Uniao (FA a x) (AF x b)
    | otherwise = (FF a b)
tira x (AF a b) 
    | (x > a && x < b) = Uniao (AA a x) (AF x b)
    | otherwise = (AF a b)
tira x (FA a b) 
    | (x > a && x < b) = Uniao (FA a x) (AA x b)
    | otherwise = (FA a b)
tira x (Uniao a b) = Uniao (tira x a) (tira x b)



--6
func :: Float -> [(Float,Float)] -> [Float]
func _ [] = []
func x ((a,b):t)
    | a > x = b : func x t
    | otherwise = func x t

--7
subseqSum :: [Int] -> Int -> Bool
subseqSum [] _ = False 
subseqSum l x = any ((== x).sum) (inits l) || subseqSum (tail l) x

--8

gera :: Int -> (Int,Int) -> IO [Int]
gera 0 _ = return []
gera n (a,b) = do p <- randomRIO (a,b)
                  ps <- gera (n-1) (a,b)
                  return (p:ps)

-- ... .... . .. . . .



