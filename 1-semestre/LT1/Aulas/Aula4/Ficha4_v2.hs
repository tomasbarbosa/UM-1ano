module Ficha4_v2 where
--1) feito

--2)
--deslocaDrt :: Int -> [a] -> [a]

--3)
deslocaEsq :: Int -> [a] -> [a]
deslocaEsq _ [] = []
deslocaEsq n l@(h:t) 
            | n == 0 = (h:t)
            | n < 0 = error "n inválido"
            | otherwise = let chunk = mod n (length l) in drop chunk l ++ take chunk l

--6) 
pos :: Eq a => a -> [a] -> Int
pos m [] = -1
pos m (h:t) | m == h = 0
            | otherwise = let recCall = pos m t in
                if recCall == -1 
                    then -1
                    else 1 + recCall


