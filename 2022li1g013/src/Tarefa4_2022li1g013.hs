{- |
Module      : Tarefa4_2022li1g013
Description : Determinar se o jogo terminou
Copyright   : Luís Cunha <a104613@alunos.uminho.pt>
              Tomás Barbosa <a104532@alunos.uminho.pt>

Módulo para a realização da Tarefa 4 do projeto de LI1 em 2022/23.
-}
module Tarefa4_2022li1g013 where

import LI12223

{- | A função /@__jogoTerminou__@/  é usada para verificar se o 'Jogo' terminou devido ao 'Jogador' estar fora do 'Mapa', ter caído na Água ou estar debaixo de um 'Carro'


A função pode ser definida da seguinte forma : 

@
__jogoTerminou__ (Jogo (Jogador (x,y)) (Mapa l terr)) 
    | x < 0 || x >= l || y < 0 || y >= length terr = True 
    | otherwise = 'caiunaagua' (x,y) (terr !! y) || 'debaixodecarro' (x,y) (terr !! y) 
@

-}
jogoTerminou :: Jogo -- ^ recebe o jogo
             -> Bool -- ^ devolve um boolean
jogoTerminou (Jogo (Jogador (x,y)) (Mapa l terr)) 
    | x < 0 || x >= l || y < 0 || y >= length terr = True -- verifica se o jogador se encontra dentro do mapa
    | otherwise = caiunaagua (x,y) (terr !! y) || debaixodecarro (x,y) (terr !! y) -- verifica se o jogador está na agua ou debaixo de um carro

{- | A função /@__caiunaagua__@/  é usada para verificar se o 'Jogador' caiu na Água


A função pode ser definida da seguinte forma : 

@
__caiunaagua__ (x,y) (Rio v, obstaculos)
    | obstaculos !! x == Nenhum = True
    | otherwise = False
__caiunaagua__ _ _ = False
@

-}

caiunaagua :: Coordenadas -- ^ recebe as coordenadas do jogador
           -> (Terreno,[Obstaculo]) -- ^ recebe um tuplo de terreno e lista de obstáculos
           -> Bool -- ^ devolve um boolean
caiunaagua (x,y) (Rio v, obstaculos)
    | obstaculos !! x == Nenhum = True
    | otherwise = False
caiunaagua _ _ = False

{- | A função /@__debaixodecarro__@/  é usada para verificar se o 'Jogo' terminou devido ao 'Jogador' estar debaixo de um 'Carro'


A função pode ser definida da seguinte forma : 

@
__debaixodecarro__ (x,y) (Estrada v, obstaculos) 
    | obstaculos !! x == Carro = True
    | otherwise = False
__debaixodecarro__ _ _ = False
@

-}

debaixodecarro :: Coordenadas -- ^ recebe as coordenadas do jogador
               -> (Terreno,[Obstaculo]) -- ^ recebe um tuplo de terreno e lista de obstáculos
               -> Bool -- ^ devolve um boolean
debaixodecarro (x,y) (Estrada v, obstaculos) 
    | obstaculos !! x == Carro = True
    | otherwise = False
debaixodecarro _ _ = False


