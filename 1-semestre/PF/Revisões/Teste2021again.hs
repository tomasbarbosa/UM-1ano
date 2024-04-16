module Teste2021again where

import Data.List
import GHC.CmmToAsm.AArch64.Instr (x0)

--1
bb :: Eq a => [a] -> [a] -> [a]
bb [] _ = []
bb l [] = l
bb l (h:t) = bb (delete h l) t

delete' :: Eq a => a -> [a] -> [a]
delete' _ [] = []
delete' x (h:t)
    | x == h = t
    | otherwise = h : delete x t

--2

type MSet a = [(a,Int)]

--a
removeMSet' :: Eq a => a -> [(a,Int)] -> [(a,Int)]
removeMSet' _ [] = []
removeMSet' x ((c,1):t)
    | x == c = t
    | otherwise = (c,1) : removeMSet' x t
removeMSet' x ((c,n):t)
    | x == c = (c,n-1) : t
    | otherwise = (c,n) : removeMSet' x t

--b
calcula :: MSet a -> ([a],Int)
calcula = foldr (\(c,n) (total_c,total_n) -> (c : total_c, n + total_n)) ([],0)

--3
partes :: String -> Char -> [String]
partes s sep =
              case span(/= sep) s of
                ("",rest) -> partes (tail rest) sep
                (part,"") -> [part]
                (part,rest) -> part : partes (tail rest) sep

--4
data BTree a = Empty | Node a (BTree a) (BTree a)

a1 = Node 5 (Node 3 Empty Empty)
            (Node 7 Empty (Node 9 Empty Empty))

--a
remove :: Ord a => a -> BTree a -> BTree a
remove c Empty = Empty
remove c (Node x e d)
    | c > x = Node x e (remove c d)
    | c < x = Node x (remove c e) d
    | otherwise = case (e,d) of 
                    (Empty,d) -> d
                    (e,Empty) -> e
                    (e,d) -> let (min, sMin) = minSMin d in Node min e sMin

minSMin :: BTree a -> (a, BTree a)
minSMin (Node e Empty r) = (e, r)
minSMin (Node e l r) = let (min, sMin) = minSMin l in (min, Node e sMin r)


--5
sortOn' :: Ord b => (a -> b) -> [a] -> [a]
sortOn' f (h:t) = insertOn f h (sortOn' f t)

insertOn :: Ord b => (a -> b) -> a -> [a] -> [a]
insertOn f x [] = []
insertOn f x (h:t) = if f x > f h then h : insertOn f x t else x : h : t

--6
data FileSystem = File Nome | Dir Nome [FileSystem]
type Nome = String

fs1 = Dir "usr" [Dir "xxx" [File "abc.txt", File "readme", Dir "PF" [File "exemplo.hs"]],
                 Dir "yyy" [], Dir "zzz" [Dir "tmp" [], File "teste.c"] ]

--a
fichs :: FileSystem -> [Nome] 
fichs (File n) = [n]
fichs (Dir _ files ) = concatMap fichs files


