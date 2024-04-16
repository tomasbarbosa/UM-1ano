module Ficha5 where
import Data.List
 
dobros l = map (2*) l
pares l = filter even l


segundos l = map (\x -> head (tail x)) l


--1

--a
any' :: (a-> Bool) -> [a] -> Bool 
any' a [] = True
any' a (h:t)
    | a h = True
    |otherwise = any' a t

--b
deleteBy' :: (a -> a -> Bool) -> a -> [a] -> [a]
deleteBy' f a [] = []
deleteBy' f a (h:t)
    | f a h = t
    | otherwise = h : deleteBy' f a t

-- funções folds
----------
 --foldr -> direita para a esquerda
 --folfl -> esq para direita
soma :: [Int] -> Int
soma l = foldr (\x acc -> x + acc) 0 l
  -- ou  
soma' :: [Int] -> Int
soma' = foldr (+) 0
-----------

--2
type  Polinomio = [Monomio]
type Monomio = (Float,Int)
 
--a 
selgrau :: Int -> Polinomio -> Polinomio
selgrau n p = filter (\(c,g) -> g == n) p

--d
deriv :: Polinomio -> Polinomio
deriv [] = []
deriv ((c,g):t)
    | g == 0 = deriv t
    | otherwise = (c * fromIntegral g, g-1) : deriv t
-- ordem superior
deriv' :: Polinomio -> Polinomio
deriv' p = [(c * fromIntegral g, g-1) | (c,g) <- p,g /= 0]

deriv'' :: Polinomio -> Polinomio
deriv'' p = map (\(c,g) -> (c * fromIntegral g, g-1)) $ filter (\(c,g) -> g /= 0) p

--e
calcula :: Float -> Polinomio -> Float
calcula _ [] = 0
calcula x ((c,g):t) = c * (x ^g) + calcula x t
-- ordem superior
calcula' :: Float -> Polinomio -> Float
calcula' x = foldr (\(c,g) acc -> acc + (c * (x ^g))) 0 

--ou
calcula'' :: Float -> Polinomio -> Float
calcula'' x = foldl (\acc (c,g) -> acc + (c * (x ^g))) 0

--3

type Mat a = [[a]]


mat_ex = [[1,2,3],[4,5,6],[7,8,9]]

--a)

dimOk :: Mat a -> Bool
dimOk m =  (== 1) $ length $ nub $ map length m

-- ou

dimOk' :: Mat a -> Bool
dimOk' [] = False
dimOk' (h:t) = all (\l -> length l == length h) t

-- ou
dimOk_feia :: Mat a -> Bool
dimOk_feia m = (length (nub (map length m)) == 1)

-- ou
dimOk_ponto :: Mat a -> Bool
dimOk_ponto m = (1 == length (nub ( map length m)))

--catMaybes (pergunta das 50q em ordem superior)

catMaybes_os :: [Maybe a] -> [a]
catMaybes_os l = foldr (\x acc -> case x of Just y -> y : acc; Nothing -> acc ) [] l

