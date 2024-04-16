{- |
Module      : Tarefa1_2022li1g013
Description : Validação de um mapa
Copyright   : Luís Cunha <a104613@alunos.uminho.pt>
              Tomás Barbosa <a104532@alunos.uminho.pt>

Módulo para a realização da Tarefa 1 do projeto de LI1 2022/23.
-}
module Tarefa1_2022li1g013 where


import LI12223

-- * Função Principal - mapaValido

{- | A função /@__mapaValido__@/  verifica se o 'Mapa' é válido (usa as funções auxiliares mencionadas abaixo)


A função pode ser definida da seguinte forma : 

@
__mapaValido__ l@(Mapa larg ((Rio v , obstaculos):t)) = obstaculosinvalidos l == True && rioscontiguos l == True && larguraobstaculos l == True && minobstaculos  l == True && largmapa l == True && maxriosestradas l == True && mapaValido (Mapa larg t) 
__mapaValido__ l@(Mapa larg ((Estrada v , obstaculos):t)) = obstaculosinvalidos l == True && larguraobstaculos l == True && minobstaculos  l == True && largmapa l == True && maxriosestradas l == True && mapaValido (Mapa larg t) 
__mapaValido__ l@(Mapa larg ((Relva , obstaculos):t)) = obstaculosinvalidos l == True &&  minobstaculos  l == True && largmapa l == True && maxriosestradas l == True && mapaValido (Mapa larg t) 
@

-}
mapaValido :: Mapa -- ^ argumento assume-se do tipo Mapa
           -> Bool -- ^ resultado, Verdadeiro ou Falso
mapaValido (Mapa larg []) = True
mapaValido l@(Mapa larg ((Rio v , obstaculos):t)) = obstaculosinvalidos l == True && rioscontiguos l == True && larguraobstaculos l == True && minobstaculos  l == True && largmapa l == True && maxriosestradas l == True && mapaValido (Mapa larg t) --  verifica se o mapa é válido para o Rio
mapaValido l@(Mapa larg ((Estrada v , obstaculos):t)) = obstaculosinvalidos l == True && larguraobstaculos l == True && minobstaculos  l == True && largmapa l == True && maxriosestradas l == True && mapaValido (Mapa larg t) --  verifica se o mapa é válido para a Estrada
mapaValido l@(Mapa larg ((Relva , obstaculos):t)) = obstaculosinvalidos l == True &&  minobstaculos  l == True && largmapa l == True && maxriosestradas l == True && mapaValido (Mapa larg t) --  verifica se o mapa é válido para a Relva

-- * Funções auxiliares para mapaValido

-- ** obstaculosinvalidos

{- | A função /@__obstaculosinvalidos__@/  verifica se não existem obstáculos em terrenos impróprios do 'Mapa'


A função pode ser definida da seguinte forma : 

@
__obstaculosinvalidos__ (Mapa larg []) = True 
__obstaculosinvalidos__ (Mapa larg ((Rio v , obstaculos):t)) 
    | v == 0 = False 
    | Carro `elem` obstaculos|| Arvore `elem` obstaculos = False 
    | otherwise = obstaculosinvalidos (Mapa larg t) 
__obstaculosinvalidos__ (Mapa larg ((Estrada v , obstaculos):t))  
    | v == 0 = False 
    | Tronco `elem` obstaculos|| Arvore `elem` obstaculos = False 
    | otherwise = obstaculosinvalidos (Mapa larg t) 
__obstaculosinvalidos__ (Mapa larg ((Relva , obstaculos):t)) 
    | Carro `elem` obstaculos|| Tronco `elem` obstaculos = False 
    | otherwise = obstaculosinvalidos (Mapa larg t)
@

-}
obstaculosinvalidos :: Mapa -- ^  argumento assume-se do tipo Mapa
                    -> Bool -- ^  resultado, Verdadeiro ou Falso
obstaculosinvalidos (Mapa larg []) = True --  caso de paragem da função, pois é recursiva
obstaculosinvalidos (Mapa larg ((Rio v , obstaculos):t)) 
    | v == 0 = False --  o rio tem de ter velocidade diferente de 0
    | Carro `elem` obstaculos|| Arvore `elem` obstaculos = False --  o rio não pode conter obstáculos de outros terrenos
    | otherwise = obstaculosinvalidos (Mapa larg t) --  chama a função outra vez (recursiva)
