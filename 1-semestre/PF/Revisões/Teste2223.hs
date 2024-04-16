module Teste2223 where

import Data.List

--1
unlines' :: [String] -> String
unlines' [] = ""
unlines' [x] = "x"
unlines' (h:t) = "h" ++ "\n" ++ unlines' t

--2

--a
type Mat = [[Int]]

stringToMat :: String -> Mat
stringToMat s = map stringToVector (lines s)

stringToVector :: String -> [Int]
stringToVector "" = []
stringToVector s = 
    case span (/= ',') s of
         (a,"") -> [read a]
         (a,b) -> read a : stringToVector (tail b)
     
 --b
transposta :: String -> String
transposta s =  (unlines . map (intercalate "," . map show ).transpose . stringToMat) s


 -- lines "2,3,6,4\n12,3,12,4\n3,-4,5,7"
 --["2,3,6,4","12,3,12,4","3,-4,5,7"]

 --["2,12,3","3,3,-4","6,12,5","4,4,7"]

--[[2,12,3],[3,3,-4],[6,12,5],[4,4,7]]

--"[[2,12,3],[3,3,-4],[6,12,5],[4,4,7]]"

--3
data Lista a = Esq a (Lista a) | Dir (Lista a) a | Nula

--a
semUltimo :: Lista a -> Lista a
semUltimo (Esq a Nula) = Nula
semUltimo (Esq a l) = Esq a (semUltimo l)
semUltimo (Dir l a) = l

--b
instance Show a => Show (Lista a) where
 show l = "[" ++ showAux l ++ "]"
    where 
        showAux Nula = ""
        showAux (Esq a Nula) = show a
        showAux (Dir Nula a) = show a
        showAux (Esq a l) = show a ++ showAux l
        showAux (Dir l a) = showAux l ++ show a


--4
data BTree a = Empty | Node a (BTree a) (BTree a)
inorder :: BTree a -> [a]
inorder Empty = []
inorder (Node r e d) = (inorder e) ++ (r:inorder d)

--a
numera :: BTree a -> BTree (a,Int)
numera = snd . numeraAux 0


numeraAux :: Int -> BTree a -> (Int,BTree(a,Int))
numeraAux _ Empty = (0,Empty)
numeraAux n (Node x e d) = (novo_n + n_dir, Node (x,novo_n) novo_e novo_d)
    where (n_esq, novo_e) = numeraAux n e
          novo_n = n_esq + n + 1
          (n_dir, novo_d) = numeraAux novo_n d

--na 4 a) como é que ele vai adicionando à lista???


--b

