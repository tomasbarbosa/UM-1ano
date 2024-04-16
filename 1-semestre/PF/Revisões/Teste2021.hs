module Teste2021 where

import Data.List

--1
bb :: Eq a => [a] -> [a] -> [a]
bb [] l = []
bb l [] = l
bb l (x:xs) = bb (delete x l) xs

--2
type MSet a = [(a,Int)]

--a)
removeMSet :: Eq a => a -> [(a,Int)] -> [(a,Int)]
removeMSet a ((x,n):t)
    | a == x = if n == 1 then t else (x,n-1) : t
    | otherwise = (x,n) : removeMSet a t

--b)
calcula :: MSet a -> ([a],Int)
calcula l = (foldr (\(a,num) (elem,total) -> (a : elem, num + total)) ([],0)) l


--3
partes :: String -> Char -> [String]
partes s x = left : partes (drop 1 right) x
    where (left,right) = span (/= x) s 
    

--4
data BTree a = Empty | Node a (BTree a) (BTree a)

a1 = Node 5 (Node 3 Empty Empty)
            (Node 7 Empty (Node 9 Empty Empty))

remove :: Ord a => a -> BTree a -> BTree a
remove a Empty = Empty
remove a (Node x e d)  
    | a > x = Node x e (remove a d)
    | a < x = Node x (remove a e) d
    | a == x =
        case (e,d) of
            (Empty,e) -> e
            (d,Empty) -> d
            (e,d) -> let (valormin, treemin) = min_Tree d in Node valormin e  treemin

min_Tree :: Ord a => BTree a -> (a, BTree a)
min_Tree (Node e Empty r) = (e, r)
min_Tree (Node e l r)     = (vMin, Node e tMin r) 
    where (vMin, tMin) = min_Tree l

--b
instance Show a => Show (BTree a) where

 show Empty = "*"
 show (Node x e d) = "(" ++ show e ++ "<-" ++ show x ++ "->" ++ show d ++ ")"


--5
sortOn' :: Ord b => (a -> b) -> [a] -> [a]
sortOn' _ [] = []
sortOn' f (x:xs) = sortOn' f ys ++ [x] ++ sortOn' f zs
    where h = f x
          ys = [y | y <- xs, f y <= h]
          zs = [z | z <- xs, f z > h]


--6
data FileSystem = File Nome | Dir Nome [FileSystem]
type Nome = String

fs1 = Dir "usr" [Dir "xxx" [File "abc.txt", File "readme", Dir "PF" [File "exemplo.hs"]], Dir "yyy" [], Dir "zzz" [Dir "tmp" [], File "teste.c"] ]

--a
fichs :: FileSystem -> [Nome]
fichs (File n) = [n]
fichs (Dir n l) = concatMap fichs l


--b
{-
dirFiles :: FileSystem -> [Nome] -> Maybe [Nome]
dirFiles (File name) [] = Just [name]
dirFiles (Dir name files) (h:t)
    | h == name = 
        let results = mapMaybe (`dirFiles` t) files in
            if null results then 
                Nothing
            else 
                Just (concat results)
    | otherwise = Nothing
dirFiles _ _ = Nothing
-}
