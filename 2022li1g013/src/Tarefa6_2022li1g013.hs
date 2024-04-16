{- |
Module      : Tarefa4_2022li1g013
Description : Determinar se o jogo terminou
Copyright   : Luís Cunha <a104613@alunos.uminho.pt>
              Tomás Barbosa <a104532@alunos.uminho.pt>

Módulo para a realização da Tarefa 6 do projeto de LI1 2022/23.
-}
module Tarefa6_2022li1g013 where

import LI12223
import Tarefa2_2022li1g013
import Tarefa3_2022li1g013
import Tarefa4_2022li1g013
import Tarefa5_2022li1g013
import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import System.Random

-- | Valor que diferencia se se quer Jogar ou Sair
data Opcao = Jogar
           | Sair

{- | Diferentes Menus do jogo

O Menu Opcoes é o que aparece quando se entra no jogo, o Menu ModoJogo é o menu quando se está a jogar e o Menu PerdeuJogo é o Menu de quando se perde o jogo
-}
data Menu = Opcoes Opcao
          | ModoJogo 
          | PerdeuJogo Opcao

-- | Diferentes superfícies do jogo
data Tile = RioT | RelvaT | EstradaT | Carro1T |Carro2T | ArvoreT | Tronco1T | Tronco2T
  deriving (Show,Eq)

-- | Lista de números usados para a aleatoriedade do jogo
type Numeros = [Int]

-- | Score do jogo que aumenta 1 ponto sempre que o jogador avança uma linha nova do mapa
type Score = Int

-- | Número auxiliar para o funcionamento correto do Score
type Saux = Int

-- | Número auxiliar para a função 'time'
type Naux = Int

-- | Lista de imagens importadas
type Images = [Picture]

-- | Conjunto de todas as outras variáveis que forma a variável conjunta World
data World = World 
    {menu :: Menu -- ^ Menu atual do jogo
    , numeros :: Numeros -- ^ Lista de números usada para a eleatoriedade do jogo
    , jogo :: Jogo -- ^ Jogo
    , score :: Score -- ^ Score do Jogo
    , saux :: Saux -- ^ Auxiliar para o Score funcionar 
    , naux :: Naux -- ^ Auxiliar para a função Time
    , images :: Images} -- ^ Conjunto das imagens importadas

{- | A função /@__initialState__@/  serve para definir o estado inicial do World


A função pode ser definida da seguinte forma : 

@
initialState images = (World (Opcoes Jogar) (drop 11 (randomRs (1, 100) (mkStdGen 2021))) (Jogo (Jogador (5,14)) (Mapa 11 ('criarmapa' 11 15 [] (head (drop 11 (randomRs (1, 100) (mkStdGen 2021)))) 0))) 0 0 0 images)  
@

-}
initialState :: Images -- ^ recebe Imagens
             -> World -- ^ devolve um mundo do jogo
initialState images = (World (Opcoes Jogar) (drop 11 (randomRs (1, 100) (mkStdGen 2021))) (Jogo (Jogador (5,14)) (Mapa 11 (criarmapa 11 15 [] (head (drop 11 (randomRs (1, 100) (mkStdGen 2021)))) 0))) 0 0 0 images)  
  
{- | A função /@__drawState__@/  serve para modificar o estado do World


A função pode ser definida da seguinte forma : 

@
drawState (World (PerdeuJogo Jogar) _ _ score _ _ images) = Pictures [Translate (-100) (100)$ Color red $ 'drawOption' ("Score: "++(show score)) ,Translate (-200) 200 $ Color red $ Text "Perdeu", Translate 50 (-50) $ (images !! 11) , Translate 50 (-250) $ (images !! 10)]
drawState (World (PerdeuJogo Sair) _ _ score _ _ images) = Pictures [Translate (-100) (100)$ Color red $ 'drawOption' ("Score: "++(show score)) ,Translate (-200) 200 $ Color red $ Text "Perdeu", Translate 50 (-50) $ (images !! 9), Color blue $ Translate 50 (-250) $ (images !! 12)]
drawState (World (Opcoes Jogar) _ _ _ _ _ images) = Pictures [Translate 50 50 $ (images !! 11), Translate 50 (-150) $ (images !! 10)]
drawState (World (Opcoes Sair) _ _ _ _ _ images) = Pictures [Translate 50 50 $ (images !! 9), Translate 50 (-150) $ (images !! 12)]
drawState (World ModoJogo numeros (Jogo (Jogador(x, y)) (Mapa l terr)) score _ _ images) = Pictures [(translate (-250) 375 ('drawGrid' 50 ('mapatotilelist' terr) images) ), (translate (-250) 375 (translate (fromIntegral(x*50)) (fromIntegral(y*(-50))) (images !! 8))), (translate 50 150 ('showScore' score))]
@

-}
drawState :: World -- ^ recebe um mundo do jogo
          -> Picture -- ^ devolve a parte gráfica do jogo