obstaculosinvalidos (Mapa larg ((Estrada v , obstaculos):t))  
    | v == 0 = False --  a Estrada tem de ter velocidade diferente de 0
    | Tronco `elem` obstaculos|| Arvore `elem` obstaculos = False -- a estrada não pode conter obstáculos de outros terrenos
    | otherwise = obstaculosinvalidos (Mapa larg t) --  chama a função outra vez (recursiva)
obstaculosinvalidos (Mapa larg ((Relva , obstaculos):t)) 
    | Carro `elem` obstaculos|| Tronco `elem` obstaculos = False --  a relva não pode conter obstáculos de outros terrenos
    | otherwise = obstaculosinvalidos (Mapa larg t) --  chama a função outra vez (recursiva)


-- ** rioscontiguos

{- | A função /@__rioscontiguos__@/  verifica se rioscontíguos têm direções opostas no 'Mapa'


A função pode ser definida da seguinte forma : 

@
__rioscontiguos__ (Mapa larg ((Rio v , obstaculos):(Rio v1 , obstaculos1):t))
    | v>0 && v1>0 || v<0 && v1<0 = False
    | otherwise = rioscontiguos (Mapa larg t)
__rioscontiguos__ (Mapa larg ((Rio _,_ ):t)) = True
@

-}
rioscontiguos :: Mapa -- ^ argumento assume-se do tipo Mapa
              -> Bool -- ^ resultado, Verdadeiro ou Falso
rioscontiguos (Mapa larg []) = True
rioscontiguos (Mapa larg ((Rio v , obstaculos):(Rio v1 , obstaculos1):t))
    | v>0 && v1>0 || v<0 && v1<0 = False --  verifica se as velocidades dos rios contíguos são opostas
    | otherwise = rioscontiguos (Mapa larg ((Rio v1, obstaculos1):t)) --  chama a função outra vez para verificar em todas as linhas do mapa
rioscontiguos (Mapa larg ((Rio _,_ ):t)) = rioscontiguos (Mapa larg t) --  se não tiver rios contíguos com direções iguais então devolve Verdade
rioscontiguos (Mapa larg ((Estrada _, _):t)) = rioscontiguos (Mapa larg t)
rioscontiguos (Mapa larg ((Relva,_):t)) = rioscontiguos (Mapa larg t) 


-- ** larguraobstaculos

{- | A função /@__larguraobstaculos__@/  verifica se os troncos têm, no máximo, 5 unidades de comprimento e se os carros têm, no máximo, 3 unidades de comprimento no 'Mapa'


A função pode ser definida da seguinte forma : 

@
__larguraobstaculos__ (Mapa larg ((Rio v, obstaculos):t)) = 'contagemTroncos' obstaculos 0 
__larguraobstaculos__ (Mapa larg ((Estrada v, obstaculos):t)) = 'contagemCarros' obstaculos 0 
@

- @funções /auxiliares/ da função@ 'larguraobstaculos' __--->__ __'contagemTroncos'__ e __'contagemCarros'__
-}

larguraobstaculos :: Mapa -- ^ argumento assume-se do tipo Mapa
                  -> Bool -- ^ resultado, Verdadeiro ou Falso
larguraobstaculos (Mapa larg ((Rio v, obstaculos):t)) = contagemTroncos obstaculos 0 --  verifica se os troncos têm mais de 5 unidades de comprimento
larguraobstaculos (Mapa larg ((Estrada v, obstaculos):t)) = contagemCarros obstaculos 0 --  verifica se os carrostêm mais de 3 unidades de comprimento


{- | A função /@__contagemTroncos__@/  verifica se os troncos têm, no máximo, 5 unidades de comprimento no 'Mapa'

A função pode ser definida da seguinte forma : 

@
__contagemTroncos__ :: [Obstaculo] -> Int -> Bool
__contagemTroncos__ l 6 = False
__contagemTroncos__ [] n = True
__contagemTroncos__ (h:t) n
            | h == Tronco = contagemTroncos t (n+1)
            | otherwise = contagemTroncos t 0
@
-}
contagemTroncos :: [Obstaculo] -- ^ pede uma lista de obstáculos
                        -> Int -- ^ pede um número inteiro
                       -> Bool -- ^ devolve Verdade ou Falso
