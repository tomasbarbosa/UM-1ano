module Cinqq where

import Data.List
import Data.Char

--1
enumFromTo' :: Int -> Int -> [Int]
enumFromTo' x a = [x..a]

--2
enumFromThenTo' :: Int -> Int -> Int -> [Int]
enumFromThenTo' a b c = [a,b..c]

--3
mm :: [a] -> [a] -> [a]
mm = foldr (:)

--4

pepe :: [a] -> Int -> a
pepe l x = fst.head.filter ((==x).snd) $ (zip l [0..])
    --snd (filter (\(a,b) -> a == x) (map (zip[0..]) l))

--5
reverse' :: [a] -> [a]
reverse' [] = []
reverse' (h:t) = (reverse' t) ++ [h]