drawState (World (PerdeuJogo Jogar) _ _ score _ _ images) = Pictures [Translate (-100) (100)$ Color red $ drawScore ("Score: "++(show score)) ,Translate (-200) 200 $ Color red $ Text "Perdeu", Translate 50 (-50) $ (images !! 11) , Translate 50 (-250) $ (images !! 10)]
drawState (World (PerdeuJogo Sair) _ _ score _ _ images) = Pictures [Translate (-100) (100)$ Color red $ drawScore ("Score: "++(show score)) ,Translate (-200) 200 $ Color red $ Text "Perdeu", Translate 50 (-50) $ (images !! 9), Color blue $ Translate 50 (-250) $ (images !! 12)]
drawState (World (Opcoes Jogar) _ _ _ _ _ images) = Pictures [Translate 50 50 $ (images !! 11), Translate 50 (-150) $ (images !! 10)]
drawState (World (Opcoes Sair) _ _ _ _ _ images) = Pictures [Translate 50 50 $ (images !! 9), Translate 50 (-150) $ (images !! 12)]
drawState (World ModoJogo numeros (Jogo (Jogador(x, y)) (Mapa l terr)) score _ _ images) = Pictures [(translate (-250) 375 (drawGrid 50 (mapatotilelist terr) images) ), (translate (-250) 375 (translate (fromIntegral(x*50)) (fromIntegral(y*(-50))) (images !! 8))), (translate 50 150 (showScore score))]

{- | A função /@__drawScore__@/  serve para escrever o Score no Menu PerdeuJogo


A função pode ser definida da seguinte forma : 

@
drawScore option = Translate (-50) 0 $ Scale (0.5) (0.5) $ Text option
@

-}
drawScore option = Translate (-50) 0 $ Scale (0.5) (0.5) $ Text option

{- | A função /@__showScore__@/  serve para desenhar o Score durante o jogo


A função pode ser definida da seguinte forma : 

@
showScore n = translate 150 150$ scale 0.2 0.2 $ color white $ Text (show n)
@

-}

showScore:: Int -- ^ recebe o score (número)
         -> Picture -- ^ devolve a imagem dos score no mapa
showScore n = translate 150 150$ scale 0.2 0.2 $ color white $ Text (show n) 

