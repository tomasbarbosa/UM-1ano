{- |
Module      : Tarefa2_2022li1g013
Description : Geração contínua de um mapa
Copyright   : Luís Cunha <a104613@alunos.uminho.pt>
              Tomás Barbosa <a104532@alunos.uminho.pt>

Módulo para a realização da Tarefa 2 do projeto de LI1 2022/23.
-}
module Tarefa2_2022li1g013 where
import System.Random
import LI12223


-- * Função Principal - estendeMapa

{- | A função /@__estendeMapa__@/  adiciona uma nova linha ao 'Mapa? de forma aleatória


A função pode ser definida da seguinte forma : 

@
estendeMapa (Mapa larg terr) n = Mapa larg ((randomvelocidade n terreno t, listarobstaculos n larg terreno): terr)
    where terreno = escolheTerreno n (proximosTerrenosValidos (Mapa larg terr))
          t | null terr = Relva
            | otherwise = fst(head terr)
@

-}
estendeMapa :: Mapa -- ^ recebe o Mapa
            -> Int -- ^ recebe um número aleatório
            -> Mapa -- ^ devolve o mapa com a nova linha adicionada
estendeMapa (Mapa larg terr) n = Mapa larg ((randomvelocidade n terreno t, listarobstaculos n larg terreno): terr)
    where terreno = escolheTerreno n (proximosTerrenosValidos (Mapa larg terr))
          t | null terr = Relva
            | otherwise = fst(head terr)

{- | A função /@__estandeMapa'__@/  é semelhante à função 'estendeMapa' , mas em vez de receber um Mapa recebe uma lista de tuplos [(Terreno, [Obstaculo])] (usada na Tarefa 6)


A função pode ser definida da seguinte forma : 

@
estendeMapa' larg terr n = ((randomvelocidade n terreno t, listarobstaculos n larg terreno): terr)
    where terreno = escolheTerreno n (proximosTerrenosValidos (Mapa larg terr))
          t | null terr = Relva
            | otherwise = fst(head terr)
@

-}

estendeMapa' :: Int -- ^ recebe a largura do Mapa
             -> [(Terreno, [Obstaculo])] -- ^ recebe uma lista de tuplos Terreno e lista de Obstáculos
             -> Int -- ^ recebe um número aleatório
             -> [(Terreno, [Obstaculo])] -- ^ devolve a lista de tuplos Terreno e lista de Obstáculos com a nova linha adicionada
estendeMapa' larg terr n = ((randomvelocidade n terreno t, listarobstaculos n larg terreno): terr)
    where terreno = escolheTerreno n (proximosTerrenosValidos (Mapa larg terr))
          t | null terr = Relva
            | otherwise = fst(head terr)

{- | A função /@__proximosTerrenosValidos__@/  serve para listas os Terrenos válidos para a próxima linha do Mapa


A função pode ser definida da seguinte forma : 

@
proximosTerrenosValidos :: Mapa -- ^ recebe o Mapa
                        -> [Terreno] -- ^ devolve a lista de Terrenos válidos para a próxima linha
proximosTerrenosValidos (Mapa _ ((Estrada _, _):(Estrada _, _):(Estrada _, _):(Estrada _, _):(Estrada _,_):t)) = [Relva, Rio 0]
proximosTerrenosValidos (Mapa _ ((Relva,_):(Relva,_):(Relva,_):(Relva,_):(Relva,_):t)) = [Rio 0, Estrada 0]
proximosTerrenosValidos (Mapa _ ((Rio _, _):(Rio _, _):(Rio _, _):(Rio _, _):t)) = [Estrada 0, Relva]
proximosTerrenosValidos (Mapa _ _) = [Relva, Rio 0, Estrada 0]
@
-}
proximosTerrenosValidos :: Mapa -- ^ recebe o Mapa
                        -> [Terreno] -- ^ devolve a lista de Terrenos válidos para a próxima linha
proximosTerrenosValidos (Mapa _ ((Estrada _, _):(Estrada _, _):(Estrada _, _):(Estrada _, _):(Estrada _,_):t)) = [Relva, Rio 0]
proximosTerrenosValidos (Mapa _ ((Relva,_):(Relva,_):(Relva,_):(Relva,_):(Relva,_):t)) = [Rio 0, Estrada 0]
proximosTerrenosValidos (Mapa _ ((Rio _, _):(Rio _, _):(Rio _, _):(Rio _, _):t)) = [Estrada 0, Relva]
proximosTerrenosValidos (Mapa _ _) = [Relva, Rio 0, Estrada 0]

