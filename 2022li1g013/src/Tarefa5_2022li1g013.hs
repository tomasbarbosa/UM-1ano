{- |
Module      : Tarefa4_2022li1g013
Description : Determinar se o jogo terminou
Copyright   : Luís Cunha <a104613@alunos.uminho.pt>
              Tomás Barbosa <a104532@alunos.uminho.pt>

Módulo para a realização da Tarefa 5 do projeto de LI1 2022/23.
-}
module Tarefa5_2022li1g013 where
import LI12223
import Tarefa1_2022li1g013
import Tarefa2_2022li1g013

{- | A função /@__deslizaJogo__@/  é usada para adicionar uma linha ao topo do 'Mapa' e retirar a última, ajustando as 'Coordenadas' do 'Jogador'


A função pode ser definida da seguinte forma : 

@
deslizaJogo (Jogo (Jogador (x,y)) (Mapa l terr)) n  = (Jogo (Jogador (x,y+1)) (removeultimalinha (estendeMapa (Mapa l terr) n)))
@

-}
deslizaJogo :: Jogo -- ^ recebe o jogo
            -> Int -- ^ recebe o número aleatório
            -> Jogo -- ^ devolve o jogo atualizado com a linha nova
deslizaJogo (Jogo (Jogador (x,y)) (Mapa l terr)) n  = (Jogo (Jogador (x,y+1)) (removeultimalinha (estendeMapa (Mapa l terr) n)))

{- | A função /@__removeultimalinha__@/  é usada para retirar a última linha do 'Mapa' 


A função pode ser definida da seguinte forma : 

@
removeultimalinha (Mapa l terr) = (Mapa l (take (length terr - 1) terr)) 
@

-}

removeultimalinha :: Mapa -- ^ recebe o mapa
                  -> Mapa -- ^ devolve o mapa sem a última linha
removeultimalinha (Mapa l terr) = (Mapa l (take (length terr - 1) terr)) 