{- | A função /@__event__@/  serve modificar o estado do World conforme se vão premindo teclas


A função pode ser definida da seguinte forma : 

@
event (EventKey (SpecialKey KeyEnter) Down _ _) (World (Opcoes Jogar) numeros jogo score saux naux images) = (World ModoJogo numeros jogo score saux naux images)
event (EventKey (SpecialKey KeyUp) Down _ _) (World (Opcoes Jogar) numeros jogo score saux naux images)= (World (Opcoes Sair) numeros jogo score saux naux images) 
event (EventKey (SpecialKey KeyDown) Down _ _) (World (Opcoes Jogar) numeros jogo score saux naux images) = (World (Opcoes Sair) numeros jogo score saux naux images)
event (EventKey (SpecialKey KeyUp) Down _ _) (World (Opcoes Sair) numeros jogo score saux naux images) = (World (Opcoes Jogar)  numeros jogo score saux naux images)
event (EventKey (SpecialKey KeyDown) Down _ _) (World (Opcoes Sair) numeros jogo score saux naux images)  = (World (Opcoes Jogar) numeros jogo score saux naux images)
event (EventKey (SpecialKey KeyEnter) Down _ _) (World (Opcoes Sair) _ _ _ _ _ _) = error "Fim de Jogo"
event (EventKey (SpecialKey KeyUp) Down _ _) (World ModoJogo numeros j@(Jogo (Jogador (x,y)) (Mapa l terr)) score saux naux images) 
  | 'jogoTerminou' j == True = (World (PerdeuJogo Jogar) numeros j score saux naux images)
  | score == saux = (World ModoJogo numeros ('animaJogador' j (Move Cima)) (score+1) (saux+1) naux images)
  | otherwise = (World ModoJogo numeros ('animaJogador' j (Move Cima)) score (saux+1) naux images)
event (EventKey (SpecialKey KeyDown) Down _ _) (World ModoJogo numeros j@(Jogo (Jogador (x,y)) (Mapa l terr)) score saux naux images) 
  | 'jogoTerminou' j == True = (World (PerdeuJogo Jogar) numeros j score saux naux images)
  | otherwise = (World ModoJogo numeros ('animaJogador' j (Move Baixo)) score (saux-1) naux images)
event (EventKey (SpecialKey KeyRight) Down _ _) (World ModoJogo numeros j@(Jogo (Jogador (x,y)) (Mapa l terr)) score saux naux images) 
  | 'jogoTerminou' j == True = (World (PerdeuJogo Jogar) numeros j score saux naux images)
  | otherwise = (World ModoJogo numeros ('animaJogador' j (Move Direita)) score saux naux images)
event (EventKey (SpecialKey KeyLeft) Down _ _) (World ModoJogo numeros j@(Jogo (Jogador (x,y)) (Mapa l terr)) score saux naux images) 
  | 'jogoTerminou' j == True = (World (PerdeuJogo Jogar) numeros j score saux naux images)
  | otherwise = (World ModoJogo numeros ('animaJogador' j (Move Esquerda)) score saux naux images)
event (EventKey (SpecialKey KeyUp) Down _ _) (World (PerdeuJogo Jogar) numeros jogo score saux naux images) = (World (PerdeuJogo Sair) numeros jogo score saux naux images)
event (EventKey (SpecialKey KeyDown) Down _ _) (World (PerdeuJogo Jogar) numeros jogo score saux naux images) = (World (PerdeuJogo Sair) numeros jogo score saux naux images)
event (EventKey (SpecialKey KeyUp) Down _ _) (World (PerdeuJogo Sair) numeros jogo score saux naux images) = (World (PerdeuJogo Jogar) numeros jogo score saux naux images)
event (EventKey (SpecialKey KeyDown) Down _ _) (World (PerdeuJogo Sair) numeros jogo score saux naux images) = (World (PerdeuJogo Jogar) numeros jogo score saux naux images)
event (EventKey (SpecialKey KeyEnter) Down _ _) (World (PerdeuJogo Jogar) numeros _ _ _ _ images) = (World ModoJogo (drop 10 numeros) (Jogo (Jogador (5,14)) (Mapa 11 ('criarmapa' 11 15 [] (head (drop 10 numeros)) 0))) 0 0 0 images)
event (EventKey (SpecialKey KeyEnter) Down _ _) (World (PerdeuJogo Sair) _ _ _ _ _ _) = error "Fim de Jogo"
event _ world = world
@

-}
event :: Event -- ^ recebe um evento (premir tecla)
      -> World -- ^ recebe um mundo do jogo
      -> World -- ^ devolve um mundo atualizado
--Menu
event (EventKey (SpecialKey KeyEnter) Down _ _) (World (Opcoes Jogar) numeros jogo score saux naux images) = (World ModoJogo numeros jogo score saux naux images)
event (EventKey (SpecialKey KeyUp) Down _ _) (World (Opcoes Jogar) numeros jogo score saux naux images) = (World (Opcoes Sair) numeros jogo score saux naux images) 
event (EventKey (SpecialKey KeyDown) Down _ _) (World (Opcoes Jogar) numeros jogo score saux naux images) = (World (Opcoes Sair) numeros jogo score saux naux images)
event (EventKey (SpecialKey KeyUp) Down _ _) (World (Opcoes Sair) numeros jogo score saux naux images) = (World (Opcoes Jogar)  numeros jogo score saux naux images)
event (EventKey (SpecialKey KeyDown) Down _ _) (World (Opcoes Sair) numeros jogo score saux naux images) = (World (Opcoes Jogar) numeros jogo score saux naux images)
event (EventKey (SpecialKey KeyEnter) Down _ _) (World (Opcoes Sair) _ _ _ _ _ _) = error "Fim de Jogo"
event (EventKey (SpecialKey KeyUp) Down _ _) (World ModoJogo numeros j@(Jogo (Jogador (x,y)) (Mapa l terr)) score saux naux images) 
  | jogoTerminou j == True = (World (PerdeuJogo Jogar) numeros j score saux naux images)
  | score == saux = (World ModoJogo numeros (animaJogador j (Move Cima)) (score+1) (saux+1) naux images)
  | otherwise = (World ModoJogo numeros (animaJogador j (Move Cima)) score (saux+1) naux images)
