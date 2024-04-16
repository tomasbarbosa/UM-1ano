module Exame1920 where

import Data.List
import Data.Char
import System.Random

--1

--a
inits' :: [a] -> [[a]]
inits' [] = [[]]
inits' l = inits (init l) ++ [l]

--b
isPrefixOf' :: Eq a => [a] -> [a] -> Bool
isPrefixOf' [] l = True
isPrefixOf' l [] = False
isPrefixOf' (h:t) (x:xs) 
    | h == x = isPrefixOf' t xs
    | otherwise = isPrefixOf' (h:t) xs


--2
data BTree a = Empty 
            | Node a (BTree a) (BTree a)
            deriving Show
    
--a
folhas :: BTree a -> Int
folhas Empty = 0
folhas (Node a Empty Empty) = 1
folhas (Node a e d) = folhas e + folhas d

--b
path :: [Bool] -> BTree a -> [a]
path l Empty = []
path [] (Node a e d) = [a]
path (h:t) (Node a e d)
    | h == False = [a] ++ path t e
    | otherwise = [a] ++ path t d


--3
type Polinomio = [Coeficiente]
type Coeficiente = Float

--a
valor :: Polinomio -> Float -> Float                  
valor l x = foldr (\(g,c) acc -> acc + c * x ^ g) 0 (zip [0..] l)

--b
deriv :: Polinomio -> Polinomio
deriv l = tail . map (\ (g,c) -> g*c) . zip [0..] $ l
--deriv l = (tail . map (uncurry (*)) . zip [0..]) l


--c
soma :: Polinomio -> Polinomio -> Polinomio
soma l1 l2 = zipWith (+) (freeLoad l1) (freeLoad l2)
    where max_length = max (length l1) (length l2)
          freeLoad l = l ++ (replicate (max_length - length l) 0) 


--4
type Mat a = [[a]]

--a
quebraLinha :: [Int] -> [a] -> [[a]]
quebraLinha _ [] = []
quebraLinha (h:t) l = ls : quebraLinha t rs
    where (ls, rs) = splitAt h l


--b
fragmenta :: [Int] -> [Int] -> Mat a -> [Mat a]
fragmenta [] _ _ = []
fragmenta (x:xs) y m = fragmentaCols y (take x m) ++ fragmenta xs y (drop x m)

fragmentaCols :: [Int] -> Mat a -> [Mat a]
fragmentaCols [] _ = []
fragmentaCols (y:ys) m = map (take y) m : fragmentaCols ys (map (drop y) m)


