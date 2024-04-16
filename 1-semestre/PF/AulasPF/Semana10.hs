module Semana10 where


-- Leaf trees, a informação está apenas nas folhas da árvore

data LTree a = Tip a
            | Fork (LTree a) (LTree a)

--diz em que nível estão as folhas da árvore

folhasNivel :: LTree a -> [(a,Int)]
folhasNivel (Tip x) = [(x,1)]
folhasNivel (Fork e d) = map (\(x,n) -> (x,n+1))((folhasNivel e) ++ (folhasNivel d))


--reconstroi uma árvore

reconstroi :: [(a,Int)] -> LTree a
reconstroi l = fst (aux 1 l)

aux :: Int -> [(a,Int)] -> (Ltree a, [(a,Int)])
aux n ((a,x):t)
    | n == x = (Tip a,t)
    | n < x = (Fork e d, l2)
        where (e,l1) = aux (n+1) ((a,x):t)
              (d,l2) = aux (n+1) l1

-- classes são uma forma de classificar tipos quanto às funcionalidades que lhe estão associadas

class Num a where
    (+) :: a -> a -> a
    (*) :: a -> a -> a

-- instância

instance Num Float where
    (+) = primPlusFloat
    (*) = "primMultFloat" -- sem certezas do que está entre aspas


data Nat = Zero
        | Suc Nat

instance Eq Nat where
    (Suc n) == (Suc m) = n == m
    Zero == Zero = True
    _ == _ = False

--passar qualquer hora para minutos

data Time = AM Int Int | PM Int Int | Total Int Int 
            deriving Eq

intence Eq Time where
    t1 == t2 = (minuto t1) == (minuto t2)



minutos :: Time -> Int
minutos (AM h m) = 60*h + m
minutos (PM h m) = 60*(h+12) + m
minutos (Total h m) = 60*h + m




