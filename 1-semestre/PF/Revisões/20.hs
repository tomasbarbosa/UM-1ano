module Vinte where

import Data.List
import Data.Char

--1

--a)
intersect' :: Eq a => [a] -> [a] -> [a]
intersect' [] _ = []
intersect' l [] = l
intersect' (h:t) l 
    | h `elem` l = h : intersect' t l
    | otherwise = intersect' t l

--b)
tails' :: [a] -> [[a]]
tails' [] = [[]]
tails' l = l : tails (drop 1 l)

--2

--a) 

type ConjInt = [Intervalo]
type Intervalo = (Int,Int)

elems :: ConjInt -> [Int]
elems [] = []
elems ((a,b):t) = [a..b] ++ elems t


--b)
geraconj :: [Int] -> ConjInt
geraconj [] = []
geraconj (h:t) =
    case geraconj t of
        [] -> [(h,h)]
        (a,b) : r
            | a == succ h -> (h,b) : r
            | otherwise -> (h,h) : (a,b) : r

--3
data Contacto = Casa Integer
              | Trab Integer
              | Tlm Integer
              | Email String
  deriving (Show)
type Nome = String
type Agenda = [(Nome, [Contacto])]

--a)
acrescEmail :: Nome -> String -> Agenda -> Agenda
acrescEmail n email [] = [(n,[Email email])]
acrescEmail n email ((nome,c):t)
    | n == nome = (n, Email email : c) : t
    | otherwise = (n,c) : acrescEmail n email t

--b)
verEmails :: Nome -> Agenda -> Maybe [String]
verEmails nome [] = Nothing
verEmails nome ((n,c):t)
    | nome == n = Just (map (\(Email e) -> e) (filter isEmail c))
    | otherwise = verEmails nome t
    where isEmail (Email _) = True
          isEmail _ = False 

--c)
consulta :: [Contacto] -> ([Integer], [String])
consulta = foldr (\c (tlfs, emails) -> case c of 
                                        Tlm n -> (n:tlfs, emails)
                                        Casa n -> (n:tlfs,emails)
                                        Trab n -> (n:tlfs,emails)
                                        Email e -> (tlfs, e:emails)
                                      ) ([],[])

--d)
consultaIO :: Agenda -> IO ()
consultaIO a = getLine >>=
                    print
                    . maybe ([],[]) consulta
                    . flip lookup a


--4

data RTree a = R a [RTree a] deriving (Show, Eq)

--a)
paths :: RTree a -> [[a]]
paths (R a [] ) = [[a]]
paths (R a t) = map (a:) (concat (map paths t))

--b)
