module Tarefa4_2022li1g013_Spec where

import LI12223
import Tarefa4_2022li1g013
import Test.HUnit

testsT4 :: Test
testsT4 = test ["jogoTerminou" ~: True ~=? jogoTerminou (Jogo (Jogador (-1,0)) (Mapa 4 [(Rio 2, [Nenhum,Tronco,Nenhum,Nenhum])])),
                "jogoTerminou" ~: True ~=? jogoTerminou (Jogo (Jogador (4,0)) (Mapa 4 [(Rio 2, [Nenhum,Tronco,Nenhum,Nenhum])])),
                "jogoTerminou" ~: True ~=? jogoTerminou (Jogo (Jogador (2,-3)) (Mapa 4 [(Rio 2, [Nenhum,Tronco,Nenhum,Nenhum])])),
                "jogoTerminou" ~: True ~=? jogoTerminou (Jogo (Jogador (4,5)) (Mapa 4 [(Rio 2, [Nenhum,Tronco,Nenhum,Nenhum])])),
                "jogoTerminou" ~: True ~=? jogoTerminou (Jogo (Jogador (3,0)) (Mapa 4 [(Rio 2, [Nenhum,Tronco,Nenhum,Nenhum])])),
                "jogoTerminou" ~: True ~=? jogoTerminou (Jogo (Jogador (2,0)) (Mapa 4 [(Estrada 2, [Nenhum,Carro,Carro,Nenhum])])),
                "jogoTerminou" ~: False ~=? jogoTerminou (Jogo (Jogador (0,0)) (Mapa 4 [(Estrada 2, [Nenhum,Carro,Nenhum,Nenhum])])),
                "jogoTerminou" ~: False ~=? jogoTerminou (Jogo (Jogador (1,1)) (Mapa 4 [(Estrada 2, [Nenhum,Carro,Carro,Nenhum]), (Rio 2, [Nenhum,Tronco,Nenhum,Nenhum])])),
                "caiunaagua" ~: True ~=? caiunaagua  (2,0) (Rio 3, [Nenhum,Tronco,Nenhum,Nenhum]),
                "caiunaagua" ~: False ~=? caiunaagua  (1,0) (Rio (-3), [Nenhum,Tronco,Nenhum,Nenhum]),
                "caiunaagua" ~: False ~=? caiunaagua  (1,0) (Estrada 3, [Nenhum,Carro,Nenhum,Nenhum]),
                "debaixodecarro" ~: True ~=? debaixodecarro  (1,0) (Estrada 3, [Nenhum,Carro,Nenhum,Nenhum]),
                "debaixodecarro" ~: False ~=? debaixodecarro  (3,0) (Estrada 2, [Nenhum,Carro,Nenhum,Nenhum]),
                "debaixodecarro" ~: False ~=? debaixodecarro  (1,0) (Relva, [Nenhum,Arvore,Nenhum,Nenhum])
               ]
