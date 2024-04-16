module Teste2122 where

import Data.List

import Data.Char

import System.Random

--1
zip' :: [a] -> [b] -> [(a,b)]
zip' [] l = []
zip' l [] = []
zip' (x:xs) (y:ys) = (x,y) : zip' xs ys

--2
preCrescente' :: Ord a => [a] -> [a]
preCrescente' [] = []
preCrescente' [x] = [x]
preCrescente' (x:y:z) 
    | x < y = x : preCrescente' (y:z)
    | otherwise = [x]

--3
amplitude :: [Int] -> Int
amplitude l = (uncurry (-) . ((foldr (\x (vMax, vMin) -> (max x vMax, min x vMin))) (head l, head l))) l

--4
type Mat a = [[a]]

soma :: Num a => Mat a -> Mat a -> Mat a
soma l x = (zipWith . zipWith ) (+) l x


--5
type Nome = String
type Telefone = Integer
data Agenda = Vazia | Nodo (Nome,[Telefone]) Agenda Agenda

instance Show Agenda where
    show Vazia = ""
    show (Nodo (nome, tlfs) l r) = 
        show l
        ++ nome ++ " " ++ intercalate "/" (map show tlfs) ++ "\n"
        ++ show r