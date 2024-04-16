module Teste1920 where

import Data.List

--1

--a
intersect' :: Eq a => [a] -> [a] -> [a]
intersect' l [] = []
intersect' [] l = []
intersect' (h:t) l 
    | h `elem` l = h : intersect' t l
    | otherwise = intersect' t l

--b
tails' :: [a] -> [[a]]
tails' [] = [[]]
tails' l = [l] ++ tails' (tail l)

--2
type ConjInt = [Intervalo]
type Intervalo = (Int,Int)

--a
elems :: ConjInt -> [Int]
elems [] = []
elems ((x1,x2):t) = [x1..x2] ++ elems t

--b
geraconj :: [Int] -> ConjInt
geraconj [] = []
geraconj [x] = [(x,x)]
geraconj (h:t)
    | h == x-1 = (h,y):zs
    | otherwise = (h,h) : (x,y) : zs
    where (x,y):zs = geraconj t

--3
data Contacto = 
    Casa Integer
 | Trab Integer
 | Tlm Integer
 | Email String
 deriving (Show)

type Nome = String
type Agenda = [(Nome, [Contacto])]

--a
acrescEmail :: Nome -> String -> Agenda -> Agenda 
acrescEmail nome email [] = [(nome, [Email email])]
acrescEmail nome email ((n,contactos) : t)
    | nome == n = (nome, (Email email) : contactos) : t
    | otherwise = (nome,contactos) : acrescEmail nome email t

--b
verEmails :: Nome -> Agenda -> Maybe [String]
verEmails _ [] = Nothing
verEmails n ((nome,contactos) :t)
    | n == nome = Just (filtrarEmails contactos)

filtrarEmails :: [Contacto] -> [String]
filtrarEmails [] = []
filtrarEmails ((Email e):t) = e : filtrarEmails t
filtrarEmails (_:t) = filtrarEmails t

--c
consulta :: [Contacto] -> ([Integer],[String])
consulta l = (foldr (\x (tel,emails) -> 
                            case x of Casa num -> (num : tel, emails)
                                      Trab num -> (num : tel, emails)
                                      Tlm num -> (num : tel, emails)
                                      Email e -> (tel, e : emails))
             ) ([],[]) l

                                
--4
data RTree a = R a [RTree a] deriving (Show, Eq)

--a
paths :: RTree a -> [[a]]
paths (R a []) = [[a]]     
paths (R a x) = map ((:)a) (concatMap paths x)                        
                                
--b
unpaths :: Eq a => [[a]] -> RTree a 
unpaths [[x]] = R x []
unpaths l = let r = head . head $ l 
            in R r (map unpaths $ 
                    groupBy (\a b -> head a == head b)
                    $ map tail l)