contagemTroncos l 6 = False --  caso o comprimento seja maior que 5 então é Falso
contagemTroncos [] n = True -- caso de paragem
contagemTroncos (h:t) n
            | h == Tronco = contagemTroncos t (n+1) -- caso o obstáculo seja um tronco então adiciona 1 à contagem
            | otherwise = contagemTroncos t 0 -- caso o obstáculo não seja um tronco então a contagem volta para 0

{- | A função /@__contagemCarros__@/  verifica se os carros têm, no máximo, 3 unidades de comprimento no 'Mapa'

A função pode ser definida da seguinte forma :

@
__contagemCarros__ :: [Obstaculo] -> Int -> Bool
__contagemCarros__ l 4 = False
__contagemCarros__ [] n = True
__contagemCarros__ (h:t) n
            | h == Tronco = contagemCarros t (n+1)
            | otherwise = contagemCarros t 0
@
-}

contagemCarros :: [Obstaculo] -- ^ pede uma lista de obstáculos
                       -> Int -- ^ pede um número inteiro
                      -> Bool -- ^ devolve Verdade ou Falso
contagemCarros l 4 = False -- caso o comprimento seja maior que 3 então é Falso
contagemCarros [] n = True -- caso de paragem
contagemCarros (h:t) n
            | h == Carro = contagemCarros t (n+1) -- caso o obstáculo seja um carro então adiciona 1 à contagem
            | otherwise = contagemCarros t 0 -- caso o obstáculo não seja um carro então a contagem volta para 0

-- ** minobstaculos

{- | A função /@__minobstaculos__@/  verifica se existe pelo menos um obstáculo "Nenhum" em cada linha do 'Mapa'


A função pode ser definida da seguinte forma : 

@
__minobstaculos__ (Mapa larg []) = True  
__minobstaculos__ (Mapa larg ((Rio v , obstaculos):t))  = Nenhum `elem` obstaculos && minobstaculos (Mapa larg t) 
__minobstaculos__ (Mapa larg ((Estrada v , obstaculos):t))  = Nenhum `elem` obstaculos && minobstaculos (Mapa larg t) 
__minobstaculos__ (Mapa larg ((Relva , obstaculos):t))  = Nenhum `elem` obstaculos && minobstaculos (Mapa larg t) 
@

-}

minobstaculos :: Mapa -- ^ argumento assume-se do tipo Mapa
                  -> Bool -- ^ resultado, Verdadeiro ou Falso
minobstaculos (Mapa larg []) = True  -- caso de paragem da função, se nenhum dos casos abaixo acontecer então é válido
minobstaculos (Mapa larg ((Rio v , obstaculos):t))  = Nenhum `elem` obstaculos && minobstaculos (Mapa larg t) -- verifica se existe no mínimo um obstáculo "Nenhum" para o Rio
minobstaculos (Mapa larg ((Estrada v , obstaculos):t))  = Nenhum `elem` obstaculos && minobstaculos (Mapa larg t) -- verifica se existe no mínimo um obstáculo "Nenhum" para a Estrada
minobstaculos (Mapa larg ((Relva , obstaculos):t))  = Nenhum `elem` obstaculos && minobstaculos (Mapa larg t) -- verifica se existe no mínimo um obstáculo "Nenhum" para a Relva


-- ** largmapa

{- | A função /@__largmapa__@/  verifica se o comprimento da lista de obstáculos de cada linha corresponde exatamente à largura do 'Mapa'


A função pode ser definida da seguinte forma : 

@
__largmapa__ (Mapa larg []) = True 
__largmapa__ (Mapa larg ((Rio v , obstaculos):t)) = larg == length obstaculos && largmapa (Mapa larg t) 
__largmapa__ (Mapa larg ((Estrada v , obstaculos):t)) = larg == length obstaculos && largmapa (Mapa larg t) 
__largmapa__ (Mapa larg ((Relva , obstaculos):t)) = larg == length obstaculos && largmapa (Mapa larg t) 
@

-}

largmapa :: Mapa -- ^ argumento assume-se do tipo Mapa
                  -> Bool -- ^ resultado, Verdadeiro ou Falso
