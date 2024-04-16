module Aula5 where

--1
enumFromTo' :: Int -> Int -> [Int] -- constrói a lista dos números inteiros compreendidos entre dois limites
enumFromTo' a b 
    | a>b = []
    | otherwise = a : enumFromTo' (a+1) b

--2
enumFromThenTo' :: Int -> Int -> Int -> [Int] -- constrói a lista dos números inteiros compreendidos entre dois limites e espaçados de um valor constante
enumFromThenTo' s n e 
      | s > e && n >= s || e>s && n<s = []
      | otherwise = s: enumFromThenTo' n (n*2 - s) e

--3
cola :: [a] -> [a] -> [a] -- concatena duas listas
cola [] b = b 
cola (h:t) b = h: cola t b

--4
selec :: [a] -> Int -> a -- dada uma lista e um inteiro, calcula o elemento da lista que se encontra nessa posição
selec (h:t) l
    | l == 0 =h
    | otherwise = selec (t) (l-1)

--5
reverse' :: [a] -> [a] -- dada uma lista calcula uma lista com os elementos dessa lista pela ordem inversa
reverse' [] = []
reverse' (h:t) = reverse' t ++ [h]