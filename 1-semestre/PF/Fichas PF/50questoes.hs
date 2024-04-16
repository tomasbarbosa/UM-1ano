module FiftyQ where

import Data.List
--1)
enumFromTo' :: Int -> Int -> [Int]
enumFromTo' start end 
    | start > end = []
    | otherwise = start : enumFromTo' (start + 1) end
    
--2) 
enumFromThenTo' :: Int -> Int -> Int -> [Int]
enumFromThenTo' start next end
    | start > end && next >= start || start < end && next < start = []
    | otherwise = start : enumFromThenTo' next (2 * next - start) end

--3)
addl :: [a] -> [a] -> [a]
addl [] l = l
addl (h:t) l = h : addl t l

--4)
buscarNLista :: [a] -> Int -> a
buscarNLista (h:_) 0 = h
buscarNLista (_:t) n = buscarNLista t (n - 1)

--5)
reverse' :: [a] -> [a]
reverse' [] = []
reverse' (h:t) = reverse t ++ [h]

--6)
take' :: Int ->  [a] -> [a] 
take' _ [] = []
take' n (h:t) 
    | n <= 0 = []
    | otherwise = h : take (n-1) t

--7)
drop' :: Int -> [a] -> [a] 
drop' _ [] = []
drop' n (h:t)
    | n <= 0 = []
    | otherwise = drop' (n-1) t

--8)
zip' :: [a] -> [b] -> [(a,b)]
zip' _ [] = []
zip' [] _ = []
zip' (h:t) (h':t') = (h,h') : zip t t'

--9)
replicate' :: Int -> a -> [a]
replicate' 0 x = []
replicate' n x 
    | n <= 0 = []
    | otherwise = x : replicate' (n-1) x

--10)
intersperse' :: a -> [a] -> [a]
intersperse' a [] = []
intersperse' a [h] = [h] -- para nao acabar no numero
intersperse' a (h:t) = h : a : intersperse' a t

--11)
group' :: Eq a => [a] -> [[a]]
group' [] = []
group' [x] = [[x]]
group' (h:t)
    |elem h (head r) = (h : (head r)) : tail r
    | otherwise = [h] : r
    where r = group' t

--12)
concat' :: [[a]] -> [a]
concat' [] = []
concat' (h:t) = h ++ concat' t

--13)
inits' :: [a] -> [[a]]
inits' [] = [[]]
inits' l = inits' (init l) ++ [l]

--14)
tails' :: [a] -> [[a]]
tails' [] = [[]]
tails' l = l : tails (tail l)

--15)
heads' :: [[a]] -> [a]
heads' [] = []
heads' ([]:t) = heads' t
heads' (h:t) = head h : heads' t

--16)
total' :: [[a]] -> Int 
total' [] = 0
total' (h:t) = subTotal h + total' t
    where subTotal :: [a] -> Int
          subTotal [] = 0
          subTotal (h:t) = 1 + subTotal t

--17)
fun' :: [(a,b,c)] -> [(a,c)]
fun' [] = []
fun' ((a,b,c):t) = (a,c) : fun' t

--18)
cola' :: [(String,b,c)] -> String 
cola' [] = []
cola' ((a,b,c):t) = a ++ cola' t

--19)
idade' :: Int -> Int -> [(String,Int)] -> [String]
idade' _ _ [] = []
idade' ano idadep ((nome,nasc):t)
    | ano - nasc >= idadep = nome : idade' ano idadep t
    | otherwise = idade'  ano idadep t

--20)
powerEnumFrom' :: Int -> Int -> [Int]
powerEnumFrom' n 1 = [1]
powerEnumFrom n m
    | m > 1 = powerEnumFrom' n (m-1) ++ [n^(m-1)]
    | otherwise = []

--21)
isPrime' :: Int -> Bool
isPrime' n 
    | n >=2 = primeCheck n 2

primeCheck :: Int -> Int ->Bool
primeCheck n m
    | m * m > n = True
    | mod n m == 0 = False
    | otherwise = primeCheck n (m + 1)

--22)

isPrefixOf' :: Eq a => [a] -> [a] -> Bool
isPrefixOf' [] _ = True
isPrefixOf' _ [] = False
isPrefixOf' (h:t) (x:xs) = h == x && isPrefixOf' t xs

    