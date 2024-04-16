module Ficha3 where

import Ficha1 

type Etapa = (Hora,Hora)
type Viagem = [Etapa]

etapaBemConstruida :: Etapa -> Bool
etapaBemConstruida (hora1,hora2) = horaValida' hora1 && horaValida' hora2 && hora2 `horaDepois` hora1

viagemBemConstruida :: Viagem -> Bool
viagemBemConstruida [] = True
viagemBemConstruida [(h1,h2)] = etapaBemConstruida (h1,h2)
viagemBemConstruida ((h1, h2):(h3, h4):t) = etapaBemConstruida (h1,h2) && viagemBemConstruida ((h3,h4):t) && h3 `horaDepois` h2

viagemBemConstruida' :: Viagem -> Bool
viagemBemConstruida' [] = True
viagemBemConstruida' [(h1,h2)] = etapaBemConstruida (h1,h2)
viagemBemConstruida' ((h1, h2):t) = etapaBemConstruida (h1,h2) && viagemBemConstruida' t && h3 `horaDepois` h2
    where (h3,h4) = head t

partidaEChegada :: Viagem -> (Hora,Hora)
partidaEChegada [] = error "viagem não pode ser vazia"
partidaEChegada v = (hi,hf)
    where (hi,_) = head v
          (_,hf) = last v

type Poligonal = [Ponto]

poligonal_ex = [Cartesiano 0 0, Cartesiano 2 0, Cartesiano 2 2, Cartesiano 0 2, Cartesiano 0 0]

comprimento :: Poligonal -> Double
comprimento (p1:p2:t) = dist p1 p2 + comprimento (p2:t)
comprimento _ = 0

{-data Figura = Circulo Ponto Double
            | Rectangulo Ponto Ponto
            | Triangulo Ponto Ponto Ponto
             deriving (Show,Eq)  já deu import da ficha 1
             -} 

triangula :: Poligonal -> [Figura]
triangula (p1:p2:p3:t) = if p1 /= p3 then Triangulo p1 p2 p3 : triangula (p1:p3:t) else []
triangula _ = []

data Contacto = Casa Integer
              | Trab Integer
              | Tlm Integer
              | Email String
              deriving Show
type Nome = String
type Agenda = [(Nome, [Contacto])]

agenda_ex = [("Sofia", [Tlm 912345678, Email "sofia@email.com"]),("Pedro", [Casa 253123456, Email "pedro@email.com"])]

acrescEmail :: Nome -> String -> Agenda -> Agenda
acrescEmail nome email [] = [(nome, [Email email])]
acrescEmail nome email ((nome_c, contactos):t)
    | nome == nome_c = ((nome_c, Email email : contactos):t)
    | otherwise = (nome_c, contactos) : acrescEmail nome email t

verEmails :: Nome -> Agenda -> Maybe [String]
verEmails _ [] = Nothing
verEmails nome ((nome_c,contactos):t)
    | nome == nome_c = Just (filtrarEmails contactos)
    | otherwise = verEmails nome t

filtrarEmails :: [Contacto] -> [String]
filtrarEmails [] = []
filtrarEmails (Email e : t) = e : filtrarEmails t
filtrarEmails (_:t) = filtrarEmails t

type Dia = Int
type Mes = Int
type Ano = Int

data Data = D Dia Mes Ano
    deriving Show

type TabDN = [(Nome,Data)]

anterior :: Data -> Data -> Bool
anterior (D dia1 mes1 ano1) (D dia2 mes2 ano2) = ano1 < ano2 || (ano1 == ano2 && mes1 < mes2) || (ano1 == ano2 && mes1 == mes2 && dia1 < dia2)

tab_ex = [("Sofia", D 31 08 2000), ("Pedro", D 04 04 2004), ("Paulo", D 08 10 1993)]

ordena :: TabDN -> TabDN
ordena [] = []
ordena (h:t) = inserirDN h (ordena t)

inserirDN :: (Nome,Data) -> TabDN -> TabDN
inserirDN (nome,data') [] = [(nome,data')]
inserirDN (nome,data') ((nomeT,dataT):t)
    | anterior dataT data' = (nomeT,dataT) : inserirDN (nome,data') t
    | otherwise = (nome,data') : (nomeT,dataT) : t


-- Exercício extra
-- numeros que têm indice par (começa no zero)

pares :: [a] -> [a] 
pares [] = []
pares (h:i:t) = h : pares t

impares :: [a] -> [a]
impares [] = []
impares (h:i:t) = i : impares t

pares' :: [a] -> [a]
pares' [] = []
pares' (h:t) = h : impares' t

impares' :: [a] -> [a]
impares' [] = []
impares' (h:t) = pares' t