{- | A função /@__proximosTerrenosValidos'__@/  é semelhante à função 'proximosTerrenosValidos', mas em vez de receber um Mapa recebe uma lista de tuplos [(Terreno, [Obstaculo])] (usada na Tarefa 6)


A função pode ser definida da seguinte forma : 

@
proximosTerrenosValidos' :: [(Terreno,[Obstaculo])] 
                         -> [Terreno]
proximosTerrenosValidos' ((Estrada _, _):(Estrada _, _):(Estrada _, _):(Estrada _, _):(Estrada _,_):t) = [Relva, Rio 0]
proximosTerrenosValidos' ((Relva,_):(Relva,_):(Relva,_):(Relva,_):(Relva,_):t) = [Rio 0, Estrada 0]
proximosTerrenosValidos' ((Rio _, _):(Rio _, _):(Rio _, _):(Rio _, _):t) = [Estrada 0, Relva]
proximosTerrenosValidos' _ = [Relva, Rio 0, Estrada 0]
@
-}

proximosTerrenosValidos' :: [(Terreno,[Obstaculo])] -- ^-- ^ recebe uma lista de tuplos Terreno e lista de Obstáculos
                         -> [Terreno] -- ^ devolve a lista de Terrenos válidos para a próxima linha
proximosTerrenosValidos' ((Estrada _, _):(Estrada _, _):(Estrada _, _):(Estrada _, _):(Estrada _,_):t) = [Relva, Rio 0]
proximosTerrenosValidos' ((Relva,_):(Relva,_):(Relva,_):(Relva,_):(Relva,_):t) = [Rio 0, Estrada 0]
proximosTerrenosValidos' ((Rio _, _):(Rio _, _):(Rio _, _):(Rio _, _):t) = [Estrada 0, Relva]
proximosTerrenosValidos' _ = [Relva, Rio 0, Estrada 0]

{- | A função /@__escolheTerreno__@/  serve para escolher de forma ateatória o Terreno da próxima linha do Mapa


A função pode ser definida da seguinte forma : 

@
escolheTerreno :: Int 
               -> [Terreno] 
               -> Terreno
escolheTerreno n (h:t) | mod n 4 == 0 = h
                       | mod n 4 == 1 = head t
                       | otherwise = last t
@
-}

escolheTerreno :: Int -- ^ recebe um número aleatório
               -> [Terreno] -- ^ recebe a lista de Terrenos válidos para a próxima linha
               -> Terreno -- ^ devolve o Terreno da prócima linha do Mapa
escolheTerreno n (h:t) | mod n 4 == 0 = h
                       | mod n 4 == 1 = head t
                       | otherwise = last t

{- | A função /@__randomvelocidade__@/  serve para escolher de forma ateatória a velocidade do Terreno da próxima linha do Mapa


A função pode ser definida da seguinte forma : 

@
randomvelocidade :: Int 
                 -> Terreno 
                -> Terreno 
                -> Terreno
randomvelocidade _ Relva _ = Relva
randomvelocidade n (Rio v) (Rio v1) 
    | v1 > 0 = if even n then Rio (-2) else Rio (-1)
    | otherwise =  if even n then Rio 1 else Rio 2
randomvelocidade n (Rio v) _ 
    | mod n 5 == 0 = Rio (-1)
    | mod n 5 == 1 = Rio 1
    | mod n 5 == 2 = Rio (-2)
    | otherwise = Rio 2
randomvelocidade n (Estrada v) _ 
    | mod n 5 == 0 = Estrada (-1)
    | mod n 5 == 1 = Estrada 1
    | mod n 5 == 2 = Estrada (-2)
    | otherwise = Estrada 2
@
-}

randomvelocidade :: Int -- ^ recebe um número aleatório
                 -> Terreno -- ^ recebe o Terreno da próxima linha do Mapa
                 -> Terreno -- ^ recebe o Terreno da primeira linha do Mapa atual
                 -> Terreno -- ^ devolve o Terreno e a velocidade da próxima linha do Mapa
randomvelocidade _ Relva _ = Relva
randomvelocidade n (Rio v) (Rio v1) 
    | v1 > 0 = if even n then Rio (-2) else Rio (-1)
    | otherwise =  if even n then Rio 1 else Rio 2
randomvelocidade n (Rio v) _ 
    | mod n 5 == 0 = Rio (-1)
    | mod n 5 == 1 = Rio 1
    | mod n 5 == 2 = Rio (-2)
    | otherwise = Rio 2
randomvelocidade n (Estrada v) _ 
    | mod n 5 == 0 = Estrada (-1)
    | mod n 5 == 1 = Estrada 1
    | mod n 5 == 2 = Estrada (-2)
    | otherwise = Estrada 2

