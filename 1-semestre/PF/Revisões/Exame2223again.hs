module Exame2223again where

import Data.List

--1
unlines' :: [String] -> String
unlines' [] = ""
unlines' [x] = x
unlines' (h:t) = h ++ "\n" ++ unlines' t

--2
type Mat = [[Int]]

--a
stringToMat :: String -> Mat
stringToMat s = map stringToVector (lines s)

stringToVector :: String -> [Int]
stringToVector "" = [] -- caso de paragem
stringToVector s = 
    case span (/= ',') s of -- a função (span (/= ',') s) vai devolver uma lista de (takeWhile (/= ',') s, dropWhile (/= ',') s)
                (a, "") -> [read a] -- caso a string só tenha um elemento então devolve a mesma
                (a,b) -> read a : stringToVector (tail b) -- se tiver mais que um então vai chamar um a um, tirando a ',' da lista

-- por exemplo se tens "1,2,3" ele vai fazer span e vai devolver ("1",",2,3") 
-- depois devolve o 1 : a tail de b, ou seja, vai fazer o mesmo mas desta vez para "2,3" (pq tira a head dessa lista que é a ',')

--b
transposta :: String -> String 
transposta s = (unlines.map (intercalate "," . vectorToString).mtransposta.stringToMat) s

vectorToString :: [Int] -> [String]
vectorToString [] = []
vectorToString (h:t) = show h : vectorToString t

mtransposta :: Mat -> Mat
mtransposta [] = []
mtransposta ([]:_) = []
mtransposta m = map head m : mtransposta (map tail m)

{-
para explicar é melhor pegar num exemplo tipo "2,3\n4,6"
primeiro vamos converter a string para uma matriz fazendo stringToMat, que vai devolver [[2,3],[4,6]]
depois famos fazer a mtransposta dela, que devolve [[2,4],[3,6]]
agora queremos voltar a colocar em string, para isso temos de converter os numeros Int em caracteres, sendo necessário fazer show, ou seja para todos os elementos fazemos map show
para ficarem separados por ',' colocamos intercalate ";" e no fim fazemos unlines para dar as linhas separadas por um "\n"
-}

--3
data Lista a = Esq a (Lista a) | Dir (Lista a) a | Nula

--a
semUltimo :: Lista a -> Lista a
semUltimo Nula = Nula
semUltimo (Esq a Nula) = Esq a Nula
semUltimo (Esq a x) = Esq a x
semUltimo (Dir Nula a) =  Dir Nula a
semUltimo (Dir x a) = x

--b
instance (Show a) => Show (Lista a) where

 show l = "[" ++ showAux l ++ "]"
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
inorder (Node r e d) = inorder e ++ (r:inorder d)

--a

numera :: BTree a -> BTree (a,Int)
numera = snd.numeraAux 0 

numeraAux :: Int -> BTree a -> (Int,BTree(a,Int))
numeraAux _ Empty = (0,Empty)
numeraAux n (Node x l r) = (novo_n+n_dir, Node (x,novo_n) novo_l novo_r)
    where (n_esq, novo_l) = numeraAux n l
          novo_n = n_esq + n +1
          (n_dir, novo_r) = numeraAux novo_n r

--b

unInorder :: [a] -> [BTree a]
unInorder [] = [Empty]
unInorder xs = [Node x e d | (es,x,ds) <- splits xs,
                             e <- unInorder es,
                             d <- unInorder ds ]

splits :: [a] -> [([a],a,[a])]
splits xs = [(take i xs, xs !! i, tail (drop i xs)) | i <- [0..length xs - 1]]