largmapa (Mapa larg []) = True -- caso de paragem da função, se nenhum dos casos acontecer então é válido
largmapa (Mapa larg ((Rio v , obstaculos):t)) = larg == length obstaculos && largmapa (Mapa larg t) -- verifica se a largura do mapa é igual ao comprimento da lista de obstáculos para o Rio
largmapa (Mapa larg ((Estrada v , obstaculos):t)) = larg == length obstaculos && largmapa (Mapa larg t) -- verifica se a largura do mapa é igual ao comprimento da lista de obstáculos para a Estrada
largmapa (Mapa larg ((Relva , obstaculos):t)) = larg == length obstaculos && largmapa (Mapa larg t) -- verifica se a largura do mapa é igual ao comprimento da lista de obstáculos para a Relva


-- ** maxriosestradas

{- | A função /@__maxriosestradas__@/  verifica se não existem, contiguamente, mais do que 4 rios, 5 estradas ou 5 relvas no 'Mapa'


A função pode ser definida da seguinte forma : 

@
__maxriosestradas__ (Mapa larg ((Rio _ , _):(Rio _ , _):(Rio _ , _):(Rio _ , _):(Rio _ , _):t)) = False 
__maxriosestradas__ (Mapa larg ((Estrada _ , _):(Estrada _ , _):(Estrada _ , _):(Estrada _ , _):(Estrada _ , _):(Estrada _ , _):t)) = False 
__maxriosestradas__ (Mapa larg ((Relva , _):(Relva , _):(Relva , _):(Relva , _):(Relva , _):(Relva , _):t)) = False 
__maxriosestradas__ (Mapa larg []) = True 
__maxriosestradas__ (Mapa larg ((Rio _, _ ):t)) = True 
__maxriosestradas__ (Mapa larg ((Estrada _, _ ):t)) = True 
__maxriosestradas__ (Mapa larg ((Relva, _ ):t)) = True
@

-}

maxriosestradas :: Mapa -- ^ argumento assume-se do tipo Mapa
                  -> Bool -- ^ resultado, Verdadeiro ou Falso
maxriosestradas (Mapa larg ((Rio _ , _):(Rio _ , _):(Rio _ , _):(Rio _ , _):(Rio _ , _):t)) = False -- caso para quando não podem ter mais de 4 rios contiguos
maxriosestradas (Mapa larg ((Estrada _ , _):(Estrada _ , _):(Estrada _ , _):(Estrada _ , _):(Estrada _ , _):(Estrada _ , _):t)) = False -- caso para quando não podem ter mais de 5 estradas contiguas
maxriosestradas (Mapa larg ((Relva , _):(Relva , _):(Relva , _):(Relva , _):(Relva , _):(Relva , _):t)) = False -- caso para quando não podem ter mais de 5 relvas contiguas
maxriosestradas (Mapa larg []) = True 
maxriosestradas (Mapa larg ((Rio _, _ ):t)) = True -- caso para quando não tem mais de 4 rios contiguos, logo é válido
maxriosestradas (Mapa larg ((Estrada _, _ ):t)) = True -- caso para quando não tem mais de 5 estradas contiguas, logo é válido
maxriosestradas (Mapa larg ((Relva, _ ):t)) = True -- caso para quando não tem mais de 5 relvas contiguas, logo é válido













{- 
exemplos para serem usados:

  (Mapa 5 [(Relva, [Arvore, Nenhum, Arvore, Nenhum, Arvore]),(Estrada (-1), [Nenhum, Nenhum, Nenhum, Carro, Carro]),(Relva, [Arvore, Nenhum, Carro, Arvore, Arvore])] )

  maxriosestradas (Mapa 6 [(Estrada 2 , [Nenhum]), (Estrada 2 , [Nenhum]), (Estrada 2 , [Nenhum]), (Estrada 2 , [Nenhum]), (Estrada 2 , [Nenhum]), (Estrada 2 , [Nenhum])])

outro metodo de fazer a 7 :

maxRioEstRelv :: [(Terreno,[Obstaculo])] -> Int -> Int -> Int -> Bool
maxRioEstRelv l a b c | a > 4 = False
                      | b > 4 = False
                      | c > 4 = False
maxRioEstRelv [] a b c = True
maxRioEstRelv ((ter,obList):t) a b c = case ter of
                                            Rio _  -> maxRioEstRelv t (a+1) 0 0
                                            Estrada _ -> maxRioEstRelv t 0 (b+1) 0
                                            Relva -> maxRioEstRelv t 0 0 (c+1)

-}