event (EventKey (SpecialKey KeyDown) Down _ _) (World ModoJogo numeros j@(Jogo (Jogador (x,y)) (Mapa l terr)) score saux naux images) 
  | jogoTerminou j == True = (World (PerdeuJogo Jogar) numeros j score saux naux images)
  | otherwise = (World ModoJogo numeros (animaJogador j (Move Baixo)) score (saux-1) naux images)
event (EventKey (SpecialKey KeyRight) Down _ _) (World ModoJogo numeros j@(Jogo (Jogador (x,y)) (Mapa l terr)) score saux naux images) 
  | jogoTerminou j == True = (World (PerdeuJogo Jogar) numeros j score saux naux images)
  | otherwise = (World ModoJogo numeros (animaJogador j (Move Direita)) score saux naux images)
event (EventKey (SpecialKey KeyLeft) Down _ _) (World ModoJogo numeros j@(Jogo (Jogador (x,y)) (Mapa l terr)) score saux naux images) 
  | jogoTerminou j == True = (World (PerdeuJogo Jogar) numeros j score saux naux images)
  | otherwise = (World ModoJogo numeros (animaJogador j (Move Esquerda)) score saux naux images)
event (EventKey (SpecialKey KeyUp) Down _ _) (World (PerdeuJogo Jogar) numeros jogo score saux naux images) = (World (PerdeuJogo Sair) numeros jogo score saux naux images)
event (EventKey (SpecialKey KeyDown) Down _ _) (World (PerdeuJogo Jogar) numeros jogo score saux naux images) = (World (PerdeuJogo Sair) numeros jogo score saux naux images)
event (EventKey (SpecialKey KeyUp) Down _ _) (World (PerdeuJogo Sair) numeros jogo score saux naux images) = (World (PerdeuJogo Jogar) numeros jogo score saux naux images)
event (EventKey (SpecialKey KeyDown) Down _ _) (World (PerdeuJogo Sair) numeros jogo score saux naux images) = (World (PerdeuJogo Jogar) numeros jogo score saux naux images)
event (EventKey (SpecialKey KeyEnter) Down _ _) (World (PerdeuJogo Jogar) numeros _ _ _ _ images) = (World ModoJogo (drop 10 numeros) (Jogo (Jogador (5,14)) (Mapa 11 (criarmapa 11 15 [] (head (drop 10 numeros)) 0))) 0 0 0 images)
event (EventKey (SpecialKey KeyEnter) Down _ _) (World (PerdeuJogo Sair) _ _ _ _ _ _) = error "Fim de Jogo"
event _ world = world

