module Teste2122again where

import Data.List
import GHC.CmmToAsm.AArch64.Instr (d1)

--1
zip' :: [a] -> [b] -> [(a,b)]
zip' _ [] = []
zip' [] _ = []
zip' (h:t) (x:xs) = (h,x) : zip' t xs

preCrescente' :: Ord a => [a] -> [a]
preCrescente' [] = []
preCrescente' [x] = [x]
preCrescente' (h:t) 
    | h > head t = h : preCrescente' t
    | otherwise = [h]

--3
amplitude :: [Int] -> Int
amplitude l = uncurry (-).foldr (\x (vMax,vMin) -> (max x vMax,min x vMin)) (head l,head l) $ l

--4
type Mat a = [[a]]

soma :: Num a => Mat a -> Mat a -> Mat a
soma = (zipWith . zipWith) (+)

--5
type Nome = String
type Telefone = Integer
data Agenda = Vazia | Nodo (Nome,[Telefone]) Agenda Agenda

instance Show Agenda where
    show Vazia = ""
    show (Nodo (n,tel) e d) = show e ++ show n ++ " " ++ intercalate "/" (map show tel) ++ "\n" ++ show d

--6 - sobre IO
--7
organiza :: Eq a => [a] -> [(a,[Int])]
organiza l = [(x, elemIndices x l) | x <- nub l]
-- a função elem indices vai dizer as posições onde um elemento ocorre, a função nub vai juntar os elementos repetidos

--8
func :: [[Int]] -> [Int]
func [] = []
func (h:t) 
    | sum h > 10 = h ++ func t
    | otherwise = func t

--9
data RTree a = R a [RTree a]
type Dictionary = [ RTree (Char, Maybe String)]

d1 = [R ('c',Nothing) [
        R ('a',Nothing) [
          R ('r',Nothing) [
            R ('a',Just "...") [
              R ('s',Just "...") [] ],
            R ('o',Just "...") [],
            R ('r',Nothing) [
              R ('o',Just "...") [] ]
      ]  ] ] ]

insere :: String -> String -> Dictionary -> Dictionary
insere [x] desc dici = insereFim x desc dici
insere (h:t) desc [] = [R (h, Nothing) (insere t desc [])]
insere (h:t) desc (R (a,b) l:d)
    | h == a = R (a,b) (insere t desc l) : d
    | otherwise = R (a,b) l : insere (h:t) desc d

insereFim :: Char -> String -> Dictionary -> Dictionary
insereFim x desc [] = [R (x,Just desc) []]
insereFim x desc (R (a,b) l:t)
    | x == a = R (a, Just desc) l:t
