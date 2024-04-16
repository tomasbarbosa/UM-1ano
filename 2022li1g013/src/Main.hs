{- |
Module      : Tarefa4_2022li1g013
Description : Determinar se o jogo terminou
Copyright   : Luís Cunha <a104613@alunos.uminho.pt>
              Tomás Barbosa <a104532@alunos.uminho.pt>

Módulo para a realização da Main do projeto de LI1 2022/23.
-}
module Main where

import LI12223
import Tarefa1_2022li1g013
import Tarefa2_2022li1g013
import Tarefa3_2022li1g013
import Tarefa4_2022li1g013
import Tarefa5_2022li1g013
import Tarefa6_2022li1g013
import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import System.Random


{- | A função /@__main__@/  serve para executar o Jogo


A função pode ser definida da seguinte forma : 

@
main :: IO () 
main = do 
  riop <- loadBMP "Imagens/rio.bmp"
  estradap <- loadBMP "Imagens/estrada.bmp"
  relvap <- loadBMP "Imagens/relva.bmp"
  tronco1p <- loadBMP "Imagens/tronco1.bmp"
  tronco2p <- loadBMP "Imagens/tronco2.bmp"
  carro1p <- loadBMP "Imagens/carro1.bmp"
  carro2p <- loadBMP "Imagens/carro2.bmp"
  arvorep <- loadBMP "Imagens/arvore1.bmp"
  asasfechadasp <- loadBMP "Imagens/asasfechadas.bmp"
  jogarp <- loadBMP  "Imagens/jogar.bmp"
  sairp <- loadBMP  "Imagens/sair.bmp"
  jogarbrancop <- loadBMP  "Imagens/jogarbranco.bmp"
  sairbrancop <- loadBMP  "Imagens/sairbranco.bmp"
  let images = [scale 0.5 0.5 riop,scale 0.5 0.5 estradap, scale 0.5 0.5 relvap, scale 0.5 0.5 tronco1p, scale 0.5 0.5 tronco2p, scale 0.5 0.5 carro1p, scale 0.5 0.5 carro2p, scale 0.5 0.5 arvorep, scale 0.5 0.5 asasfechadasp, scale 3 3 jogarp, scale 3 3 sairp, scale 3 3 jogarbrancop, scale 3 3 sairbrancop]
  play window background fr (initialState images) drawState event time

@
-}


main :: IO () 
main = do 
  riop <- loadBMP "Imagens/rio.bmp"
  estradap <- loadBMP "Imagens/estrada.bmp"
  relvap <- loadBMP "Imagens/relva.bmp"
  tronco1p <- loadBMP "Imagens/tronco1.bmp"
  tronco2p <- loadBMP "Imagens/tronco2.bmp"
  carro1p <- loadBMP "Imagens/carro1.bmp"
  carro2p <- loadBMP "Imagens/carro2.bmp"
  arvorep <- loadBMP "Imagens/arvore1.bmp"
  asasfechadasp <- loadBMP "Imagens/asasfechadas.bmp"
  jogarp <- loadBMP  "Imagens/jogar.bmp"
  sairp <- loadBMP  "Imagens/sair.bmp"
  jogarbrancop <- loadBMP  "Imagens/jogarbranco.bmp"
  sairbrancop <- loadBMP  "Imagens/sairbranco.bmp"
  let images = [scale 0.5 0.5 riop,scale 0.5 0.5 estradap, scale 0.5 0.5 relvap, scale 0.5 0.5 tronco1p, scale 0.5 0.5 tronco2p, scale 0.5 0.5 carro1p, scale 0.5 0.5 carro2p, scale 0.5 0.5 arvorep, scale 0.5 0.5 asasfechadasp, scale 3 3 jogarp, scale 3 3 sairp, scale 3 3 jogarbrancop, scale 3 3 sairbrancop]
  play window background fr (initialState images) drawState event time