{- | A função /@__time__@/  serve para modificar o estado do World conforme o tempo passa e aumentar a dificuldade quando o score a ultrapassa os 25 e os 50 pontos


A função pode ser definida da seguinte forma : 

@
time n (World ModoJogo numeros j@(Jogo (Jogador (x,y)) (Mapa l terr)) score saux naux images) 
  | y == 16 && 'jogoTerminou' (Jogo (Jogador (x,y)) (Mapa l (tail terr))) == True = (World (PerdeuJogo Jogar) numeros j score saux naux images)
  | 'jogoTerminou' j = (World (PerdeuJogo Jogar) numeros j score saux naux images)
  | score <= 25 && mod naux 20 == 0 = (World ModoJogo (tail numeros) ('animaJogo' j Parado) score saux (naux+1) images)
  | score <= 25 && mod naux 30 == 0 = (World ModoJogo (tail numeros) ('deslizaJogo' j (head numeros)) score saux (naux+1) images)
  | score <= 25 && mod naux 20 == 0 && mod naux 30 == 0 = (World ModoJogo (tail numeros) ('deslizaJogo' ('animaJogo' j Parado) (head numeros)) score saux (naux+1) images)
  | score > 25 && score <= 50 && mod naux 15 == 0 = (World ModoJogo (tail numeros) ('animaJogo' j Parado) score saux (naux+1) images)
  | score > 25 && score <= 50 && mod naux 25 == 0 = (World ModoJogo (tail numeros) ('deslizaJogo' j (head numeros)) score saux (naux+1) images)
  | score > 25 && score <= 50 && mod naux 15 == 0 && mod naux 25 == 0 = (World ModoJogo (tail numeros) ('deslizaJogo' ('animaJogo' j Parado) (head numeros)) score saux (naux+1) images)
  | score > 50 && mod naux 11 == 0 = (World ModoJogo (tail numeros) ('animaJogo' j Parado) score saux (naux+1) images)
  | score > 50 && mod naux 21 == 0 = (World ModoJogo (tail numeros) ('deslizaJogo' j (head numeros)) score saux (naux+1) images)
  | score > 50 && mod naux 11 == 0 && mod naux 21 == 0 = (World ModoJogo (tail numeros) ('deslizaJogo' (animaJogo j Parado) (head numeros)) score saux (naux+1) images)
  | otherwise = (World ModoJogo numeros j score saux (naux+1) images)
time _ w = w
@

-}
time :: Float -- ^ recebe um float
     -> World -- ^ recebe um mundo do jogo
     -> World -- ^ devolve um mundo atualizado
time n (World ModoJogo numeros j@(Jogo (Jogador (x,y)) (Mapa l terr)) score saux naux images) 
  | y == 16 && jogoTerminou (Jogo (Jogador (x,y)) (Mapa l (tail terr))) == True = (World (PerdeuJogo Jogar) numeros j score saux naux images)
  | jogoTerminou j = (World (PerdeuJogo Jogar) numeros j score saux naux images)
  | score <= 25 && mod naux 20 == 0 = (World ModoJogo (tail numeros) (animaJogo j Parado) score saux (naux+1) images)
  | score <= 25 && mod naux 30 == 0 = (World ModoJogo (tail numeros) (deslizaJogo j (head numeros)) score saux (naux+1) images)
  | score <= 25 && mod naux 20 == 0 && mod naux 30 == 0 = (World ModoJogo (tail numeros) (deslizaJogo (animaJogo j Parado) (head numeros)) score saux (naux+1) images)
  | score > 25 && score <= 50 && mod naux 15 == 0 = (World ModoJogo (tail numeros) (animaJogo j Parado) score saux (naux+1) images)
  | score > 25 && score <= 50 && mod naux 25 == 0 = (World ModoJogo (tail numeros) (deslizaJogo j (head numeros)) score saux (naux+1) images)
  | score > 25 && score <= 50 && mod naux 15 == 0 && mod naux 25 == 0 = (World ModoJogo (tail numeros) (deslizaJogo (animaJogo j Parado) (head numeros)) score saux (naux+1) images)
  | score > 50 && mod naux 11 == 0 = (World ModoJogo (tail numeros) (animaJogo j Parado) score saux (naux+1) images)
  | score > 50 && mod naux 21 == 0 = (World ModoJogo (tail numeros) (deslizaJogo j (head numeros)) score saux (naux+1) images)
  | score > 50 && mod naux 11 == 0 && mod naux 21 == 0 = (World ModoJogo (tail numeros) (deslizaJogo (animaJogo j Parado) (head numeros)) score saux (naux+1) images)
  | otherwise = (World ModoJogo numeros j score saux (naux+1) images)
time _ w = w


