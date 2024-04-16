module Teste1920again where

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
tails' l = tails' (tail l) ++ [l]

--2
type ConjInt = [Intervalo]
type Intervalo = (Int,Int)

--a
elems :: ConjInt -> [Int]
elems [] = []
elems ((x,xs):t) = [x..xs] ++ elems t

--b
geraconj :: [Int] -> ConjInt
geraconj [] = []
geraconj [x] = [(x,x)]
geraconj (h:t) 
    | h == x-1 = (h,y) :zs
    | otherwise = (h,h) : (x,y) : zs
    where (x,y) :zs = geraconj t

--3
data Contacto = Casa Integer
              | Trab Integer
              | Tlm Integer
              | Email String
   deriving (Show)

type Nome = String
type Agenda = [(Nome, [Contacto])]

--a
acrescEmail :: Nome -> String -> Agenda -> Agenda
acrescEmail n e [] = [(n,[Email e])]
acrescEmail n e ((nome,c):t)
    | nome == n = [(nome,Email e : c)]
    | otherwise = (nome,c) : acrescEmail n e t

--b
verEmails :: Nome -> Agenda -> Maybe [String]
verEmails _ [] = Nothing
verEmails nome ((n,c):t) 
    | nome == n = Just (map (\(Email e) -> e ) (filter isEmail c))
    where isEmail (Email _) =True
          isEmail _ = False

--c
consulta :: [Contacto] -> ([Integer],[String])
consulta = foldr (\x (tel,email) -> 
                case x of Casa num -> (num : tel,email)
                          Trab num -> (num : tel,email)
                          Tlm num -> (num : tel,email)
                          Email e -> ( tel,e :email)
                             ) ([],[])


--4
data RTree a = R a [RTree a] deriving (Show, Eq)

--a
paths :: RTree a -> [[a]]
paths (R x []) = [[x]]
paths (R x t) = map (x:) (concatMap paths t)

--b
unpaths :: Eq a => [[a]] -> RTree a
unpaths [[x]] = R x []
unpaths l = R root (map unpaths $ groupBy (\a b -> head a == head b) (map tail l))
 where root = head (head l)