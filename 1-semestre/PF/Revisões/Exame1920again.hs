module Exame1920again where

import Data.List

--1

--a
inits' :: [a] -> [[a]] 
inits' [] = [[]]
inits' l = inits' (init l) ++ [l]

--b
isPrefixOf' :: Eq a => [a] -> [a] -> Bool
isPrefixOf' [] l = True
isPrefixOf' l [] = False
isPrefixOf' (x:xs) (y:ys) = x == y && isPrefixOf' xs ys

--2

data BTree a = Empty
             | Node a (BTree a) (BTree a)
  deriving Show

--a
folhas :: BTree a -> Int
folhas Empty = 0
folhas (Node r Empty Empty) = 1
folhas (Node r e d) = folhas e + folhas d

--b
path :: [Bool] -> BTree a -> [a]
path [] _ = []
path _ Empty = []
path (h:t) (Node r e d) = if h then r : path t d else r : path t e

--3
type Polinomio = [Coeficiente]
type Coeficiente = Float

--a
valor :: Polinomio -> Float -> Float
valor l x = foldr (\(c,grau) t -> c*x^grau + t) 0 (zip l [0..])

--b
deriv :: Polinomio -> Polinomio
deriv = map (uncurry (*)) .tail.zip [0..]

--c
soma :: Polinomio -> Polinomio -> Polinomio 
soma p1 p2 = zipWith (+) (pad p1) (pad p2)
            where max_lenght = max (length p1) (length p2)
                  pad p = p ++ replicate (max_lenght - length p) 0

--4
type Mat a = [[a]]

--a
quebraLinha :: [Int] -> [a] -> [[a]]
quebraLinha [] _ = []
quebraLinha (h:t) l = take h l : quebraLinha t (drop h l)

--b
fragmenta :: [Int] -> [Int] -> Mat a -> [Mat a]
fragmenta (h:t) c m = fragmentaC c (take h m) ++ fragmenta t c (drop h m)

fragmentaC :: [Int] -> Mat a -> [Mat a]
fragmentaC [] _ = [] 
fragmentaC (x:xs) m = map (take x) m : fragmentaC xs (map (drop x) m)

sortOn' :: Ord b => (a-> b) -> [a] -> [a]
sortOn' f (h:t) = insertOn' f h (sortOn' f t)

insertOn' :: (Ord b) => (a->b) -> a -> [a] -> [a] 
insertOn' f x [] = [x]
insertOn' f x (h:t) = if f x > f h then h : insertOn' f x t else x:h:t