{- | A função /@__proximosObstaculosValidos__@/  serve para listar os obstáculos válidos para a próxima linha do Mapa


A função pode ser definida da seguinte forma : 

@
proximosObstaculosValidos :: Int 
                          -> (Terreno, [Obstaculo]) 
                          -> [Obstaculo]
proximosObstaculosValidos larg (Rio _, []) = [Tronco,Nenhum]
proximosObstaculosValidos larg (Estrada _, []) = [Carro,Nenhum]
proximosObstaculosValidos larg (Relva , obs) | length obs >= larg = [] 
                                             | otherwise = if elem Nenhum obs then [Arvore, Nenhum] else [Nenhum]
proximosObstaculosValidos larg (Rio _, obs) | length obs >= larg = []
                                            | length obs > 4 = if elem Nenhum (take 5 obs) then [Tronco,Nenhum] else [Nenhum]
                                            | otherwise = if elem Nenhum obs && not(elem Tronco obs) then [Tronco] else if elem Nenhum obs then [Tronco,Nenhum] else [Nenhum] 
proximosObstaculosValidos larg (Estrada  _, obs) | length obs >= larg = []
                                                 | length obs > 2 = if elem Nenhum (take 3 obs) then [Carro,Nenhum] else [Nenhum]
                                                 | otherwise = if elem Nenhum obs then [Carro, Nenhum] else [Nenhum]
@
-}

proximosObstaculosValidos :: Int -- ^ recebe a largura do Mapa
                          -> (Terreno, [Obstaculo]) -- ^ recebe o tuplo Terreno e lista de Obstáculos da nova linha do Mapa
                          -> [Obstaculo] -- ^ devolve a lista de obstáculos que se podem adicionar a nova linha do Mapa
proximosObstaculosValidos larg (Rio _, []) = [Tronco,Nenhum]
proximosObstaculosValidos larg (Estrada _, []) = [Carro,Nenhum]
proximosObstaculosValidos larg (Relva , obs) | length obs >= larg = [] 
                                             | otherwise = if elem Nenhum obs then [Arvore, Nenhum] else [Nenhum]
proximosObstaculosValidos larg (Rio _, obs) | length obs >= larg = []
                                            | length obs > 4 = if elem Nenhum (take 5 obs) then [Tronco,Nenhum] else [Nenhum]
                                            | otherwise = if elem Nenhum obs && not(elem Tronco obs) then [Tronco] else if elem Nenhum obs then [Tronco,Nenhum] else [Nenhum] 
proximosObstaculosValidos larg (Estrada  _, obs) | length obs >= larg = []
                                                 | length obs > 2 = if elem Nenhum (take 3 obs) then [Carro,Nenhum] else [Nenhum]
                                                 | otherwise = if elem Nenhum obs then [Carro, Nenhum] else [Nenhum]

{- | A função /@__escolherobstaculo__@/  serve para escolher um obstáculo de forma aleatória daqueles listados a partir da função 'proximosObstaculosValidos'


A função pode ser definida da seguinte forma : 

@
escolherobstaculo :: Int 
                  -> Int 
                  -> (Terreno, [Obstaculo]) 
                  -> Obstaculo
escolherobstaculo n larg (t,obs) | mod n 3 == 0 && mod n 2 == 0 = last obsval
                                 | mod n 3 == 0 = head obsval
                                 | otherwise = last obsval
    where obsval = proximosObstaculosValidos larg (t,obs)
@
-}

escolherobstaculo :: Int -- ^ recebe um número aleatório
                  -> Int -- ^ recebe a largura do Mapa
                  -> (Terreno, [Obstaculo]) -- ^ recebe o tuplo Terreno e lista de Obstáculos da nova linha do Mapa
                  -> Obstaculo -- ^ devolve o obstáculo escolhida para se adidionar a nova linha do Mapa
escolherobstaculo n larg (t,obs) | mod n 3 == 0 && mod n 2 == 0 = last obsval
                                 | mod n 3 == 0 = head obsval
                                 | otherwise = last obsval
    where obsval = proximosObstaculosValidos larg (t,obs)

{- | A função /@__listarobstaculos__@/  serve para listar os obstáculos da próxima linha do Mapa


A função pode ser definida da seguinte forma : 

@
listarobstaculos :: Int 
                 -> Int 
                 -> Terreno 
                 -> [Obstaculo]
listarobstaculos n 0 t = []
listarobstaculos n larg t = escolherobstaculo n larg (t,obs) : obs
    where obs = listarobstaculos (n + (mod n 5)) (larg-1) t
@
-}

listarobstaculos :: Int -- ^ recebe um número aleatório
                 -> Int -- ^ recebe a largura do Mapa
                 -> Terreno -- ^ recebe o Terreno da nova linha do Mapa
                 -> [Obstaculo] -- ^ devolve a lista de obstáculos da nova linha do Mapa
listarobstaculos n 0 t = []
listarobstaculos n larg t = escolherobstaculo n larg (t,obs) : obs
    where obs = listarobstaculos (n + (mod n 5)) (larg-1) t
