module Ficha5 where

import Data.List


--a
any' :: (a -> Bool) -> [a] -> Bool
any' f [] = False
any' f (h:t) 
    | f h = True
    | otherwise = any' f t

--b
zipWith' :: (a->b->c) -> [a] -> [b] -> [c]
zipWith' f (h:t) (x:xs) = f h x : zipWith' f t xs
zipWith' _ _ _ = []

--c
takeWhile' :: (a->Bool) -> [a] -> [a]
takeWhile' f [] = []
takeWhile' f (h:t) 
    | f h = h : takeWhile' f t
    | otherwise = []

--d 
dropWhile' :: (a->Bool) -> [a] -> [a]
dropWhile' f [] = []
dropWhile' f l 
    | f (head l) = dropWhile' f (tail l)
    | otherwise = l

--e
span' :: (a -> Bool) -> [a] -> ([a],[a])
span' f l = (takeWhile f l, dropWhile f l)

--f
deleteBy' :: (a -> a -> Bool) -> a -> [a] -> [a]
deleteBy' _ _ [] = []
deleteBy' f a (h:t)
    | f a h = t
    | otherwise = h : deleteBy' f a t

--g
sortOn' :: (Ord b) => (a -> b) -> [a] -> [a]
sortOn' f (h:t) = insertOn f h (sortOn' f t)
    
insertOn :: (Ord b) => (a -> b) -> a -> [a] -> [a]
insertOn _ x [] = [x]
insertOn f x (h:t) = if f x > f h then h : insertOn f x t else x : h : t






--2
type Polinomio = [Monomio]
type Monomio = (Float,Int)

--a
selgrau :: Int -> Polinomio -> Polinomio
selgrau x  = filter (\(n,grau) -> x == grau)

--b
conta :: Int -> Polinomio -> Int
conta x p = length (selgrau x p)

--c
grau :: Polinomio -> Int 
grau p = maximum (map snd p)

--d
deriv :: Polinomio -> Polinomio
deriv p = map (\(c,g) -> (c * fromIntegral g, g-1))  (filter (\(c,g) -> g /= 0) p)

--e
calcula :: Float -> Polinomio -> Float
calcula x = foldr (\(c,g) total -> total + c*x^g) 0 

--f
simp :: Polinomio -> Polinomio
simp = filter (\(c,g) -> c /= 0) 

--g
mult :: Monomio -> Polinomio -> Polinomio
mult (c,g) = map (\(cp,gp) -> (c*cp,g+gp)) 

--h
ordena :: Polinomio -> Polinomio
ordena = sortOn snd 

--i
normaliza :: Polinomio -> Polinomio
normaliza p = map (foldr (\(c,g) (cac,gac) -> (c+cac,g+gac)) (0,0)) (groupBy (\m1 m2 -> snd m1 == snd m2) (ordena p)) 

--3
type Mat a = [[a]]

--a
dimOK :: Mat a -> Bool
dimOK = (==1).length.nub.map length 

--b
dimMat :: Mat a -> (Int,Int)
dimMat [] = (0,0)
dimMat m = (length (head m), length m)

--c
addMat :: Num a => Mat a -> Mat a -> Mat a
addMat  = zipWith (zipWith (+)) 

--d 
transpose' :: Mat a -> Mat a
transpose' l = map head l : transpose (map tail l)