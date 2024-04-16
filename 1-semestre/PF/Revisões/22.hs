module Teste1 where

import Data.Char
import Data.List

import System.Random


--21/22

--1
zip' :: [a] -> [b] -> [(a,b)]
zip' l1 [] = []
zip' [] l2 = []
zip' (x1:y1) (x2:y2 ) = (x1,x2) : zip' y1 y2

--2
preCrescente' :: Ord a => [a] -> [a]
preCrescente' [] = []
preCrescente' [x] = [x]
preCrescente' (h:t) 
      | h < head t = h : preCrescente' t
      | otherwise = [h]

--3
amplitude :: [Int] -> Int
amplitude l = (maximum l) - (minimum l)

--4
type Mat a = [[a]]

somaM :: Num a => Mat a -> Mat a -> Mat a
somaM [] a = a
somaM a [] =  a
somaM (h:t) (x:xs) = somaAux h x : somaM t xs

somaAux :: Num a => [a] -> [a] -> [a]
somaAux [] _ = []
somaAux _ [] = []
somaAux (h:t) (x:xs) = (h+x) : somaAux t xs


--5
type Nome = String
type Telefone = Integer --        r            e       d
data Agenda = Vazia | Nodo (Nome,[Telefone]) Agenda Agenda

instance Show Agenda where
    show Vazia = ""
    show (Nodo (nome,tel) e d) = show e ++ show nome ++ " " ++ intercalate "/" (map show tel) ++ "\n" ++ show d


--6 
randomSel :: Int -> [a] -> IO [a]
randomSel _ [] = return []
randomSel 0 _ = return []
randomSel n l = do 
      randomIndex <- randomRIO (0, length l - 1)
      let randomElem = l !! randomIndex
      recur <- randomSel (n-1) (take randomIndex l ++ drop (randomIndex + 1) l)
      return (randomElem : recur)

--7
organiza :: Eq a => [a] -> [(a,[Int])]
organiza l = map (\x -> (x, elemIndices x l)) (nub l)

--8
func :: [[Int]] -> [Int]
--func l = concat (filter (\x -> sum x >10) l)

func [] = []
func (h:t)
    | sum h > 10 = h ++ func t
    | otherwise = func t

--9
data RTree a = R a [RTree a]
type Dictionary = [ RTree (Char, Maybe String) ]

d1 = [R ('c',Nothing) [
        R ('a',Nothing) [
            R ('r',Nothing) [
                R ('a',Just "...") [
                    R ('s',Just "...") [] ],
                R ('o',Just "...") [],
                R ('r',Nothing) [
                R ('o',Just "...") [] ]
     ] ] ] ]


insere :: String -> String -> Dictionary -> Dictionary
insere [x] descri dict = insereFim x descri dict
insere (h:t) descri [] = [ R (h,Nothing) (insere t descri [])]
insere (h:t) descri (R (a,b) l:d)
    | h == a = R (a,b) (insere t descri l) : d
    | otherwise = R (a,b) l : insere (h:t) descri d


insereFim :: Char -> String -> Dictionary -> Dictionary
insereFim x descri [] = [R (x,Just descri) [] ]
insereFim x descri (R (a,b) l:t)
        | x == a = R (a, Just descri) l : t
        | otherwise = R (a,b) l : insereFim x descri t
