 {- |
Module      : Tarefa3_2022li1g013
Description : Movimentação do personagem e obstáculos
Copyright   : Luís Cunha <a104613@alunos.uminho.pt>
              Tomás Barbosa <a104532@alunos.uminho.pt>

Módulo para a realização da Tarefa 3 do projeto de LI1 2022/23.
-}
module Tarefa3_2022li1g013 where

import LI12223

-- * Função Principal - animaJogo

{- | A função /@__animaJogo__@/  é usada para movimentar os obstáculos do terreno em que se encontram, e o personagem, de acordo com a jogada 


A função pode ser definida da seguinte forma : 

@
__animaJogo__ jogo@(Jogo (Jogador (x,y)) (Mapa l terr)) j = animaObstaculos (animaJogador jogo j) 
@

-}
animaJogo :: Jogo -- ^ argumento assume-se do tipo 'Jogo'
          -> Jogada -- ^ argumento assume-se do tipo 'Jogada'
          -> Jogo -- ^ resultado, do tipo 'Jogo'
animaJogo jogo@(Jogo (Jogador (x,y)) (Mapa l terr)) j = animaObstaculos (animaJogador jogo j)  

{- | A função /@__animaObstaculos__@/  é usada para movimentar os obstáculos do terreno em que se encontram


A função pode ser definida da seguinte forma : 

@
__animaObstaculos__ (Jogo (Jogador (x,y)) (Mapa l terr))  = Jogo (Jogador (x,y)) (Mapa l (movimentoobstaculos terr l (x,y) 0))
@

-}

animaObstaculos :: Jogo -- ^ recebe o jogo
                -> Jogo -- ^ devolve o jogo com o moviemnto dos obstáculos
animaObstaculos (Jogo (Jogador (x,y)) (Mapa l terr))  = Jogo (Jogador (x,y)) (Mapa l (movimentoobstaculos terr l (x,y) 0))
        
{- | A função /@__animaJogador__@/  é usada para movimentar a personagem, de acordo com a jogada 


A função pode ser definida da seguinte forma : 

@
__animaJogador__ (Jogo (Jogador (x,y)) (Mapa l terr)) j = Jogo (Jogador (movimentojogador (x,y) l (terr !! y) (Mapa l terr) j)) (Mapa l terr)
@

-}

animaJogador :: Jogo -- ^ recebe o jogo
             -> Jogada -- ^ recebe uma jogada
             -> Jogo -- ^ devolve o jogo com o movimento do jogador
animaJogador (Jogo (Jogador (x,y)) (Mapa l terr)) j = Jogo (Jogador (movimentojogador (x,y) l (terr !! y) (Mapa l terr) j)) (Mapa l terr)

-- * Funções auxiliares para animaJogo

-- ** movimentoobstaculos

{- | A função /@__movimentoobstaculos__@/  faz com que numa estrada ou rio com uma certa 'Velocidade', os obstáculos movem-se a essa tal velocidade no 'Jogo'


A função pode ser definida da seguinte forma : 

@
__movimentoobstaculos__ [] l (x,y) ac = []
__movimentoobstaculos__ ((Rio v, obstaculos):t) l (x,y) ac = (Rio v, (deslocaobstaculos l v obstaculos)):movimentoobstaculos t l (x,y) (ac+1)
__movimentoobstaculos__ ((Estrada v, obstaculos):t) l (x,y) ac
        | ac == y  = (Estrada v, (atropelaobstaculos l v obstaculos (x,y) 0)):movimentoobstaculos t l (x,y) (ac+1)
        | otherwise = (Estrada v, (deslocaobstaculos l v obstaculos)):movimentoobstaculos t l (x,y) (ac+1)
__movimentoobstaculos__ ((Relva, obstaculos):t) l (x,y) ac = (Relva, obstaculos):movimentoobstaculos t l (x,y) (ac+1)
@

- @funções /auxiliares/ da função@ 'movimentoobstaculos' __--->__ __'deslocaobstaculos''__ , __'deslocaobstaculos'__, __atropelaobstaculos__, __'auxdeslocaobstaculosdireita'__,  __'auxdeslocaobstaculosesquerda'__, __'auxdeslocaobstaculosdireita''__,  __'auxdeslocaobstaculosesquerda''__
-}
movimentoobstaculos :: [(Terreno,[Obstaculo])] -- ^ recebe uma lista de tuplos de terreno e lista de obstáculos
                    -> Int -- ^ recebe a largura do mapa
                    -> Coordenadas -- ^ recebe as coordenadas do jogador
                    -> Int -- ^ recebe um acumulador
                    -> [(Terreno,[Obstaculo])] -- ^ devolve uma lista de tuplos de terreno e lista de obstáculos movimentados
movimentoobstaculos [] l (x,y) ac = []
movimentoobstaculos ((Rio v, obstaculos):t) l (x,y) ac = (Rio v, (deslocaobstaculos l v obstaculos)):movimentoobstaculos t l (x,y) (ac+1)
movimentoobstaculos ((Estrada v, obstaculos):t) l (x,y) ac
        | ac == y  = (Estrada v, (atropelaobstaculos l v obstaculos (x,y) 0)):movimentoobstaculos t l (x,y) (ac+1)
        | otherwise = (Estrada v, (deslocaobstaculos l v obstaculos)):movimentoobstaculos t l (x,y) (ac+1)
movimentoobstaculos ((Relva, obstaculos):t) l (x,y) ac = (Relva, obstaculos):movimentoobstaculos t l (x,y) (ac+1)

