module Esttrab where
 
import Data.List
import System.Random
import Data.Char

{- obstáculos inválidos

obstaculosinvalidos :: Mapa -> Bool
obstaculosinvalidos (Mapa larg []) = True
obstaculosinvalidos (Mapa larg ((Rio v, obstaculos):t) 
            | v == 0 = False
            | Carro `elem` obstaculos || Arvore `elem` obstaculos = False
            | otherwise = obstaculosinvalidos (Mapa larg t)
obstaculosinvalidos (Mapa larg ((Estrada v, obstaculos):t) 
            | v == 0 = False
            | Tronco `elem` obstaculos || Arvore `elem` obstaculos = False
            | otherwise = obstaculosinvalidos (Mapa larg t)            
obstaculosinvalidos (Mapa larg ((Relva v, obstaculos):t) 
            | v == 0 = False
            | Carro `elem` obstaculos || Tronco `elem` obstaculos = False
            | otherwise = obstaculosinvalidos (Mapa larg t)
-}

{- rios contíguos 

rioscontiguos :: Mapa -> Bool
rioscontiguos (Mapa larg []) = True
rioscontiguos (Mapa larg ((Rio v1, obstaculos):(Rio v2, obstaculos):t))
        | v1 > 0 && v2 > 0 || v1 < 0 && v2 < 0 = False
        | otherwise = rioscontiguos (Mapa larg ((Rio v2, obstaculos1):t)) 
rioscontiguos (Mapa larg ((Rio _,_ ):t)) = rioscontiguos (Mapa larg t)
rioscontiguos (Mapa larg ((Estrada _, _):t)) = rioscontiguos (Mapa larg t)
rioscontiguos (Mapa larg ((Relva,_):t)) = rioscontiguos (Mapa larg t) 

-}

{- larguraobstaculos 

larguraobstaculos :: Mapa -> Bool
larguraobstaculos (Mapa larg ((Rio v, obstaculos):t)) = contagemTroncos obstaculos 0
larguraobstaculos (Mapa larg ((Estrada v, obstaculos):t)) = contagemCarros obstaculos 0

contagemTroncos :: [Obstaculos] -> Int -> Bool
contagemTroncos _ 6 = False
contagemTroncos [] n = True
contagemTroncos (h:t) n 
    | h == Tronco = contagemTroncos t (n+1)
    | otherwise = contagemTroncos t 0

contagemCarros :: [Obstaculos] -> Int -> Bool
contagemCarros _ 4 = False
contagemCarros [] n = True
contagemCarros (h:t) n 
    | h == Carro = contagemCarros t (n+1)
    | otherwise = contagemCarros t 0


-}

{- minobstaculos

minobstaculos :: Mapa -> Bool
minobstaculos (Mapa larg []) = True
minobstaculos (Mapa larg ((Rio v, obstaculos ):t)) = Nenhum `elem` obstaculos && minobstaculos (Mapa larg t)
minobstaculos (Mapa larg ((Estrada) v, obstaculos ):t)) = Nenhum `elem` obstaculos && minobstaculos (Mapa larg t)
minobstaculos (Mapa larg ((Relva, obstaculos ):t)) = Nenhum `elem` obstaculos && minobstaculos (Mapa larg t)

-}

{- largmapa 

largmapa :: Mapa -> Bool
largmapa (Mapa larg []) = True
largmapa (Mapa larg ((Rio v , obstaculos):t)) = larg == length obstaculos && largmapa (Mapa larg t)
largmapa (Mapa larg ((Estrada v , obstaculos):t)) = larg == length obstaculos && largmapa (Mapa larg t)
largmapa (Mapa larg ((Relva , obstaculos):t)) = larg == length obstaculos && largmapa (Mapa larg t)

-}

{- maxriosestradas

maxriosestradas :: Mapa -> Bool
maxriosestradas (Mapa larg ((Rio _ , _):(Rio _ , _):(Rio _ , _):(Rio _ , _):(Rio _ , _):t)) = False 
maxriosestradas (Mapa larg ((Estrada _ , _):(Estrada _ , _):(Estrada _ , _):(Estrada _ , _):(Estrada _ , _):(Estrada _ , _):t)) = False 
maxriosestradas (Mapa larg ((Relva , _):(Relva , _):(Relva , _):(Relva , _):(Relva , _):(Relva , _):t)) = False 
maxriosestradas (Mapa larg []) = True 
maxriosestradas (Mapa larg ((Rio _, _ ):t)) = True 
maxriosestradas (Mapa larg ((Estrada _, _ ):t)) = True 
maxriosestradas (Mapa larg ((Relva, _ ):t)) = True

-}