{- | A função /@__criarmapa__@/  serve para criar um Mapa para o Jogo


A função pode ser definida da seguinte forma : 

@
criarmapa larg h t n ac
  | ac == h = t
  | ac == 0 = (criarmapa larg h ('estendeMapa'' larg t n) (n + (mod n 5)) (ac+4))++[(Relva,[Arvore,Arvore,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Arvore,Arvore]),(Relva,[Arvore,Arvore,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Arvore,Arvore]),(Relva,[Arvore,Arvore,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Arvore,Arvore]),(Relva,[Arvore,Arvore,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Arvore,Arvore]),(Relva,[Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum])]
  | ac < h = criarmapa larg h ('estendeMapa'' larg t n) (n + (mod n 5)) (ac+1)
@

-}
criarmapa :: Int -- ^ recebe a largura do mapa
          -> Int -- ^ recebe a (altura do mapa-1)
          -> [(Terreno, [Obstaculo])] -- ^ recebe uma lista de tuplos de terreno e lista de obstáculos (inicialmente [])
          -> Int -- ^ recebe um número aleatório
          -> Int -- ^ recebe um acumulador
          -> [(Terreno, [Obstaculo])] -- ^ devolve uma lista de tuplos de terreno e lista de obstáculos
criarmapa larg h t n ac
  | ac == h = t
  | ac == 0 = (criarmapa larg h (estendeMapa' larg t n) (n + (mod n 5)) (ac+4))++[(Relva,[Arvore,Arvore,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Arvore,Arvore]),(Relva,[Arvore,Arvore,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Arvore,Arvore]),(Relva,[Arvore,Arvore,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Arvore,Arvore]),(Relva,[Arvore,Arvore,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Arvore,Arvore]),(Relva,[Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum])]
  | ac < h = criarmapa larg h (estendeMapa' larg t n) (n + (mod n 5)) (ac+1)
  
{- | A função /@__mapatotilelist__@/  serve converter o Mapa numa lista de listas de Tile, sendo que cada lista de Tile corresponde a uma linha do Mapa


A função pode ser definida da seguinte forma : 

@
mapatotilelist [] = []
mapatotilelist ((Estrada v, obs):t) = 'obstaculototile' (Estrada v, obs) : mapatotilelist t
mapatotilelist ((Rio v, obs):t) = 'obstaculototile' (Rio v, obs) : mapatotilelist t
mapatotilelist ((Relva, obs):t) = 'obstaculototile' (Relva, obs) : mapatotilelist t
@

-}

mapatotilelist :: [(Terreno,[Obstaculo])] -- ^ recebe uma lista de tuplos de terreno e lista de obstáculos
               -> [[Tile]] -- ^ devolve uma lista de listas de Tiles (imagens de terrenos/obstáculos)
mapatotilelist [] = []
mapatotilelist ((Estrada v, obs):t) = obstaculototile (Estrada v, obs) : mapatotilelist t
mapatotilelist ((Rio v, obs):t) = obstaculototile (Rio v, obs) : mapatotilelist t
mapatotilelist ((Relva, obs):t) = obstaculototile (Relva, obs) : mapatotilelist t

{- | A função /@__obstaculototile__@/  serve converter uma lista de obstáculos em uma lista de Tile


A função pode ser definida da seguinte forma : 

@
obstaculototile (Estrada v, (h:t)) 
  | h == Nenhum = EstradaT : obstaculototile (Estrada v, t) 
  | v > 0 && h == Carro = Carro1T : obstaculototile (Estrada v, t)
  | v < 0 && h == Carro = Carro2T : obstaculototile (Estrada v, t) 
obstaculototile (Rio v, (h:t)) 
  | h == Nenhum = RioT : obstaculototile (Rio v, t) 
  | v > 0 && h == Tronco = Tronco1T : obstaculototile (Rio v, t)
  | v < 0 && h == Tronco = Tronco2T : obstaculototile (Rio v, t)  
obstaculototile (Relva , (h:t)) 
  | h == Nenhum = RelvaT : obstaculototile (Relva, t) 
  | h == Arvore = ArvoreT : obstaculototile (Relva , t) 
obstaculototile _ = []
@

-}

obstaculototile :: (Terreno,[Obstaculo]) -- ^ recebe um tuplo de terreno e lista de ibstáculos
                -> [Tile] -- ^ devolve uma lista de Tiles (imagens de terrenos/obstáculos))
obstaculototile (Estrada v, (h:t)) 
  | h == Nenhum = EstradaT : obstaculototile (Estrada v, t) 
  | v > 0 && h == Carro = Carro1T : obstaculototile (Estrada v, t)
  | v < 0 && h == Carro = Carro2T : obstaculototile (Estrada v, t) 
obstaculototile (Rio v, (h:t)) 
  | h == Nenhum = RioT : obstaculototile (Rio v, t) 
  | v > 0 && h == Tronco = Tronco1T : obstaculototile (Rio v, t)
  | v < 0 && h == Tronco = Tronco2T : obstaculototile (Rio v, t)  
obstaculototile (Relva , (h:t)) 
  | h == Nenhum = RelvaT : obstaculototile (Relva, t) 
  | h == Arvore = ArvoreT : obstaculototile (Relva , t) 
obstaculototile _ = []

{- | A função /@__drawTile__@/  serve converter um Tile numa imagem


A função pode ser definida da seguinte forma : 

@
drawTile side RioT p = p !! 0
drawTile side EstradaT p = p !! 1
drawTile side RelvaT p = p !! 2
drawTile side Tronco1T p = p !! 3
drawTile side Tronco2T p = p !! 4
drawTile side Carro1T p = p !! 5
drawTile side Carro2T p = p !! 6
drawTile side ArvoreT p = p !! 7
@

-}

drawTile :: Float -- ^ recebe o comprimento do lado de Tile (pixeis)
         -> Tile -- ^ recebe um Tile (imagem de terreno/obstáculo)
         -> [Picture] -- ^ recebe a lista de imagens importadas
         -> Picture -- ^ devolve uma imagem
drawTile side RioT p = p !! 0
drawTile side EstradaT p = p !! 1
drawTile side RelvaT p = p !! 2
drawTile side Tronco1T p = p !! 3
drawTile side Tronco2T p = p !! 4
drawTile side Carro1T p = p !! 5
drawTile side Carro2T p = p !! 6
drawTile side ArvoreT p = p !! 7

{- | A função /@__drawList__@/  serve converter uma lista de Tile numa lista de imagens


A função pode ser definida da seguinte forma : 

@
drawList side [] p = Blank
drawList side (h:t) p = Pictures [desenhaTile, resto]
    where desenhaTile = 'drawTile' side h p
          resto = Translate side 0 $ drawList side t p
@

-}

drawList :: Float -- ^ recebe o comprimento do lado de Tile (pixeis)
         -> [Tile] -- ^ recebe uma lista de Tiles (imagens de terrenos/obstáculos))
         -> [Picture] -- ^ recebe uma lista de Imagens
         -> Picture  -- ^ devolve a imagem de uma linha do mapa
drawList side [] p = Blank
drawList side (h:t) p = Pictures [desenhaTile, resto]
    where desenhaTile = drawTile side h p
          resto = Translate side 0 $ drawList side t p

{- | A função /@__drawGrid__@/  serve converter uma lista de listas de Tile numa lista de listas de imagens


A função pode ser definida da seguinte forma : 

@
drawGrid side [] p = Blank
drawGrid side (h:t) p = Pictures [desenhaLinha, resto]
    where desenhaLinha = 'drawList' side h p
          resto = Translate 0 (-side) $ drawGrid side t p
@

-}

drawGrid :: Float -- ^ recebe o comprimento do lado de Tile (pixeis) 
         -> [[Tile]] -- ^ recebe uma lista de listas de Tiles (imagens de terrenos/obstáculos)
         -> [Picture] -- ^ recebe uma lista de Imagens
         -> Picture -- ^ devolve a imagem do mapa completo
drawGrid side [] p = Blank
drawGrid side (h:t) p = Pictures [desenhaLinha, resto]
    where desenhaLinha = drawList side h p
          resto = Translate 0 (-side) $ drawGrid side t p
 


{- | A função /@__window__@/  serve definir a janela do jogo


A função pode ser definida da seguinte forma : 

@
window = InWindow "Janela" (550,800) (0,0)
@

-}
window  :: Display -- ^ janela do jogo
window = InWindow "Janela" (550,800) (0,0)

{- | A função /@__background__@/  serve definir a cor de fundo do jogo


A função pode ser definida da seguinte forma : 

@
background = (makeColorI 221 212 179 255)
@

-}

background :: Color -- ^ cor do background do jogo
background = (makeColorI 221 212 179 255)

{- | A função /@__fr__@/  serve definir o frame rate do jogo


A função pode ser definida da seguinte forma : 

@
fr = 20
@

-}

fr :: Int -- ^ frame rate do jogo
fr = 20


