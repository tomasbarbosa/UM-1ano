module Teste2 where

import Data.List

import Data.Char

--Exame 22
--1
replicate' :: Int -> a -> [a]
replicate' 0 _ = []
replicate' n letra = letra : replicate' (n-1) letra

--2
intersect' :: Eq a => [a] -> [a] -> [a]
intersect' _ [] = []
intersect' [] l = l
intersect' (h:t) l 
        | h `elem` l = h : intersect' t l
        | otherwise = intersect' t l

--3
data LTree a = Tip a | Fork (LTree a) (LTree a)
data FTree a b = Leaf a | No b (FTree a b) (FTree a b)

conv :: LTree Int -> FTree Int Int   
conv (Tip x) = Leaf x 
conv (Fork l r) = No p (conv l) (conv r)
   where p = sumLTree l + sumLTree r 
         sumLTree :: LTree Int -> Int
         sumLTree (Tip x) = x 
         sumLTree (Fork l r) = sumLTree l + sumLTree r 


--4
type Mat a = [[a]]

triSup :: (Eq a, Num a) => Mat a -> Bool
triSup (h:t) =  not (0 `elem` h) && aux t 1

aux :: (Eq a, Num a) => Mat a -> Int -> Bool
aux [] _ = True
aux (h:t) ac = not (False `elem` (map (== 0) (take ac h)))  && aux t (ac+1)


--5
data SReais = AA Double Double | FF Double Double
            | AF Double Double | FA Double Double
            | Uniao SReais SReais

--a)
instance Show SReais where
     show (AA a b) = "]" ++ show a ++ "," ++ show b ++ "["
     show (AF a b) = "]" ++ show a ++ "," ++ show b ++ "]"
     show (FF a b) = "[" ++ show a ++ "," ++ show b ++ "]"
     show (FA a b) = "[" ++ show a ++ "," ++ show b ++ "["
     show (Uniao a b) = "(" ++ show a ++ " U " ++ show b ++ ")"

--b)
tira :: Double -> SReais -> SReais
tira x (AA a b)
        | x > a && x < b = Uniao (AA a x) (AA x b)
        | otherwise = AA a b
tira x (FF a b)
    | x > a && x < b = Uniao (FA a x) (AF x b) 
    | x == a = AF a b
    | x == b = FA a b
    | otherwise = FF a b
tira x (AF a b)
    | x > a && x < b = Uniao (AA a x) (AF x b) 
    | x == b = AA a b
    | otherwise = AF a b
tira x (FA a b)
    | x > a && x < b = Uniao (FA a x) (AA x b) 
    | x == a = AA a b
    | otherwise = FA a b
tira x (Uniao a b) = Uniao (tira x a) (tira x b)


--6
func :: Float -> [(Float, Float)] -> [Float]
func x [] = []
func x ((xy,xs):t)  
    | xy > x = xs : func x t
    | otherwise = func x t


--7
subseqSum :: [Int] -> Int -> Bool
subseqSum [] _ = False
subseqSum l x = any ((== x).sum) (inits l) || subseqSum (tail l) x


--Teste 2021

--1

barrabarra :: Eq a => [a] -> [a] -> [a]
barrabarra [] _ = []
barrabarra l [] = l
barrabarra l (h:t) = barrabarra (delete h l) t

--2
type MSet a = [(a,Int)]

--a)
removeMSet :: Eq a => a -> [(a,Int)] -> [(a,Int)]
removeMSet a [] = []
removeMSet a ((x,n):t) 
      | a == x = if n == 1 then t else  (x,(n-1)):t
      | otherwise = (a,n) : removeMSet x t 

--b)
calcula :: MSet a -> ([a],Int)
calcula = foldr (\(a,n) (elems, total) -> (a : elems , n + total)) ([],0)


--4)

data BTree a = Empty | Node a (BTree a) (BTree a)

--a)
remove :: Ord a => a -> BTree a -> BTree a
remove _ Empty = Empty
remove x (Node r e d) 
    | x > r = Node r e (remove x d)
    | x < r = Node r (remove x e) d
    | otherwise = 
        case (e,d) of (Empty, d) -> d
                      (e, Empty) -> e
                      (e,d) -> let (vmin, tmin) = min_Tree d in Node vmin e tmin

min_Tree :: Ord a => BTree a -> (a, BTree a)
min_Tree (Node e Empty r) = (e, r)
min_Tree (Node e l r)     = (vMin, Node e tMin r) 
    where (vMin, tMin) = min_Tree l

--b
instance  Show a => Show (BTree a) where
showa :: Show a => BTree a -> String
showa Empty = "*"
showa (Node r e d) = "(" ++  show e  ++ "<-" ++ show r ++ "->" ++  show d  ++  ")"  


