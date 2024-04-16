module T2223 where

import Data.List


--1
unlines' :: [String] -> String
unlines' [] = ""
unlines' [x] = x
unlines' (h:t) = h ++ "\n" ++ unlines' t

--2
--a
type Mat = [[Int]]

stringToMat :: String -> Mat
stringToMat s = map stringToVector (lines s)

stringToVector :: String -> [Int]
stringToVector "" = []
stringToVector s = 
    case span (/= ',') s of
              (a,"") -> [read a]
              (a,b) -> read a : stringToVector (tail b)

--b
transposta :: String -> String
transposta "" = ""
transposta s = unlines.map (intercalate "," . map show).transpose.stringToMat $ s

--3
--b
data Lista a = Esq a (Lista a) | Dir (Lista a) a | Nula

instance Show a => Show (Lista a) where
    show l  = "[" ++ showAux l ++ "]"
     where 
        showAux Nula = ""
        showAux (Esq a Nula) = show a
        showAux (Esq a l) = show a ++ "," ++ showAux l
        showAux (Dir Nula a) = show a
        showAux (Dir l a) = showAux l ++ "," ++ show a  

--4
data BTree a = Empty | Node a (BTree a) (BTree a)

inorder :: BTree a -> [a]
inorder Empty = []
inorder (Node r e d) = (inorder e) ++ (r:inorder d)

numera :: BTree a -> BTree (a,Int)
numera = snd . numeraAux 0

numeraAux :: Int -> BTree a -> (Int,BTree (a,Int))
numeraAux _ Empty = (0,Empty)
numeraAux n (Node e l r) = (novo_n + n_dir, Node (e,novo_n) novo_l novo_r)
        where (n_esq,novo_l) = numeraAux n l
              novo_n = n_esq +n +1
              (n_dir,novo_r) = numeraAux novo_n r

--b
unInorder :: [a] -> [BTree a] 
unInorder [] = [Empty]
unInorder xs = [Node x e d | (es,x,ds) <- splits xs,
                                    e <- unInorder es,
                                    d <- unInorder ds]
        where 
            splits :: [a] -> [([a],a,[a])]
            splits xs = [(take i xs, xs !! i, tail (drop i xs)) | i <- [0..length xs-1]]


amplitude :: [Int] -> Int
amplitude [] = 0
amplitude l = uncurry (-).foldr (\x (vMax,vMin) -> (max x vMax, min x vMin)) (head l,head l) $ l

--5
type Nome = String
type Telefone = Integer
data Agenda = Vazia | Nodo (Nome,[Telefone]) Agenda Agenda

instance Show Agenda where
  show Vazia = ""
  show (Nodo (nome,tel) e d) = show e ++ nome ++ ":" ++ intercalate "/" (map show tel) ++ "\n" ++ show d

--7
organiza :: Eq a => [a] -> [(a,[Int])]
organiza l = [(x,elemIndices x l) | x <- nub l]

--8
func :: [[Int]] -> [Int]
func [] = []
func (h:t) 
    | sum h > 10 = h ++ func t
    | otherwise = func t


data RTree a = R a [RTree a]
type Dictionary = [ RTree (Char, Maybe String) ]

insere :: String -> String -> Dictionary -> Dictionary
insere [x] desc dict = insereFim x desc dict
insere (h:t) desc [] = [R (h, Nothing) (insere t desc [])]
insere (h:t) desc (R (a,b) lseg:dicr)
    | h == a = R (a,b) (insere t desc lseg) : dicr
    | otherwise = R (a,b) lseg : insere (h:t) desc dicr

insereFim :: Char -> String -> Dictionary -> Dictionary
insereFim x desc [] = [R (x, Just desc) []]
insereFim x desc (R (a,b) l:t)
    | x == a = R (a,Just desc) l : t
    | otherwise = R (a,b) l : insereFim x desc t

--7
subseqSum :: [Int] -> Int -> Bool
subseqSum [] _ = False
subseqSum l x = any ((==x).sum) (inits l) || subseqSum (tail l) x

inits' :: [a] -> [a]
inits' [] = []
inits' l = inits' (init l) ++ l