module Ficha4 where

import Data.Char (isDigit , isAlpha, intToDigit)

--1)
digitAlpha :: String -> (String,String)
digitAlpha "" = ("","")
digitAlpha (h:t)
    | isAlpha h = (h : alphas , digits)
    | isDigit h = (alphas, h : digits )
    | otherwise = (alphas, digits)
    where (alphas, digits) = digitAlpha t

--utilização de um acumulador 
soma :: [Int] -> Int
soma l = somaAux 0 l

somaAux :: Int -> [Int] -> Int
somaAux acc [] = acc
somaAux acc (h:t) = somaAux (acc + h) t
 

--4)
fromDigits :: [Int] -> Int
fromDigits l = fromDigitsAux 0 l


fromDigitsAux :: Int -> [Int] -> Int
fromDigitsAux acc [] = acc
fromDigitsAux acc (h:t) = fromDigitsAux (acc * 10 + h) t

--7)
intToStr :: Int -> String
intToStr 0 = "0"
intToStr n = intToStrAux "" n


intToStrAux :: String -> Int -> String
intToStrAux acc 0 = acc
intToStrAux acc n = intToStrAux (intToDigit r : acc) q
    where q = n `div` 10
          r = n `mod` 10

--por extenso

intToStr' :: Int -> String
intToStr' 0 = "zero"
intToStr' n = intToStrAux' "" n


intToStrAux' :: String -> Int -> String
intToStrAux' (' ':acc) 0 = acc
intToStrAux' acc n = intToStrAux' (" "  ++ intToSrtName r ++ acc) q
    where q = n `div` 10
          r = n `mod` 10

intToSrtName :: Int -> String
intToSrtName 0 = "zero"
intToSrtName 1 = "um"
intToSrtName 2 = "dois"
intToSrtName 3 = "três"
intToSrtName 4 = "quatro"
intToSrtName 5 = "cinco"
intToSrtName 6 = "seis"
intToSrtName 7 = "sete"
intToSrtName 8 = "oito"
intToSrtName 9 = "nove"


--8)

--a
--[6,12,18]
a = [x | x <- [1..20], mod x 6 == 0]

--b
--[6,12,8]
b = [x | x <- [6,12,18]]


--c
--[(10,20),(11,19),(12,18),(13,17)(,14,26),(15,15),(16,14),(17,13),(18,12),(19,11),(20,10)]

c = [(30 - y,y) | y <- [10..20]]

--d
-- [1,1,4,4,9,9,16,16,25,25]
d = [ x^2 | x <- [1..5], y <- [1..2]]

--9

--d
d9 = [replicate n 1 | n <- [1..5]]


--funçao anonima
f x = head (tail x)
-- =
f' = (\x -> head (tail x))