{- |

A função pode ser definida da seguinte forma : 

@
__atropelaobstaculos__ larg v l (x,y) ac 
        | not (Carro `elem` l) = l
        | l !! x == Carro = l
        | ac == (abs v) = l
        | ac < (abs v) = atropelaobstaculos larg v (deslocaobstaculos' larg v l) (x,y) (ac+1)
@
-}

atropelaobstaculos :: Int -- ^ recebe a largura do mapa
                   -> Int -- ^ recebe a velocidade da estrada
                   -> [Obstaculo] -- ^ recebe a lista de obstáculos da estrada
                   -> Coordenadas -- ^ recebe as coordenadas do jogador
                   -> Int -- ^ recebe o acumulador
                   -> [Obstaculo] -- ^ devolve a lista de obstáculos movimentados
atropelaobstaculos larg v l (x,y) ac 
        | not (Carro `elem` l) = l
        | l !! x == Carro = l
        | ac == (abs v) = l
        | ac < (abs v) = atropelaobstaculos larg v (deslocaobstaculos' larg v l) (x,y) (ac+1)

{- |

A função pode ser definida da seguinte forma : 

@
__deslocaobstaculos'__ larg 0 l = l 
__deslocaobstaculos'__ larg v l 
        | v > 0 = auxdeslocaobstaculosdireita'  larg l 
        | otherwise = auxdeslocaobstaculosesquerda' larg l 
@
-}

deslocaobstaculos' :: Int -- ^ recebe a largura do mapa
                   -> Int -- ^ recebe a velocidade da linha
                   -> [Obstaculo] -- ^ recebe a lista de obstáculos da linha
                   -> [Obstaculo] -- ^ devolve a lista de obstáculos movimentados
deslocaobstaculos' larg 0 l = l 
deslocaobstaculos' larg v l 
        | v > 0 = auxdeslocaobstaculosdireita'  larg l 
        | otherwise = auxdeslocaobstaculosesquerda' larg l 

{- |

A função pode ser definida da seguinte forma : 

@
__auxdeslocaobstaculosdireita'__ larg l = (drop (larg-1) l) ++(take (larg-1) l)
@
-}

auxdeslocaobstaculosdireita' :: Int -- ^ recebe a velocidade da linha
                             -> [Obstaculo] -- ^ recebe a lista de obstáculos da linha
                             -> [Obstaculo] -- ^ devolve a lista de obstáculos movimentados
auxdeslocaobstaculosdireita' larg l = (drop (larg-1) l) ++ (take (larg-1) l)

{- |

A função pode ser definida da seguinte forma : 

@
__auxdeslocaobstaculosesquerda'__ larg l = (drop 1 l) ++ (take 1 l)
@
-}

auxdeslocaobstaculosesquerda' :: Int -- ^ recebe a velocidade da linha
                              -> [Obstaculo] -- ^ recebe a lista de obstáculos da linha
                              -> [Obstaculo] -- ^ devolve a lista de obstáculos movimentados
auxdeslocaobstaculosesquerda' larg l = (drop 1 l) ++ (take 1 l)
{- |

A função pode ser definida da seguinte forma : 

@
__deslocaobstaculos__ larg 0 l = l 
__deslocaobstaculos__ larg v l 
        | v > 0 = auxdeslocaobstaculosdireita  larg v l 
        | otherwise = auxdeslocaobstaculosesquerda larg (abs v) l
@
-}
deslocaobstaculos :: Int -- ^ pede uma 'Largura' do tipo Int
                  -> Int -- ^ pede uma 'Velocidade' do tipo Int
          -> [Obstaculo] -- ^ pede uma lista de obstáculos
          -> [Obstaculo] -- ^ resultado, devolve uma lista de obstáculos
deslocaobstaculos larg 0 l = l --  caso a velocidade seja 0, a lista mantém-se
deslocaobstaculos larg v l --  caso a velocidade seja v a lista move-se
        | v > 0 = auxdeslocaobstaculosdireita  larg v l --  caso a velocidade seja positiva então os obstáculos movem-se para a direita através da função auxiliar
        | otherwise = auxdeslocaobstaculosesquerda larg (abs v) l -- caso a velocidade seja negativa então os obstáculos movem-se para a esquerda através da função auxiliar

{- |

A função pode ser definida da seguinte forma : 

@
__auxdeslocaobstaculosdireita__ larg v l = (drop (larg-v) l) ++(take (larg-v) l)
@
-}
auxdeslocaobstaculosdireita :: Int -- ^ pede uma 'Largura' do tipo Int
                            -> Int -- ^ pede uma 'Velocidade' do tipo Int
                    -> [Obstaculo] -- ^ pede uma lista de obstáculos
                    -> [Obstaculo] -- ^ resultado, devolve uma lista de obstáculos
auxdeslocaobstaculosdireita larg v l = (drop (larg-v) l) ++(take (larg-v) l) -- vai deslocar a lista original para a direita "larg-v" vezes

{- |

A função pode ser definida da seguinte forma : 

@
__auxdeslocaobstaculosesquerda__ larg v l = (drop v l) ++ (take v l)
@
-}
auxdeslocaobstaculosesquerda :: Int -- ^ pede uma 'Largura' do tipo Int
                             -> Int -- ^ pede uma 'Velocidade' do tipo Int
                     -> [Obstaculo] -- ^ pede uma lista de obstáculos
                     -> [Obstaculo] -- ^ resultado, devolve uma lista de obstáculos
auxdeslocaobstaculosesquerda larg v l = (drop v l) ++ (take v l) -- vai deslocar a lista original para a esquerda "v" vezes


-- ** movimentojogador

{- | A função /@__movimentojogador__@/  faz que o jogador se movimente faça 'Move' para Cima | Baixo | Esquerda | Direita dentro do 'Jogo'

A função pode ser definida da seguinte forma : 

@
__movimentojogador__ (x,y)  l (Rio v,obstaculos) (Mapa larg terr) j 
        | x == 0 && y == 0 && 'estanumtronco' (x,y) (Rio v, obstaculos) == True && 'temarvore' (x,y) (terr !! (y+1)) == True = case j of Parado -> (x+v,y) 
                                                                                                                                         Move Direita -> (x+1,y) 
                                                                                                                                         Move Esquerda -> (x,y)
                                                                                                                                         Move Cima -> (x,y)
                                                                                                                                         Move Baixo -> (x,y)   
        | x == 0 && y == 0 && 'estanumtronco' (x,y) (Rio v, obstaculos) == True = case j of Parado -> (x+v,y) 
                                                                                            Move Direita -> (x+1,y) 
                                                                                            Move Esquerda -> (x,y)
                                                                                            Move Cima -> (x,y)
                                                                                            Move Baixo -> (x,y+1)                                                                                                                   
        | x == 0 && y == 0 && 'estanumtronco' (x,y) (Rio v, obstaculos) == False = case j of Parado -> (x+v,y) 
                                                                                             Move Cima -> (x,y) 
                                                                                             Move Baixo -> (x,y+1) 
                                                                                             Move Direita -> (x+1,y) 
                                                                                             Move Esquerda -> (x,y) 
        | x == 0 && y > 0 && 'estanumtronco' (x,y) (Rio v, obstaculos) == True && 'temarvore' (x,y) (terr !! (y+1)) == True && 'temarvore' (x,y) (terr !! (y-1)) == True = case j of Parado -> (x+v,y) 
                                                                                                                                                                                     Move Direita -> (x+1,y) 
                                                                                                                                                                                     Move Esquerda -> (x,y)
                                                                                                                                                                                     Move Cima -> (x,y)
                                                                                                                                                                                     Move Baixo -> (x,y)
        | x == 0 && y > 0 && 'estanumtronco' (x,y) (Rio v, obstaculos) == True && 'temarvore' (x,y) (terr !! (y+1)) == True = case j of Parado -> (x+v,y) 
                                                                                                                                        Move Direita -> (x+1,y) 
                                                                                                                                        Move Esquerda -> (x,y)
                                                                                                                                        Move Cima -> (x,y-1)
                                                                                                                                        Move Baixo -> (x,y) 
        | x == 0 && y > 0 && 'estanumtronco' (x,y) (Rio v, obstaculos) == True && 'temarvore' (x,y) (terr !! (y-1)) == True = case j of Parado -> (x+v,y) 
                                                                                                                                        Move Direita -> (x+1,y) 
                                                                                                                                        Move Esquerda -> (x,y)
                                                                                                                                        Move Cima -> (x,y)
                                                                                                                                        Move Baixo -> (x,y+1) 
        | x == 0 && y > 0 && 'estanumtronco' (x,y) (Rio v, obstaculos) == True = case j of Parado -> (v,y) 
                                                                                           Move Direita -> (x+1,y) 
                                                                                           Move Esquerda -> (x,y)
                                                                                           Move Cima -> (x,y-1)
                                                                                           Move Baixo -> (x,y+1)                                                                                                                                     
        | x == 0 && y > 0 && 'estanumtronco' (x,y) (Rio v, obstaculos) == False = case j of Parado -> (x,y)  
                                                                                            Move Cima -> (x,y-1) 
                                                                                            Move Baixo -> (x,y+1) 
                                                                                            Move Direita -> (x+1,y) 
                                                                                            Move Esquerda -> (x,y)
        | x > 0 && y == 0 && 'estanumtronco' (x,y) (Rio v, obstaculos) == True && 'temarvore' (x,y) (terr !! (y+1)) == True = case j of Parado -> (x+v,y) 
                                                                                                                                        Move Direita -> (x+1,y) 
                                                                                                                                        Move Esquerda -> (x-1,y)
                                                                                                                                        Move Cima -> (x,y-1)
                                                                                                                                        Move Baixo -> (x,y) 
        | x > 0 && y == 0 && 'estanumtronco' (x,y) (Rio v, obstaculos) == True = case j of Parado -> (x+v,y) 
                                                                                           Move Direita -> (x+1,y) 
                                                                                           Move Esquerda -> (x-1,y)
                                                                                           Move Cima -> (x,y)
                                                                                           Move Baixo -> (x,y+1)                                                                                                                                     
        | x > 0 && y == 0 && 'estanumtronco' (x,y) (Rio v, obstaculos) == False = case j of Parado -> (x,y)  
                                                                                            Move Cima -> (x,y-1) 
                                                                                            Move Baixo -> (x,y+1) 
                                                                                            Move Direita -> (x+1,y) 
                                                                                            Move Esquerda -> (x-1,y)        
        | x == (l-1) && y == 0 && 'estanumtronco' (x,y) (Rio v, obstaculos) == True && 'temarvore' (x,y) (terr !! (y+1)) == True = case j of Parado -> (x+v,y) 
                                                                                                                                             Move Direita -> (x,y) 
                                                                                                                                             Move Esquerda -> (x-1,y)
                                                                                                                                             Move Cima -> (x,y)
                                                                                                                                             Move Baixo -> (x,y)
        | x == (l-1) && y == 0 && 'estanumtronco' (x,y) (Rio v, obstaculos) == True = case j of Parado -> (x+v,y) 
                                                                                                Move Direita -> (x+v,y) 
                                                                                                Move Esquerda -> (x-1,y)
                                                                                                Move Cima -> (x+v,y)
                                                                                                Move Baixo -> (x,1)    
        | x == (l-1) && y == 0 && 'estanumtronco' (x,y) (Rio v, obstaculos) == False = case j of Parado -> (x,y) 
                                                                                                Move Cima -> (x,y) 
                                                                                                Move Baixo -> (x,y+1) 
                                                                                                 Move Direita -> (x+1,y) 
                                                                                                 Move Esquerda -> (x-1,y) 
        | x == (l-1) && y > 0 && 'estanumtronco' (x,y) (Rio v, obstaculos) == True && temarvore (x,y) (terr !! (y+1)) == True && temarvore (x,y) (terr !! (y-1)) == True = case j of Parado -> (x+v,y) 
                                                                                                                                                                                     Move Direita -> (x,y) 
                                                                                                                                                                                     Move Esquerda -> (x-1,y)
                                                                                                                                                                                     Move Cima -> (x,y)
                                                                                                                                                                                     Move Baixo -> (x,y)  
        | x == (l-1) && y > 0 && 'estanumtronco' (x,y) (Rio v, obstaculos) == True && 'temarvore' (x,y) (terr !! (y+1)) == True = case j of Parado -> (x+v,y) 
                                                                                                                                            Move Direita -> (x,y) 
                                                                                                                                            Move Esquerda -> (x-1,y)
                                                                                                                                            Move Cima -> (x,y-1)
                                                                                                                                            Move Baixo -> (x,y)  
        | x == (l-1) && y > 0 && 'estanumtronco' (x,y) (Rio v, obstaculos) == True && 'temarvore' (x,y) (terr !! (y-1)) == True = case j of Parado -> (x+v,y) 
                                                                                                                                            Move Direita -> (x,y) 
                                                                                                                                            Move Esquerda -> (x-1,y)
                                                                                                                                            Move Cima -> (x,y)
                                                                                                                                            Move Baixo -> (x,y+1)  
        | x == (l-1) && y > 0 && 'estanumtronco' (x,y) (Rio v, obstaculos) == True = case j of Parado -> (x+v,y) 
                                                                                               Move Direita -> (x,y) 
                                                                                               Move Esquerda -> (x-1,y)
                                                                                               Move Cima -> (x,y-1)
                                                                                               Move Baixo -> (x,y+1)    
        | x == (l-1) && y > 0 && 'estanumtronco' (x,y) (Rio v, obstaculos) == False = case j of Parado -> (x,y) 
                                                                                                Move Cima -> (x,y-1) 
                                                                                                Move Baixo -> (x,y+1) 
                                                                                                Move Direita -> (x+1,y) 
                                                                                                Move Esquerda -> (x-1,y) 
        | x > 0 && y > 0 && 'estanumtronco' (x,y) (Rio v, obstaculos) == True && 'temarvore' (x,y) (terr !! (y+1)) == True && 'temarvore' (x,y) (terr !! (y-1)) == True = case j of Parado -> (x+v,y) 
                                                                                                                                                                                    Move Direita -> (x+1,y) 
                                                                                                                                                                                    Move Esquerda -> (x-1,y)
                                                                                                                                                                                    Move Cima -> (x,y)
                                                                                                                                                                                    Move Baixo -> (x,y)
        | x > 0 && y > 0 && 'estanumtronco' (x,y) (Rio v, obstaculos) == True && 'temarvore' (x,y) (terr !! (y+1)) == True = case j of Parado -> (x+v,y) 
                                                                                                                                       Move Direita -> (x+1,y) 
                                                                                                                                       Move Esquerda -> (x-1,y)
                                                                                                                                       Move Cima -> (x,y-1)
                                                                                                                                       Move Baixo -> (x,y)  
        | x > 0 && y > 0 && 'estanumtronco' (x,y) (Rio v, obstaculos) == True && 'temarvore' (x,y) (terr !! (y-1)) == True = case j of Parado -> (x+v,y) 
                                                                                                                                       Move Direita -> (x+1,y) 
                                                                                                                                       Move Esquerda -> (x-1,y)
                                                                                                                                       Move Cima -> (x,y)
                                                                                                                                       Move Baixo -> (x,y+1)                                                                                                          
        | x > 0 && y > 0 && 'estanumtronco' (x,y) (Rio v, obstaculos) == True = case j of Parado -> (x+v,y) 
                                                                                          Move Direita -> (x+1,y) 
                                                                                          Move Esquerda -> (x-1,y)
                                                                                          Move Cima -> (x,y-1)
                                                                                          Move Baixo -> (x,y+1) 
        | x > 0 && y > 0 && estanumtronco (x,y) (Rio v, obstaculos) == False = movimentojogada (x,y) j   
__movimentojogador__ (x,y) l (Estrada _,_) (Mapa larg terr) j 
        | x == 0 && y == 0 && 'temarvore' (x,y) (terr !! (y+1)) == True = case j of Parado -> (x,y) 
                                                                                    Move Cima -> (x,y) 
                                                                                    Move Baixo -> (x,y) 
                                                                                    Move Direita -> (x+1,y) 
                                                                                    Move Esquerda -> (x,y) 
        | x == 0 && y == 0 = case j of Parado -> (0,0) 
                                       Move Cima -> (0,0) 
                                       Move Baixo -> (0,1) 
                                       Move Direita -> (1,0) 
                                       Move Esquerda -> (0,0) 
        | x == 0 && y > 0 && 'temarvore' (x,y) (terr !! (y+1)) == True && 'temarvore' (x,y) (terr !! (y-1)) == True = case j of Parado -> (x,y) 
                                                                                                                                Move Cima -> (x,y) 
                                                                                                                                Move Baixo -> (x,y) 
                                                                                                                                Move Direita -> (x+1,y) 
                                                                                                                                Move Esquerda -> (x,y) 
        | x == 0 && y > 0 && 'temarvore' (x,y) (terr !! (y+1)) == True = case j of Parado -> (x,y) 
                                                                                   Move Cima -> (x,y-1) 
                                                                                   Move Baixo -> (x,y) 
                                                                                   Move Direita -> (x+1,y) 
                                                                                   Move Esquerda -> (x,y)
        | x == 0 && y > 0 && 'temarvore' (x,y) (terr !! (y-1)) == True = case j of Parado -> (x,y) 
                                                                                   Move Cima -> (x,y) 
                                                                                   Move Baixo -> (x,y+1) 
                                                                                   Move Direita -> (x+1,y) 
                                                                                   Move Esquerda -> (x,y)
        | x == 0 && y > 0 = case j of Parado -> (x,y) 
                                      Move Cima -> (x,y-1) 
                                      Move Baixo -> (x,y+1) 
                                      Move Direita -> (x+1,y) 
                                      Move Esquerda -> (x,y) 
        | x > 0 && y == 0 && 'temarvore' (x,y) (terr !! (y+1)) == True = case j of Parado -> (x,y) 
                                                                                   Move Cima -> (x,y) 
                                                                                   Move Baixo -> (x,y) 
                                                                                   Move Direita -> (x+1,y) 
                                                                                   Move Esquerda -> (x-1,y) 
        | x > 0 && y == 0 = case j of Parado -> (x,y) 
                                      Move Cima -> (x,0) 
                                      Move Baixo -> (x,1) 
                                      Move Direita -> (x+1,0) 
                                      Move Esquerda -> (x-1,0) 
        | x == (l-1) && y == 0 && 'temarvore' (x,y) (terr !! (y+1)) == True = case j of Parado -> (x,y) 
                                                                                        Move Cima -> (x,y) 
                                                                                        Move Baixo -> (x,y) 
                                                                                        Move Direita -> (x,y) 
                                                                                        Move Esquerda -> (x-1,y)
        | x == (l-1) && y == 0 = case j of Parado -> (x,y) 
                                           Move Cima -> (x,y) 
                                           Move Baixo -> (x,y+1) 
                                           Move Direita -> (x,y) 
                                           Move Esquerda -> (x-1,y) 
        | x == (l-1) && y > 0 && 'temarvore' (x,y) (terr !! (y+1)) == True && 'temarvore' (x,y) (terr !! (y-1)) == True = case j of Parado -> (x,y) 
                                                                                                                                    Move Cima -> (x,y) 
                                                                                                                                    Move Baixo -> (x,y) 
                                                                                                                                    Move Direita -> (x,y) 
                                                                                                                                    Move Esquerda -> (x-1,y)
        | x == (l-1) && y > 0 && 'temarvore '(x,y) (terr !! (y+1)) == True = case j of Parado -> (x,y) 
                                                                                       Move Cima -> (x,y-1) 
                                                                                       Move Baixo -> (x,y) 
                                                                                       Move Direita -> (x,y) 
                                                                                       Move Esquerda -> (x-1,y) 
        | x == (l-1) && y > 0 && 'temarvore' (x,y) (terr !! (y-1)) == True = case j of Parado -> (x,y) 
                                                                                       Move Cima -> (x,y) 
                                                                                       Move Baixo -> (x,y+1) 
                                                                                       Move Direita -> (x,y) 
                                                                                       Move Esquerda -> (x-1,y)  
        | x == (l-1) && y > 0 = case j of Parado -> (x,y) -
                                          Move Cima -> (x,y-1) 
                                          Move Baixo -> (x,y+1) 
                                          Move Direita -> (x,y) 
                                          Move Esquerda -> (x-1,y)
        | x > 0 && y > 0 && 'temarvore' (x,y) (terr !! (y+1)) == True && 'temarvore' (x,y) (terr !! (y-1)) == True = case j of Parado -> (x,y) 
                                                                                                                               Move Cima -> (x,y) 
                                                                                                                               Move Baixo -> (x,y) 
                                                                                                                               Move Direita -> (x+1,y) 
                                                                                                                               Move Esquerda -> (x-1,y) 
        | x > 0 && y > 0 && 'temarvore' (x,y) (terr !! (y+1)) == True = case j of Parado -> (x,y) 
                                                                                  Move Cima -> (x,y-1) 
                                                                                  Move Baixo -> (x,y) 
                                                                                  Move Direita -> (x+1,y) 
                                                                                  Move Esquerda -> (x-1,y) 
        | x > 0 && y > 0 && 'temarvore' (x,y) (terr !! (y-1)) == True = case j of Parado -> (x,y) 
                                                                                  Move Cima -> (x,y) 
                                                                                  Move Baixo -> (x,y+1) 
                                                                                  Move Direita -> (x+1,y) 
                                                                                  Move Esquerda -> (x-1,y)  
        | otherwise = 'movimentojogada' (x,y) j 
__movimentojogador__ (x,y)  l (Relva,_) (Mapa larg terr) j 
        | x == 0 && y == 0 && 'temarvore' (x,y) (terr !! (y+1)) == True = case j of Parado -> (x,y) 
                                                                                    Move Cima -> (x,y) 
                                                                                    Move Baixo -> (x,y) 
                                                                                    Move Direita -> (x+1,y) 
                                                                                    Move Esquerda -> (x,y)  
        | x == 0 && y == 0 && 'temarvore' (x+1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                  Move Cima -> (x,y) 
                                                                                  Move Baixo -> (x,y+1) 
                                                                                  Move Direita -> (x,y) 
                                                                                  Move Esquerda -> (x,y) 
        | x == 0 && y == 0 = case j of Parado -> (x,y) 
                                       Move Cima -> (x,y) 
                                       Move Baixo -> (x,y+1) 
                                       Move Direita -> (x+1,y) 
                                       Move Esquerda -> (x,y) 
        | x == 0 && y > 0 && 'temarvore' (x,y) (terr !! (y+1)) == True && 'temarvore' (x+1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                                                              Move Cima -> (x,y-1) 
                                                                                                                              Move Baixo -> (x,y) 
                                                                                                                              Move Direita -> (x,y) 
                                                                                                                              Move Esquerda -> (x,y)
        | x == 0 && y > 0 && 'temarvore' (x,y) (terr !! (y-1)) == True && 'temarvore' (x+1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                                                              Move Cima -> (x,y) 
                                                                                                                              Move Baixo -> (x,y+1) 
                                                                                                                              Move Direita -> (x,y) 
                                                                                                                              Move Esquerda -> (x,y) 
        | x == 0 && y > 0 && 'temarvore' (x,y) (terr !! (y-1)) == True && 'temarvore' (x,y) (terr !! (y+1)) == True = case j of Parado -> (x,y) 
                                                                                                                                Move Cima -> (x,y) 
                                                                                                                                Move Baixo -> (x,y) 
                                                                                                                                Move Direita -> (x+1,y) 
                                                                                                                                Move Esquerda -> (x,y)                                                                                                                 
        | x == 0 && y > 0 && 'temarvore' (x,y) (terr !! (y+1)) == True = case j of Parado -> (x,y) 
                                                                                   Move Cima -> (x,y-1) 
                                                                                   Move Baixo -> (x,y) 
                                                                                   Move Direita -> (x+1,y) 
                                                                                   Move Esquerda -> (x,y)
        | x == 0 && y > 0 && 'temarvore' (x,y) (terr !! (y-1)) == True = case j of Parado -> (x,y) 
                                                                                   Move Cima -> (x,y) 
                                                                                   Move Baixo -> (x,y+1) 
                                                                                   Move Direita -> (x+1,y) 
                                                                                   Move Esquerda -> (x,y)  
        | x == 0 && y > 0 && 'temarvore' (x+1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                 Move Cima -> (x,y-1) 
                                                                                 Move Baixo -> (x,y+1) 
                                                                                 Move Direita -> (x,y) 
                                                                                 Move Esquerda -> (x,y)  
        | x == 0 && y > 0 = case j of Parado -> (x,y) 
                                      Move Cima -> (x,y-1) 
                                      Move Baixo -> (x,y+1) 
                                      Move Direita -> (x+1,y) 
                                      Move Esquerda -> (x,y) 
        | x > 0 && y == 0 && 'temarvore' (x-1,y) (terr !! y) && 'temarvore' (x+1,y) (terr !!y)== True = case j of Parado -> (x,y) 
                                                                                                                  Move Cima -> (x,y) 
                                                                                                                  Move Baixo -> (x,y+1) 
                                                                                                                  Move Direita -> (x,y) 
                                                                                                                  Move Esquerda -> (x,y) 
        | x > 0 && y == 0 && 'temarvore' (x-1,y) (terr !! y) && 'temarvore' (x,y) (terr !!(y+1))== True = case j of Parado -> (x,y) 
                                                                                                                    Move Cima -> (x,y) 
                                                                                                                    Move Baixo -> (x,y) 
                                                                                                                    Move Direita -> (x+1,y) 
                                                                                                                    Move Esquerda -> (x,y)
        | x > 0 && y == 0 && 'temarvore' (x+1,y) (terr !! y) && 'temarvore' (x,y) (terr !!(y+1))== True = case j of Parado -> (x,y) 
                                                                                                                    Move Cima -> (x,y) 
                                                                                                                    Move Baixo -> (x,y) 
                                                                                                                    Move Direita -> (x,y) 
                                                                                                                    Move Esquerda -> (x-1,y)                              
        | x > 0 && y == 0 && 'temarvore' (x-1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                 Move Cima -> (x,y) 
                                                                                 Move Baixo -> (x,y+1) 
                                                                                 Move Direita -> (x+1,y) 
                                                                                 Move Esquerda -> (x,y) 
        | x > 0 && y == 0 && 'temarvore' (x+1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                 Move Cima -> (x,y) 
                                                                                 Move Baixo -> (x,y+1) 
                                                                                 Move Direita -> (x,y) 
                                                                                 Move Esquerda -> (x-1,y)
        | x > 0 && y == 0 && 'temarvore' (x,y) (terr !! (y+1)) == True = case j of Parado -> (x,y) 
                                                                                   Move Cima -> (x,y) 
                                                                                   Move Baixo -> (x,y) 
                                                                                   Move Direita -> (x+1,y) 
                                                                                   Move Esquerda -> (x-1,y)
        | x > 0 && y == 0 = case j of Parado -> (x,y) 
                                      Move Cima -> (x,y) 
                                      Move Baixo -> (x,y+1) 
                                      Move Direita -> (x+1,y) 
                                      Move Esquerda -> (x-1,y) 
        | x == (l-1) && y == 0 && 'temarvore' (x,y) (terr !! (y+1)) == True = case j of Parado -> (x,y) 
                                                                                        Move Cima -> (x,y) 
                                                                                        Move Baixo -> (x,y) 
                                                                                        Move Direita -> (x,y) 
                                                                                        Move Esquerda -> (x-1,y) 
        | x == (l-1) && y == 0 && 'temarvore' (x-1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                      Move Cima -> (x,y) 
                                                                                      Move Baixo -> (x,y-1) 
                                                                                      Move Direita -> (x,y) 
                                                                                      Move Esquerda -> (x,y) 
        | x == (l-1) && y == 0 = case j of Parado -> (x,y) 
                                           Move Cima -> (x,y) 
                                           Move Baixo -> (x,y+1) 
                                           Move Direita -> (x,y) 
                                           Move Esquerda -> (x-1,y) 
         | x == (l-1) && y > 0 && 'temarvore' (x,y) (terr !! (y+1)) == True && 'temarvore' (x-1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                                                                   Move Cima -> (x,y-1) 
                                                                                                                                   Move Baixo -> (x,y) 
                                                                                                                                   Move Direita -> (x,y) 
                                                                                                                                   Move Esquerda -> (x,y)
        | x == (l-1) && y > 0 && 'temarvore' (x,y) (terr !! (y-1)) == True && 'temarvore' (x-1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                                                                  Move Cima -> (x,y) 
                                                                                                                                  Move Baixo -> (x,y+1) 
                                                                                                                                  Move Direita -> (x,y) 
                                                                                                                                  Move Esquerda -> (x,y) 
        | x == (l-1) && y > 0 && 'temarvore' (x,y) (terr !! (y-1)) == True && 'temarvore' (x,y) (terr !! (y+1)) == True = case j of Parado -> (x,y) 
                                                                                                                                    Move Cima -> (x,y) 
                                                                                                                                    Move Baixo -> (x,y) 
                                                                                                                                    Move Direita -> (x,y) 
                                                                                                                                    Move Esquerda -> (x-1,y)  
        | x == (l-1) && y > 0 && 'temarvore' (x,y) (terr !! (y+1)) == True = case j of Parado -> (x,y) 
                                                                                       Move Cima -> (x,y-1) 
                                                                                       Move Baixo -> (x,y) 
                                                                                       Move Direita -> (x,y) 
                                                                                       Move Esquerda -> (x-1,y)                                                                
        | x == (l-1) && y > 0 && 'temarvore' (x,y) (terr !! (y-1)) == True = case j of Parado -> (x,y) 
                                                                                       Move Cima -> (x,y) 
                                                                                       Move Baixo -> (x,y+1) 
                                                                                       Move Direita -> (x,y) 
                                                                                       Move Esquerda -> (x-1,y)  
        | x == (l-1) && y > 0 && 'temarvore' (x-1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                     Move Cima -> (x,y-1) 
                                                                                     Move Baixo -> (x,y+1) 
                                                                                     Move Direita -> (x,y) 
                                                                                     Move Esquerda -> (x,y)   
        | x == (l-1) && y > 0 = case j of Parado -> (x,y) 
                                          Move Cima -> (x,y-1) 
                                          Move Baixo -> (x,y+1) 
                                          Move Direita -> (x,y) 
                                          Move Esquerda -> (x-1,y) 
        | x > 0 && y > 0 && 'temarvore' (x,y) (terr !! (y+1)) == True && 'temarvore' (x+1,y) (terr !! y) == True && 'temarvore' (x-1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                                                                                                        Move Cima -> (x,y-1) 
                                                                                                                                                                        Move Baixo -> (x,y) 
                                                                                                                                                                        Move Direita -> (x,y) 
                                                                                                                                                                        Move Esquerda -> (x,y)
        | x > 0 && y > 0 && 'temarvore' (x,y) (terr !! (y-1)) == True && 'temarvore' (x+1,y) (terr !! y) == True && 'temarvore' (x-1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                                                                                                        Move Cima -> (x,y) 
                                                                                                                                                                        Move Baixo -> (x,y+1) 
                                                                                                                                                                        Move Direita -> (x,y) 
                                                                                                                                                                        Move Esquerda -> (x,y)
        | x > 0 && y > 0 && 'temarvore' (x,y) (terr !! (y+1)) == True && 'temarvore' (x,y) (terr !! (y-1)) == True && 'temarvore' (x-1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                                                                                                          Move Cima -> (x,y) 
                                                                                                                                                                          Move Baixo -> (x,y) 
                                                                                                                                                                          Move Direita -> (x+1,y)
                                                                                                                                                                          Move Esquerda -> (x,y) 
        | x > 0 && y > 0 && 'temarvore' (x,y) (terr !! (y+1)) == True && 'temarvore' (x,y) (terr !! (y-1)) == True && 'temarvore' (x+1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                                                                                                          Move Cima -> (x,y) 
                                                                                                                                                                          Move Baixo -> (x,y) 
                                                                                                                                                                          Move Direita -> (x,y) 
                                                                                                                                                                          Move Esquerda -> (x-1,y) 
        | x > 0 && y > 0 && 'temarvore' (x,y) (terr !! (y-1)) == True && 'temarvore' (x+1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                                                             Move Cima -> (x,y) 
                                                                                                                             Move Baixo -> (x,y+1) 
                                                                                                                             Move Direita -> (x,y) 
                                                                                                                             Move Esquerda -> (x-1,y) 
        | x > 0 && y > 0 && 'temarvore' (x,y) (terr !! (y-1)) == True && 'temarvore' (x-1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                                                             Move Cima -> (x,y) 
                                                                                                                             Move Baixo -> (x,y+1) 
                                                                                                                             Move Direita -> (x+1,y) 
                                                                                                                             Move Esquerda -> (x,y) 
        | x > 0 && y > 0 && 'temarvore' (x,y) (terr !! (y+1)) == True && 'temarvore' (x+1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                                                             Move Cima -> (x,y-1) 
                                                                                                                             Move Baixo -> (x,y) 
                                                                                                                             Move Direita -> (x,y) 
                                                                                                                             Move Esquerda -> (x-1,y) 
        | x > 0 && y > 0 && 'temarvore' (x,y) (terr !! (y+1)) == True && 'temarvore' (x-1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                                                             Move Cima -> (x,y-1) 
                                                                                                                             Move Baixo -> (x,y) 
                                                                                                                             Move Direita -> (x+1,y) 
                                                                                                                             Move Esquerda -> (x,y) 
        | x > 0 && y > 0 && 'temarvore' (x,y) (terr !! (y+1)) == True && 'temarvore' (x,y) (terr !! (y-1)) == True = case j of Parado -> (x,y) 
                                                                                                                               Move Cima -> (x,y) 
                                                                                                                               Move Baixo -> (x,y) 
                                                                                                                               Move Direita -> (x+1,y) 
                                                                                                                               Move Esquerda -> (x-1,y)
        | x > 0 && y > 0 && 'temarvore' (x+1,y) (terr !! y) == True && 'temarvore' (x-1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                                                           Move Cima -> (x,y-1) 
                                                                                                                           Move Baixo -> (x,y+1) 
                                                                                                                           Move Direita -> (x,y) 
                                                                                                                           Move Esquerda -> (x,y)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
        | x > 0 && y > 0 && 'temarvore' (x,y) (terr !! (y+1)) == True = case j of Parado -> (x,y) 
                                                                                  Move Cima -> (x,y-1) 
                                                                                  Move Baixo -> (x,y) 
                                                                                  Move Direita -> (x+1,y) 
                                                                                  Move Esquerda -> (x-1,y)                                                                
        | x > 0 && y > 0 && 'temarvore' (x,y) (terr !! (y-1)) == True = case j of Parado -> (x,y) 
                                                                                  Move Cima -> (x,y) 
                                                                                  Move Baixo -> (x,y+1) 
                                                                                  Move Direita -> (x+1,y) 
                                                                                  Move Esquerda -> (x-1,y) 
        | x > 0 && y > 0 && 'temarvore' (x+1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                Move Cima -> (x,y-1) 
                                                                                Move Baixo -> (x,y+1) 
                                                                                Move Direita -> (x,y) 
                                                                                Move Esquerda -> (x-1,y) 
        | x > 0 && y > 0 && 'temarvore' (x-1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                Move Cima -> (x,y-1) 
                                                                                Move Baixo -> (x,y+1) 
                                                                                Move Direita -> (x+1,y) 
                                                                                Move Esquerda -> (x,y)                                                             
        | otherwise = movimentojogada (x,y) j
@

- @funções /auxiliares/ da função@ __'movimentojogador' __--->__ __'estanumtronco'__ , __'movimentojogada'__ e __'temarvore'__

-}
movimentojogador :: Coordenadas -- ^ pede umas 'Coordenadas'
                         -> Int -- ^ pede uma 'Largura'
       -> (Terreno,[Obstaculo]) -- ^ pede uma linha de um 'Mapa'
                        -> Mapa -- ^ pede um 'Mapa'
                      -> Jogada  -- ^ pede uma 'Jogada'
                 -> Coordenadas -- ^ resultado, devolve umas 'Coordenadas'
movimentojogador (x,y)  l (Rio v,obstaculos) (Mapa larg terr) j 
        | x == 0 && y == 0 && estanumtronco (x,y) (Rio v, obstaculos) == True && temarvore (x,y) (terr !! (y+1)) == True = case j of Parado -> (x+v,y) 
                                                                                                                                     Move Direita -> (x+1,y) 
                                                                                                                                     Move Esquerda -> (x,y)
                                                                                                                                     Move Cima -> (x,y)
                                                                                                                                     Move Baixo -> (x,y)   
        | x == 0 && y == 0 && estanumtronco (x,y) (Rio v, obstaculos) == True = case j of Parado -> (x+v,y) 
                                                                                          Move Direita -> (x+1,y) 
                                                                                          Move Esquerda -> (x,y)
                                                                                          Move Cima -> (x,y)
                                                                                          Move Baixo -> (x,y+1)                                                                                                                   
        | x == 0 && y == 0 && estanumtronco (x,y) (Rio v, obstaculos) == False = case j of Parado -> (x+v,y) 
                                                                                           Move Cima -> (x,y) 
                                                                                           Move Baixo -> (x,y+1) 
                                                                                           Move Direita -> (x+1,y) 
                                                                                           Move Esquerda -> (x,y) 
        | x == 0 && y > 0 && estanumtronco (x,y) (Rio v, obstaculos) == True && temarvore (x,y) (terr !! (y+1)) == True && temarvore (x,y) (terr !! (y-1)) == True =  case j of Parado -> (x+v,y) 
                                                                                                                                                                                Move Direita -> (x+1,y) 
                                                                                                                                                                                Move Esquerda -> (x,y)
                                                                                                                                                                                Move Cima -> (x,y)
                                                                                                                                                                                Move Baixo -> (x,y)                                                                                       
        | x == 0 && y > 0 && estanumtronco (x,y) (Rio v, obstaculos) == True && temarvore (x,y) (terr !! (y+1)) == True = case j of Parado -> (x+v,y) 
                                                                                                                                    Move Direita -> (x+1,y) 
                                                                                                                                    Move Esquerda -> (x,y)
                                                                                                                                    Move Cima -> (x,y-1)
                                                                                                                                    Move Baixo -> (x,y) 
        | x == 0 && y > 0 && estanumtronco (x,y) (Rio v, obstaculos) == True && temarvore (x,y) (terr !! (y-1)) == True = case j of Parado -> (x+v,y) 
                                                                                                                                    Move Direita -> (x+1,y) 
                                                                                                                                    Move Esquerda -> (x,y)
                                                                                                                                    Move Cima -> (x,y)
                                                                                                                                    Move Baixo -> (x,y+1) 
        | x == 0 && y > 0 && estanumtronco (x,y) (Rio v, obstaculos) == True = case j of Parado -> (x+v,y) 
                                                                                         Move Direita -> (x+1,y) 
                                                                                         Move Esquerda -> (x,y)
                                                                                         Move Cima -> (x,y-1)
                                                                                         Move Baixo -> (x,y+1)                                                                                                                                     
        | x == 0 && y > 0 && estanumtronco (x,y) (Rio v, obstaculos) == False = case j of Parado -> (x,y)  
                                                                                          Move Cima -> (x,y-1) 
                                                                                          Move Baixo -> (x,y+1) 
                                                                                          Move Direita -> (x+1,y) 
                                                                                          Move Esquerda -> (x,y)
        | x > 0 && y == 0 && estanumtronco (x,y) (Rio v, obstaculos) == True && temarvore (x,y) (terr !! (y+1)) == True = case j of Parado -> (x+v,y) 
                                                                                                                                    Move Direita -> (x+1,y) 
                                                                                                                                    Move Esquerda -> (x-1,y)
                                                                                                                                    Move Cima -> (x,y-1)
                                                                                                                                    Move Baixo -> (x,y) 
        | x > 0 && y == 0 && estanumtronco (x,y) (Rio v, obstaculos) == True = case j of Parado -> (x+v,y) 
                                                                                         Move Direita -> (x+1,y) 
                                                                                         Move Esquerda -> (x-1,y)
                                                                                         Move Cima -> (x,y)
                                                                                         Move Baixo -> (x,y+1)                                                                                                                                     
        | x > 0 && y == 0 && estanumtronco (x,y) (Rio v, obstaculos) == False = case j of Parado -> (x,y)  
                                                                                          Move Cima -> (x,y-1) 
                                                                                          Move Baixo -> (x,y+1) 
                                                                                          Move Direita -> (x+1,y) 
                                                                                          Move Esquerda -> (x-1,y)        
        | x == (l-1) && y == 0 && estanumtronco (x,y) (Rio v, obstaculos) == True && temarvore (x,y) (terr !! (y+1)) == True = case j of Parado -> (x+v,y) 
                                                                                                                                         Move Direita -> (x,y) 
                                                                                                                                         Move Esquerda -> (x-1,y)
                                                                                                                                         Move Cima -> (x,y)
                                                                                                                                         Move Baixo -> (x,y)
        | x == (l-1) && y == 0 && estanumtronco (x,y) (Rio v, obstaculos) == True = case j of Parado -> (x+v,y) 
                                                                                              Move Direita -> (x+v,y) 
                                                                                              Move Esquerda -> (x-1,y)
                                                                                              Move Cima -> (x,y)
                                                                                              Move Baixo -> (x,1)    
        | x == (l-1) && y == 0 && estanumtronco (x,y) (Rio v, obstaculos) == False = case j of Parado -> (x,y) 
                                                                                               Move Cima -> (x,y) 
                                                                                               Move Baixo -> (x,y+1) 
                                                                                               Move Direita -> (x+1,y) 
                                                                                               Move Esquerda -> (x-1,y) 
        | x == (l-1) && y > 0 && estanumtronco (x,y) (Rio v, obstaculos) == True && temarvore (x,y) (terr !! (y+1)) == True && temarvore (x,y) (terr !! (y-1)) == True = case j of Parado -> (x+v,y) 
                                                                                                                                                                                   Move Direita -> (x,y) 
                                                                                                                                                                                   Move Esquerda -> (x-1,y)
                                                                                                                                                                                   Move Cima -> (x,y)
                                                                                                                                                                                   Move Baixo -> (x,y)                                                                                       
        | x == (l-1) && y > 0 && estanumtronco (x,y) (Rio v, obstaculos) == True && temarvore (x,y) (terr !! (y+1)) == True = case j of Parado -> (x+v,y) 
                                                                                                                                        Move Direita -> (x,y) 
                                                                                                                                        Move Esquerda -> (x-1,y)
                                                                                                                                        Move Cima -> (x,y-1)
                                                                                                                                        Move Baixo -> (x,y)  
        | x == (l-1) && y > 0 && estanumtronco (x,y) (Rio v, obstaculos) == True && temarvore (x,y) (terr !! (y-1)) == True = case j of Parado -> (x+v,y) 
                                                                                                                                        Move Direita -> (x,y) 
                                                                                                                                        Move Esquerda -> (x-1,y)
                                                                                                                                        Move Cima -> (x,y)
                                                                                                                                        Move Baixo -> (x,y+1)  
        | x == (l-1) && y > 0 && estanumtronco (x,y) (Rio v, obstaculos) == True = case j of Parado -> (x+v,y) 
                                                                                             Move Direita -> (x,y) 
                                                                                             Move Esquerda -> (x-1,y)
                                                                                             Move Cima -> (x,y-1)
                                                                                             Move Baixo -> (x,y+1)    
        | x == (l-1) && y > 0 && estanumtronco (x,y) (Rio v, obstaculos) == False = case j of Parado -> (x,y) 
                                                                                              Move Cima -> (x,y-1) 
                                                                                              Move Baixo -> (x,y+1) 
                                                                                              Move Direita -> (x+1,y) 
                                                                                              Move Esquerda -> (x-1,y) 
        | x > 0 && y > 0 && estanumtronco (x,y) (Rio v, obstaculos) == True && temarvore (x,y) (terr !! (y+1)) == True && temarvore (x,y) (terr !! (y-1)) == True = case j of Parado -> (x+v,y) 
                                                                                                                                                                              Move Direita -> (x+1,y) 
                                                                                                                                                                              Move Esquerda -> (x-1,y)
                                                                                                                                                                              Move Cima -> (x,y)
                                                                                                                                                                              Move Baixo -> (x,y)  
        | x > 0 && y > 0 && estanumtronco (x,y) (Rio v, obstaculos) == True && temarvore (x,y) (terr !! (y+1)) == True = case j of Parado -> (x+v,y) 
                                                                                                                                   Move Direita -> (x+1,y) 
                                                                                                                                   Move Esquerda -> (x-1,y)
                                                                                                                                   Move Cima -> (x,y-1)
                                                                                                                                   Move Baixo -> (x,y)  
        | x > 0 && y > 0 && estanumtronco (x,y) (Rio v, obstaculos) == True && temarvore (x,y) (terr !! (y-1)) == True = case j of Parado -> (x+v,y) 
                                                                                                                                   Move Direita -> (x+1,y) 
                                                                                                                                   Move Esquerda -> (x-1,y)
                                                                                                                                   Move Cima -> (x,y)
                                                                                                                                   Move Baixo -> (x,y+1)                                                                                                          
        | x > 0 && y > 0 && estanumtronco (x,y) (Rio v, obstaculos) == True = case j of Parado -> (x+v,y) 
                                                                                        Move Direita -> (x+1,y) 
                                                                                        Move Esquerda -> (x-1,y)
                                                                                        Move Cima -> (x,y-1)
                                                                                        Move Baixo -> (x,y+1)       
        | x > 0 && y > 0 && estanumtronco (x,y) (Rio v, obstaculos) == False = movimentojogada (x,y) j
movimentojogador (x,y) l (Estrada _,_) (Mapa larg terr) j 
        | x == 0 && y == 0 && temarvore (x,y) (terr !! (y+1)) == True = case j of Parado -> (x,y) 
                                                                                  Move Cima -> (x,y) 
                                                                                  Move Baixo -> (x,y) 
                                                                                  Move Direita -> (x+1,y) 
                                                                                  Move Esquerda -> (x,y) 
        | x == 0 && y == 0 = case j of Parado -> (0,0)
                                       Move Cima -> (0,0) 
                                       Move Baixo -> (0,1) 
                                       Move Direita -> (1,0) 
                                       Move Esquerda -> (0,0) 
        | x == 0 && y > 0 && temarvore (x,y) (terr !! (y+1)) == True && temarvore (x,y) (terr !! (y-1)) == True = case j of Parado -> (x,y) 
                                                                                                                            Move Cima -> (x,y) 
                                                                                                                            Move Baixo -> (x,y) 
                                                                                                                            Move Direita -> (x+1,y) 
                                                                                                                            Move Esquerda -> (x,y)                               
        | x == 0 && y > 0 && temarvore (x,y) (terr !! (y+1)) == True = case j of Parado -> (x,y) 
                                                                                 Move Cima -> (x,y-1) 
                                                                                 Move Baixo -> (x,y) 
                                                                                 Move Direita -> (x+1,y) 
                                                                                 Move Esquerda -> (x,y)
        | x == 0 && y > 0 && temarvore (x,y) (terr !! (y-1)) == True = case j of Parado -> (x,y) 
                                                                                 Move Cima -> (x,y) 
                                                                                 Move Baixo -> (x,y+1) 
                                                                                 Move Direita -> (x+1,y) 
                                                                                 Move Esquerda -> (x,y)
        | x == 0 && y > 0 = case j of Parado -> (x,y) 
                                      Move Cima -> (x,y-1) 
                                      Move Baixo -> (x,y+1) 
                                      Move Direita -> (x+1,y) 
                                      Move Esquerda -> (x,y) 
        | x > 0 && y == 0 && temarvore (x,y) (terr !! (y+1)) == True = case j of Parado -> (x,y) 
                                                                                 Move Cima -> (x,y) 
                                                                                 Move Baixo -> (x,y) 
                                                                                 Move Direita -> (x+1,y) 
                                                                                 Move Esquerda -> (x-1,y) 
        | x > 0 && y == 0 = case j of Parado -> (x,y) 
                                      Move Cima -> (x,0) 
                                      Move Baixo -> (x,1) 
                                      Move Direita -> (x+1,0) 
                                      Move Esquerda -> (x-1,0) 
        | x == (l-1) && y == 0 && temarvore (x,y) (terr !! (y+1)) == True = case j of Parado -> (x,y) 
                                                                                      Move Cima -> (x,y) 
                                                                                      Move Baixo -> (x,y) 
                                                                                      Move Direita -> (x,y) 
                                                                                      Move Esquerda -> (x-1,y)
        | x == (l-1) && y == 0 = case j of Parado -> (x,y) 
                                           Move Cima -> (x,y) 
                                           Move Baixo -> (x,y+1) 
                                           Move Direita -> (x,y) 
                                           Move Esquerda -> (x-1,y) 
        | x == (l-1) && y > 0 && temarvore (x,y) (terr !! (y+1)) == True && temarvore (x,y) (terr !! (y-1)) == True = case j of Parado -> (x,y) 
                                                                                                                                Move Cima -> (x,y) 
                                                                                                                                Move Baixo -> (x,y) 
                                                                                                                                Move Direita -> (x,y) 
                                                                                                                                Move Esquerda -> (x-1,y)
        | x == (l-1) && y > 0 && temarvore (x,y) (terr !! (y+1)) == True = case j of Parado -> (x,y) 
                                                                                     Move Cima -> (x,y-1) 
                                                                                     Move Baixo -> (x,y) 
                                                                                     Move Direita -> (x,y) 
                                                                                     Move Esquerda -> (x-1,y) 
        | x == (l-1) && y > 0 && temarvore (x,y) (terr !! (y-1)) == True = case j of Parado -> (x,y) 
                                                                                     Move Cima -> (x,y) 
                                                                                     Move Baixo -> (x,y+1) 
                                                                                     Move Direita -> (x,y) 
                                                                                     Move Esquerda -> (x-1,y)  
        | x == (l-1) && y > 0 = case j of Parado -> (x,y) 
                                          Move Cima -> (x,y-1) 
                                          Move Baixo -> (x,y+1) 
                                          Move Direita -> (x,y)
                                          Move Esquerda -> (x-1,y) 
        | x > 0 && y > 0 && temarvore (x,y) (terr !! (y+1)) == True && temarvore (x,y) (terr !! (y-1)) == True = case j of Parado -> (x,y) 
                                                                                                                           Move Cima -> (x,y) 
                                                                                                                           Move Baixo -> (x,y) 
                                                                                                                           Move Direita -> (x+1,y) 
                                                                                                                           Move Esquerda -> (x-1,y) 
        | x > 0 && y > 0 && temarvore (x,y) (terr !! (y+1)) == True = case j of Parado -> (x,y) 
                                                                                Move Cima -> (x,y-1) 
                                                                                Move Baixo -> (x,y) 
                                                                                Move Direita -> (x+1,y) 
                                                                                Move Esquerda -> (x-1,y) 
        | x > 0 && y > 0 && temarvore (x,y) (terr !! (y-1)) == True = case j of Parado -> (x,y) 
                                                                                Move Cima -> (x,y) 
                                                                                Move Baixo -> (x,y+1) 
                                                                                Move Direita -> (x+1,y) 
                                                                                Move Esquerda -> (x-1,y)  
        | otherwise = movimentojogada (x,y) j 
movimentojogador (x,y)  l (Relva,_) (Mapa larg terr) j 
        | x == 0 && y == 0 && temarvore (x,y) (terr !! (y+1)) == True = case j of Parado -> (x,y) 
                                                                                  Move Cima -> (x,y) 
                                                                                  Move Baixo -> (x,y) 
                                                                                  Move Direita -> (x+1,y) 
                                                                                  Move Esquerda -> (x,y)  
        | x == 0 && y == 0 && temarvore (x+1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                Move Cima -> (x,y) 
                                                                                Move Baixo -> (x,y+1) 
                                                                                Move Direita -> (x,y) 
                                                                                Move Esquerda -> (x,y) 
        | x == 0 && y == 0 = case j of Parado -> (x,y) 
                                       Move Cima -> (x,y) 
                                       Move Baixo -> (x,y+1) 
                                       Move Direita -> (x+1,y) 
                                       Move Esquerda -> (x,y) 
        | x == 0 && y > 0 && temarvore (x,y) (terr !! (y+1)) == True && temarvore (x+1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                                                          Move Cima -> (x,y-1) 
                                                                                                                          Move Baixo -> (x,y) 
                                                                                                                          Move Direita -> (x,y) 
                                                                                                                          Move Esquerda -> (x,y)
        | x == 0 && y > 0 && temarvore (x,y) (terr !! (y-1)) == True && temarvore (x+1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                                                          Move Cima -> (x,y) 
                                                                                                                          Move Baixo -> (x,y+1) 
                                                                                                                          Move Direita -> (x,y) 
                                                                                                                          Move Esquerda -> (x,y) 
        | x == 0 && y > 0 && temarvore (x,y) (terr !! (y-1)) == True && temarvore (x,y) (terr !! (y+1)) == True = case j of Parado -> (x,y) 
                                                                                                                            Move Cima -> (x,y) 
                                                                                                                            Move Baixo -> (x,y) 
                                                                                                                            Move Direita -> (x+1,y) 
                                                                                                                            Move Esquerda -> (x,y)                                                                                                                 
        | x == 0 && y > 0 && temarvore (x,y) (terr !! (y+1)) == True = case j of Parado -> (x,y) 
                                                                                 Move Cima -> (x,y-1) 
                                                                                 Move Baixo -> (x,y) 
                                                                                 Move Direita -> (x+1,y) 
                                                                                 Move Esquerda -> (x,y)
        | x == 0 && y > 0 && temarvore (x,y) (terr !! (y-1)) == True = case j of Parado -> (x,y) 
                                                                                 Move Cima -> (x,y) 
                                                                                 Move Baixo -> (x,y+1) 
                                                                                 Move Direita -> (x+1,y) 
                                                                                 Move Esquerda -> (x,y)  
        | x == 0 && y > 0 && temarvore (x+1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                               Move Cima -> (x,y-1) 
                                                                               Move Baixo -> (x,y+1) 
                                                                               Move Direita -> (x,y) 
                                                                               Move Esquerda -> (x,y)  
        | x == 0 && y > 0 = case j of Parado -> (x,y) 
                                      Move Cima -> (x,y-1) 
                                      Move Baixo -> (x,y+1) 
                                      Move Direita -> (x+1,y) 
                                      Move Esquerda -> (x,y) 
        | x > 0 && y == 0 && temarvore (x-1,y) (terr !! y) && temarvore (x+1,y) (terr !!y)== True = case j of Parado -> (x,y) 
                                                                                                              Move Cima -> (x,y) 
                                                                                                              Move Baixo -> (x,y+1) 
                                                                                                              Move Direita -> (x,y) 
                                                                                                              Move Esquerda -> (x,y) 
        | x > 0 && y == 0 && temarvore (x-1,y) (terr !! y) && temarvore (x,y) (terr !!(y+1))== True = case j of Parado -> (x,y) 
                                                                                                                Move Cima -> (x,y) 
                                                                                                                Move Baixo -> (x,y) 
                                                                                                                Move Direita -> (x+1,y) 
                                                                                                                Move Esquerda -> (x,y)
        | x > 0 && y == 0 && temarvore (x+1,y) (terr !! y) && temarvore (x,y) (terr !!(y+1))== True = case j of Parado -> (x,y) 
                                                                                                                Move Cima -> (x,y) 
                                                                                                                Move Baixo -> (x,y) 
                                                                                                                Move Direita -> (x,y) 
                                                                                                                Move Esquerda -> (x-1,y)                              
        | x > 0 && y == 0 && temarvore (x-1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                               Move Cima -> (x,y) 
                                                                               Move Baixo -> (x,y+1) 
                                                                               Move Direita -> (x+1,y) 
                                                                               Move Esquerda -> (x,y) 
        | x > 0 && y == 0 && temarvore (x+1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                               Move Cima -> (x,y) 
                                                                               Move Baixo -> (x,y+1) 
                                                                               Move Direita -> (x,y) 
                                                                               Move Esquerda -> (x-1,y)
        | x > 0 && y == 0 && temarvore (x,y) (terr !! (y+1)) == True = case j of Parado -> (x,y) 
                                                                                 Move Cima -> (x,y) 
                                                                                 Move Baixo -> (x,y) 
                                                                                 Move Direita -> (x+1,y) 
                                                                                 Move Esquerda -> (x-1,y)
        | x > 0 && y == 0 = case j of Parado -> (x,y) 
                                      Move Cima -> (x,y) 
                                      Move Baixo -> (x,y+1) 
                                      Move Direita -> (x+1,y) 
                                      Move Esquerda -> (x-1,y) 
        | x == (l-1) && y == 0 && temarvore (x,y) (terr !! (y+1)) == True = case j of Parado -> (x,y) 
                                                                                      Move Cima -> (x,y) 
                                                                                      Move Baixo -> (x,y) 
                                                                                      Move Direita -> (x,y) 
                                                                                      Move Esquerda -> (x-1,y) 
        | x == (l-1) && y == 0 && temarvore (x-1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                    Move Cima -> (x,y) 
                                                                                    Move Baixo -> (x,y-1) 
                                                                                    Move Direita -> (x,y) 
                                                                                    Move Esquerda -> (x,y) 
        | x == (l-1) && y == 0 = case j of Parado -> (x,y) 
                                           Move Cima -> (x,y) 
                                           Move Baixo -> (x,y+1) 
                                           Move Direita -> (x,y) 
                                           Move Esquerda -> (x-1,y) 
         | x == (l-1) && y > 0 && temarvore (x,y) (terr !! (y+1)) == True && temarvore (x-1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                                                               Move Cima -> (x,y-1) 
                                                                                                                               Move Baixo -> (x,y) 
                                                                                                                               Move Direita -> (x,y) 
                                                                                                                               Move Esquerda -> (x,y)
        | x == (l-1) && y > 0 && temarvore (x,y) (terr !! (y-1)) == True && temarvore (x-1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                                                              Move Cima -> (x,y) 
                                                                                                                              Move Baixo -> (x,y+1) 
                                                                                                                              Move Direita -> (x,y) 
                                                                                                                              Move Esquerda -> (x,y) 
        | x == (l-1) && y > 0 && temarvore (x,y) (terr !! (y-1)) == True && temarvore (x,y) (terr !! (y+1)) == True = case j of Parado -> (x,y) 
                                                                                                                                Move Cima -> (x,y) 
                                                                                                                                Move Baixo -> (x,y) 
                                                                                                                                Move Direita -> (x,y) 
                                                                                                                                Move Esquerda -> (x-1,y)  
        | x == (l-1) && y > 0 && temarvore (x,y) (terr !! (y+1)) == True = case j of Parado -> (x,y) 
                                                                                     Move Cima -> (x,y-1) 
                                                                                     Move Baixo -> (x,y) 
                                                                                     Move Direita -> (x,y) 
                                                                                     Move Esquerda -> (x-1,y)                                                                
        | x == (l-1) && y > 0 && temarvore (x,y) (terr !! (y-1)) == True = case j of Parado -> (x,y) 
                                                                                     Move Cima -> (x,y) 
                                                                                     Move Baixo -> (x,y+1) 
                                                                                     Move Direita -> (x,y) 
                                                                                     Move Esquerda -> (x-1,y)  
        | x == (l-1) && y > 0 && temarvore (x-1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                   Move Cima -> (x,y-1) 
                                                                                   Move Baixo -> (x,y+1) 
                                                                                   Move Direita -> (x,y) 
                                                                                   Move Esquerda -> (x,y)   
        | x == (l-1) && y > 0 = case j of Parado -> (x,y) 
                                          Move Cima -> (x,y-1) 
                                          Move Baixo -> (x,y+1) 
                                          Move Direita -> (x,y) 
                                          Move Esquerda -> (x-1,y) 
        | x > 0 && y > 0 && temarvore (x,y) (terr !! (y+1)) == True && temarvore (x+1,y) (terr !! y) == True && temarvore (x-1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                                                                                                  Move Cima -> (x,y-1) 
                                                                                                                                                                  Move Baixo -> (x,y) 
                                                                                                                                                                  Move Direita -> (x,y) 
                                                                                                                                                                  Move Esquerda -> (x,y)
        | x > 0 && y > 0 && temarvore (x,y) (terr !! (y-1)) == True && temarvore (x+1,y) (terr !! y) == True && temarvore (x-1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                                                                                                  Move Cima -> (x,y) 
                                                                                                                                                                  Move Baixo -> (x,y+1) 
                                                                                                                                                                  Move Direita -> (x,y) 
                                                                                                                                                                  Move Esquerda -> (x,y)
        | x > 0 && y > 0 && temarvore (x,y) (terr !! (y+1)) == True && temarvore (x,y) (terr !! (y-1)) == True && temarvore (x-1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                                                                                                    Move Cima -> (x,y) 
                                                                                                                                                                    Move Baixo -> (x,y) 
                                                                                                                                                                    Move Direita -> (x+1,y)
                                                                                                                                                                    Move Esquerda -> (x,y) 
        | x > 0 && y > 0 && temarvore (x,y) (terr !! (y+1)) == True && temarvore (x,y) (terr !! (y-1)) == True && temarvore (x+1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                                                                                                    Move Cima -> (x,y) 
                                                                                                                                                                    Move Baixo -> (x,y) 
                                                                                                                                                                    Move Direita -> (x,y) 
                                                                                                                                                                    Move Esquerda -> (x-1,y) 
        | x > 0 && y > 0 && temarvore (x,y) (terr !! (y-1)) == True && temarvore (x+1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                                                         Move Cima -> (x,y) 
                                                                                                                         Move Baixo -> (x,y+1) 
                                                                                                                         Move Direita -> (x,y) 
                                                                                                                         Move Esquerda -> (x-1,y) 
        | x > 0 && y > 0 && temarvore (x,y) (terr !! (y-1)) == True && temarvore (x-1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                                                         Move Cima -> (x,y) 
                                                                                                                         Move Baixo -> (x,y+1) 
                                                                                                                         Move Direita -> (x+1,y) 
                                                                                                                         Move Esquerda -> (x,y) 
        | x > 0 && y > 0 && temarvore (x,y) (terr !! (y+1)) == True && temarvore (x+1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                                                         Move Cima -> (x,y-1) 
                                                                                                                         Move Baixo -> (x,y) 
                                                                                                                         Move Direita -> (x,y) 
                                                                                                                         Move Esquerda -> (x-1,y) 
        | x > 0 && y > 0 && temarvore (x,y) (terr !! (y+1)) == True && temarvore (x-1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                                                         Move Cima -> (x,y-1) 
                                                                                                                         Move Baixo -> (x,y) 
                                                                                                                         Move Direita -> (x+1,y) 
                                                                                                                         Move Esquerda -> (x,y) 
        | x > 0 && y > 0 && temarvore (x,y) (terr !! (y+1)) == True && temarvore (x,y) (terr !! (y-1)) == True = case j of Parado -> (x,y) 
                                                                                                                           Move Cima -> (x,y) 
                                                                                                                           Move Baixo -> (x,y) 
                                                                                                                           Move Direita -> (x+1,y) 
                                                                                                                           Move Esquerda -> (x-1,y)
        | x > 0 && y > 0 && temarvore (x+1,y) (terr !! y) == True && temarvore (x-1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                                                                       Move Cima -> (x,y-1) 
                                                                                                                       Move Baixo -> (x,y+1) 
                                                                                                                       Move Direita -> (x,y) 
                                                                                                                       Move Esquerda -> (x,y)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
        | x > 0 && y > 0 && temarvore (x,y) (terr !! (y+1)) == True = case j of Parado -> (x,y) 
                                                                                Move Cima -> (x,y-1) 
                                                                                Move Baixo -> (x,y) 
                                                                                Move Direita -> (x+1,y) 
                                                                                Move Esquerda -> (x-1,y)                                                                
        | x > 0 && y > 0 && temarvore (x,y) (terr !! (y-1)) == True = case j of Parado -> (x,y) 
                                                                                Move Cima -> (x,y) 
                                                                                Move Baixo -> (x,y+1) 
                                                                                Move Direita -> (x+1,y) 
                                                                                Move Esquerda -> (x-1,y) 
        | x > 0 && y > 0 && temarvore (x+1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                              Move Cima -> (x,y-1) 
                                                                              Move Baixo -> (x,y+1) 
                                                                              Move Direita -> (x,y) 
                                                                              Move Esquerda -> (x-1,y) 
        | x > 0 && y > 0 && temarvore (x-1,y) (terr !! y) == True = case j of Parado -> (x,y) 
                                                                              Move Cima -> (x,y-1) 
                                                                              Move Baixo -> (x,y+1) 
                                                                              Move Direita -> (x+1,y) 
                                                                              Move Esquerda -> (x,y)                                                             
        | otherwise = movimentojogada (x,y) j

{- | A função /@__estanumtronco__@/  verifica se o 'Jogador' encontra-se em cima de um 'Tronco' dentro do 'Jogo'

A função pode ser definida da seguinte forma : 

@
__estanumtronco__ (x,y) (Rio v, obstaculos)
    | obstaculos !! x == Tronco = True 
    | otherwise = False
@
-}
estanumtronco :: Coordenadas -- ^ pede umas 'Coordenadas'
    -> (Terreno,[Obstaculo]) -- ^ pede um 'Terreno' e uma lista de Obstaculos
                     -> Bool -- ^ resultado, verifica se as Coordenadas encontram-se em cima do 'Obstaculo' tronco
estanumtronco (x,y) (Rio v, obstaculos)
    | obstaculos !! x == Tronco = True -- se a posição for a mesma posição do Tronco então devolve um Verdade
    | otherwise = False -- se não devolve um Falso

{- | A função /@__temarvore__@/  verifica se existe uma 'Árvore' numa dada posição do 'Mapa'

A função pode ser definida da seguinte forma : 

@
temarvore (x,y) (Relva, obstaculos)
        | obstaculos !! x == Arvore = True
        | otherwise = False
temarvore _ _ = False
@
-}

temarvore :: Coordenadas -- ^ recebe as coordenadas do jogador
          -> (Terreno,[Obstaculo]) -- ^ recebe um tuplo de terreno e lista de obstáculos 
          -> Bool -- ^ devolve um boolean
temarvore (x,y) (Relva, obstaculos)
        | obstaculos !! x == Arvore = True
        | otherwise = False
temarvore _ _ = False

{- | A função /@__movimentojogada__@/  move o 'Jogador' conforme a 'Jogada' feita dentro do 'Jogo'

A função pode ser definida da seguinte forma : 

@
__movimentojogada__ (x,y) j =  case j of Parado -> (x,y)
                                     Move Cima -> (x,y-1)
                                     Move Baixo -> (x,y+1)
                                     Move Direita -> (x+1,y)
                                     Move Esquerda -> (x-1,y)
@
-}
movimentojogada :: Coordenadas -- ^ pede umas 'Coordenadas'
                     -> Jogada -- ^ pede uma 'Jogada'
                -> Coordenadas -- ^ resultado, devolve umas 'Coordenadas'
movimentojogada (x,y) j =  case j of Parado -> (x,y) 
                                     Move Cima -> (x,y-1) 
                                     Move Baixo -> (x,y+1)
                                     Move Direita -> (x+1,y) 
                                     Move Esquerda -> (x-1,y) 

