module Revisoes6to12 where
import Data.List
import Data.Char




-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
------------------------------------------------------------------------------- 

--Semana 6


--esta função serve para ordenar as listas através de listas de compressão
qsort :: (Ord a) => [a] -> [a]
qsort [] = [] --caso de paragem : quando a lista não tiver mais elementos
qsort (x:xs) = 
   (qsort [y | y<-xs, y<x]) -- elementos menores que x que vão ficar à direita
   ++ [x] -- x, que vai servir como o elemento para comparar os números
   ++ (qsort [y | y <- xs, y>x]) -- elementos maiores que x que vão ficar à esquerda


--calcular as posições onde um elemento está através da função zip e de listas de compressão
posicoes :: Eq a => a -> [a] -> [Int]
posicoes x l = [i | (y,i) <- zip l [0..], x == y]

--calcular os divisores de um nº > 0
divisores :: Integer -> [Integer] 
divisores n = [x |x <- [1..n], n `mod` x == 0]

--crivo de erastotenes, ele começa por [2..n] e elimina todos os nºs multiplos de 2, depois segue para o próximo nº e faz o mesmo até a lista se esgotar
crivo [] = []
crivo (x:xs) = x : crivo [n | n<-xs, n `mod` x /= 0]

--dá uma lista infinita de nº primos
primos :: [Integer]
primos = crivo [2..]

--esta função dado um nº > 1, vai devolver um produto entre nºs primos
fatoriza :: Integer -> [Integer] 
fatoriza n = aux n primos
    where aux 1 _ = []
          aux n (x:xs)
            | n `mod` x /= 0 = aux n xs
            | otherwise = x : aux (n `div` x) (x:xs)

--esta função aplica f(x) a cada elemento da lista já está definida

map' :: (a -> b) -> [a] -> [b]
map' f [] = []
map' f (x:xs) = (f x) : (map f xs)

--exemplos do uso da função map
triplos :: [Int] -> [Int]
triplos l = map (3*) l

maiusculas :: String -> String
maiusculas xs = map (toUpper) xs

somapares :: [(Float,Float)] -> [Float]
somapares l = map aux l
   where aux (a,b) = a+b

--esta função de ordem superior recebe uma condição e testa em cada elemento da lista, devolvendo o que respeita a condição
filter' :: (a -> Bool) -> [a] -> [a]
filter' p [] = []
filter' p (x:xs)
   | p x = x : filter' p xs
   | otherwise = filter' p xs

--exemplos do uso da função filter
pares :: [Int] -> [Int]
pares l = filter' even l


--funções anónimas
funcao1 :: Int -> Int
funcao1 = (\x -> x+x)


--exemplo


trocapares :: [(a,b)] -> [(b,a)]

--em vez de 
{-
trocapares l = map troca l
   where troca (x,y) = (y,x)
-}

--escreve-se
trocapares l = map (\(x,y) -> (y,x)) l


multiplosDe :: Int -> [Int] -> [Int]
multiplosDe n l = filter' (\x -> mod x n == 0) l


--------------------------------------------------------
--Ficha 5

--1 
--a)

any' :: (a -> Bool) -> [a] -> Bool
any' f [] = False 
any' f (x:xs) 
   | f x = True
   | otherwise = any' f xs

--b)

zipWith' :: (a->b->c) -> [a] -> [b] -> [c]
zipWith' f (x:xs) (h:t) = f x h : zipWith' f xs t
zipWith' _ _ _ = []

--c) 
takeWhile' :: (a->Bool) -> [a] -> [a] 
takeWhile' _ [] = []
takeWhile' f (x:xs) 
   | f x = x : takeWhile' f xs
   | otherwise = []

--d) 
dropWhile' :: (a -> Bool) -> [a] -> [a]
dropWhile' _ [] = []
dropWhile' f (x:xs)
   | f x = dropWhile' f xs
   | otherwise = xs

--e)
span' :: (a -> Bool) -> [a] -> ([a],[a])
span' f (h:t) 
   | f h = (h:s1,s2)
   | otherwise = ([],h:t)
      where (s1,s2) = span' f t
   

--f)
deleteBy' :: (a -> a -> Bool) -> a -> [a] -> [a]
deleteBy' f a (x:xs) 
   | f a x = xs
   | otherwise = x : deleteBy' f a xs

-------

--2
type Polinomio = [Monomio]
type Monomio = (Float,Int)

--a)
selgrau :: Int -> Polinomio -> Polinomio
selgrau n l = filter (\(c,g) -> g == n) l

--b)
conta :: Int -> Polinomio -> Int
conta n p = length (filter (\x -> n == snd x) p)

--c)
grau :: Polinomio -> Int
grau l =  snd (maximumBy (\(c1,g1) (c2,g2) -> compare g1 g2) l) 

--------





--3

type Mat a = [[a]]

--a)
dimOK :: Mat a -> Bool 
dimOK (h:t) = all (\x -> length h == length x) t

--b)
dimMat :: Mat a -> (Int,Int)
dimMat m = (length m, (length.head) m)

--h)
rotateLeft :: Mat a -> Mat a
rotateLeft m = [ [ map (!! i) m !! j | j <- [0..l-1] ] | i <- [c-1,c-2..0]] 
    where (l,c) = dimMat m

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
------------------------------------------------------------------------------- 

--Semana 7

-- função (.) - composição de funções (como se fosse um 'após')
ponto :: (b-> c) -> (a -> b) -> a -> c
ponto f g x = f (g x)

--exemplo
ultimo :: [a] -> a
ultimo = head.reverse -- vai fazer reverse e buscar o primeiro, logo vai buscar o último

-- função flip - troca a ordem dos argumentos
flip' :: (a -> b -> c) -> b -> a -> c
flip' f x y = f y x

--exemplo
mytake :: [a] -> Int -> [a]
mytake = flip take

-- função curry - recebe 2 elementos e transforma-os num par e depois calcula a função dada
curry' :: ((a,b) -> c) -> a -> b -> c
curry' f x y = f(x,y)

--ex 
-- curry fst 1 2
-- 1

-- função uncurry - recebe um par, separa e depois calcula a função dada
uncurry' :: ( a -> b -> c) -> (a,b) -> c
uncurry' f (x,y) = f x y

--ex
-- uncurry (+) (1,2)
-- 3

-- funções zipWith, takeWhile, dropWhile, span na ficha 6

-- função break - dado uma função f e uma lista, ela pega na lista e separa num par nas que não respeitam a condição das que respeitam a mesma
break' :: (a -> Bool) -> [a] -> ([a],[a])
break' f l = span (not.f) l

--exemplo
-- break (>10) [3,4,5,30,8,12,9]
--([3,4,5],[30,8,12,9])

{- 
foldr (right fold) começa pela direita para a esquerda

foldr f z (x1:x2:...:xn:[]) == x1 `f`(x2 `f`(... `f`(xn `f` z)...))

exemplo

foldr (*) 0 [1,2,3] == 1 * (2 * (3 * 0))

-}

foldr' :: (a -> b -> b) -> b -> [a] -> b
foldr' f z [] = z
foldr' f z (x:xs) = f x (foldr' f z xs)

--funções que podem ser definidas através do foldr
 
reverse' :: [a] -> [a]
reverse' l = foldr (\x r -> r++[x]) [] l

length' :: [a] -> Int
length' = foldr (\h r -> 1+r) 0

{- 
foldl (left fold) começa pela esq para a drt

foldl f z [x1,x2,...,xn] == (.. ((z `f` x1 ) `f`x2) ...) `f` xn

exemplo

foldl (+) 0 [1,2,3] == ((0 + 1) + 2) + 3

-}

myfoldl :: (b -> a -> b) -> b -> [a] -> b
myfoldl f z [] = z
myfoldl f z (x:xs) = myfoldl f (f z x) xs

--funções que podem ser definidas através do foldl

sumAc [] ac = ac
sumAc (x:xs) ac = sumAc xs (ac+x)

--------------------------------------------------------
--Ficha - não tem ficha sobre foldr nem foldl

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
------------------------------------------------------------------------------- 

--Semana 8

--Árvores

data BTree a = Empty
           | Node a (BTree a) (BTree a)
  deriving (Show)



--Node :: a -> (BTree a) -> (BTree a) -> (BTree a)

{-ex de árvores binárias : 

arv1 = Node 5 Empty Empty

arv2 = Node 8 Empty arv1

arv3 = Noed 1 arv 1 arv 2

-}

-- exemplos

-- calcular o nº de nodos da árvore

contaBT :: BTree a -> Int
contaBT Empty = 0
contaBT (Node x e d) = 1 + contaBT e + contaBT d

-- somar todos os nodos de uma árvore de números

sumBT :: Num a => BTree a -> a
sumBT Empty = 0
sumBT (Node x e d) = x + sumBT e + sumBT d

-- altura de uma árvore

altura :: BTree a -> Int
altura Empty = 0
altura (Node x e d) = 1 + max (altura e) (altura d)

-- funções map e zip para árvores binárias

mapBT :: (a -> b) -> BTree a -> BTree b
mapBT f Empty = Empty
mapBT f (Node x e d) = Node (f x) (mapBT f e) (mapBT f d)

zipBT :: BTree a -> BTree b -> BTree (a,b)
zipBT Empty Empty = Empty
zipBT (Node x e1 d1) (Node y e2 d2) = Node (x,y) (zipBT e1 e2) (zipBT d1 d2)

----------

--travessia de árvores binárias

--preorder - ordem de visita , raiz, esq, drt

preorder :: BTree a -> [a]
preorder Empty = []
preorder (Node x e d) = [x] ++ (preorder e) ++ (preorder d)

--inorder - esq, raiz, drt
inorder :: BTree a -> [a]
inorder (Node x e d) = (inorder e) ++ [x] ++ (inorder d)


--postorder- esq, drt, raiz
postorder :: BTree a -> [a]
postorder (Node x e d) = (inorder e) ++ (inorder d) ++ [x]

----------

--árvores binárias de procura

--todos os elementos da árvore da esquerda são menores que a raiz, todos os elementos da direita são maiores que a raiz

--exemplos

--testar se um elemento pertence a uma árvore binária de procura

elemBT :: Ord a => a -> BTree a -> Bool
elemBT x Empty = False
elemBT x (Node y e d)
      | x < y = elemBT x e
      | x > y = elemBT x d
      | x == y = True

-- inserir um elemento numa árvore binária de procura

insertBT :: Ord a => a -> BTree a -> BTree a
insertBT x Empty = Node x Empty Empty
insertBT x (Node y e d)
         | x < y = Node y (insertBT x e) d
         | x > y = Node y e (insertBT x d)
         | x == y = Node y e d


-- função que converte uma lista numa árvore, inserindo os elementos pela ordem que aparecem

listToBT :: Ord a => [a] -> BTree a
listToBT l = foldl (flip insertBT) Empty l


--------------------------------------------------------
--Ficha 6

--1 

--a)
alturaBT :: BTree a -> Int
alturaBT Empty = 0
alturaBT (Node x e d) = 1 + max (alturaBT e) (alturaBT d)

--b)
contaNodos :: BTree a -> Int
contaNodos Empty = 0
contaNodos (Node x e d) = 1 + (contaNodos e) + (contaNodos d)

--c)
folhasBT :: BTree a -> Int
folhasBT Empty = 0
folhasBT (Node _ Empty Empty) = 1
folhas (Node _ e d) = folhasBT e + folhasBT d
      
--d)
prune :: Int -> BTree a -> BTree a
prune _ Empty = Empty
prune 0 _ = Empty
prune x (Node y e d) = Node y (prune (x-1) e) (prune (x-1) d)


--e)
pathBT :: [Bool] -> BTree a -> [a]
pathBT _ Empty = []
pathBT [] (Node x e d) = [x]
pathBT (h:t) (Node x e d) = x : pathBT t (if h == False  then e else d)

--f)
mirror :: BTree a -> BTree a
mirror Empty = Empty
mirror (Node x e d) = Node x (mirror d) (mirror e)

--g)
zipWithBT :: (a -> b -> c) -> BTree a -> BTree b -> BTree c
zipWithBT f (Node x e1 d1) (Node y e2 d2) = Node (f x y) (zipWithBT f e1 e2 ) (zipWithBT f d1 d2)
zipWithBT _ _ _ = Empty

--h)
unzipBT :: BTree (a,b,c) -> (BTree a,BTree b,BTree c)
unzipBT Empty = (Empty,Empty,Empty)
unzipBT (Node (x,y,z) e d) = (Node x unzipE1 unzipD1, Node y unzipE2 unzipD2, Node z unzipE3 unzipD3)
      where (unzipE1, unzipE2, unzipE3) = unzipBT e
            (unzipD1, unzipD2, unzipD3) = unzipBT d

--2

--a)
minimoBT :: Ord a => BTree a -> a
minimoBT (Node x Empty _) = x
minimoBT (Node x e d) = minimoBT e

--b)
semMinimoBT :: Ord a => BTree a -> BTree a
semMinimoBT (Node _ Empty _) = Empty
semMinimoBT (Node x e d) = Node x (semMinimoBT e) d

--3
type Aluno = (Numero,Nome,Regime,Classificacao)
type Numero = Int
type Nome = String
data Regime = ORD | TE | MEL deriving Show
data Classificacao = Aprov Int
                   | Rep
                   | Faltou
   deriving Show
type Turma = BTree Aluno --  ́arvore binaria de procura (ordenada por numero)


turma1 :: Turma
turma1 = (Node (15,"Luís",ORD,Aprov 14) (Node (12,"Joana",MEL,Faltou) (Node (7,"Diogo",TE,Rep) Empty
                                                                                               Empty) 
                                                                      (Node (14,"Lara",ORD,Aprov 19) Empty
                                                                                                     Empty))
                                        (Node (20,"Pedro",TE,Aprov 10) Empty
                                                                       (Node (25,"Sofia",ORD,Aprov 20) (Node (23,"Rita",ORD,Aprov 17) Empty
                                                                                                                                      Empty)
                                                                                                       (Node (28,"Vasco",MEL,Rep) Empty
                                                                                                                                  Empty))))

--a)
inscNum :: Numero -> Turma -> Bool
inscNum n Empty = False
inscNum n (Node (num,_,_,_) e d) = n == num || inscNum n (if n < num then e else d)

--b)
inscNome :: Nome -> Turma -> Bool
inscNome _ Empty = False
inscNome n (Node (_,nom,_,_) e d) = n == nom || inscNome n e || inscNome n d

--c)
trabEst :: Turma -> [(Numero,Nome)]
trabEst Empty = []
trabEst (Node (num,nom,reg,_) e d) = case reg of TE -> [(num,nom)];otherwise -> [] ++ trabEst e ++ trabEst d

--d)
nota :: Numero -> Turma -> Maybe Classificacao
nota n (Node (num,_,_,clas) e d) 
      | n == num = Just clas
      | n < num = nota n e
      | n > num = nota n d

nota _ _ = Nothing

--e)
percFaltas :: Turma -> Float
percFaltas Empty = 0
perFaltas turma = sumFaltas turma / numAlunos turma * 100
   where sumFaltas Empty = 0
         sumFaltas ( Node (_,_,_,clas) e d) = (case clas of Faltou -> 1;otherwise -> 0) + sumFaltas e + sumFaltas d
         numAlunos Empty = 0
         numAlunos (Node x e d) = 1 + numAlunos e + numAlunos d


--f)
mediaAprov :: Turma -> Float 
mediaAprov Empty = 0
mediaAprov turma = sumNotas turma / numNotas turma
   where sumNotas Empty = 0
         sumNotas (Node (_,_,_,Aprov nota) e d) = fromIntegral nota + sumNotas e + sumNotas d
         numNotas (Node (_,_,_,clas) e d) = (case clas of Aprov nota -> 1;otherwise -> 0) + numNotas e + numNotas d
         numNotas _ = 0

--g)
aprovAv :: Turma -> Float
aprovAv Empty = 0
aprovAv turma = a / b
    where (a,b) = aux turma
          aux Empty = (0,0)
          aux (Node (_,_,_,clas) l r) = case clas of Aprov nota -> (x+1,y) ; Rep -> (x,y+1) ; otherwise -> (x,y)
            where (x,y) = (c+e,d+f)
                  (c,d) = aux l
                  (e,f) = aux r

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
------------------------------------------------------------------------------- 

-- Semana 9

--árvores balanceadas 

{- 
uma árvore é balanceada se verifica as seguintes condições: 

- as alturas das sub arvores da direita e da esq diferem no máximo em uma unidade
- ambas as sub arvores são balanceadas

-}
 --para balancear uma árvore de procura, primeiro deve-se gerar uma lista ordenada com os seus elementos (inorder (ordem : e x d)) e depois gerar a árvore

balanceBTP :: BTree a -> BTree a
balanceBTP t = constroi (inorder t)


constroi :: [a] -> BTree a
constroi [] = Empty
constroi l = let n = length l
                 (l1, x:l2) = splitAt (n `div` 2) l in Node x (constroi l1) (constroi l2)


--árvores irregulares

--rose trees -- árvores com mais do que 2 nodes ligadas à raiz, a rose tree pede uma raiz e uma lista com as subdivisoes da lista

data RTree a = R a [RTree a]
    deriving Show
{-
R :: a -> [RTree a] -> RTree a

-}
contaRT :: RTree a -> Int
contaRT (R x l) = 1 + sum (map contaRT l)

alturaRT :: RTree a -> Int
alturaRT (R x []) = 1
alturaRT (R x l) = 1 + maximum (map alturaRT l)

pertenceRT :: Eq a => a -> RTree a -> Bool
pertenceRT x (R y l) = x == y || or (map (pertenceRT x) l)

preorderRT (R x l) = x : concat (map preorderRT l)


--outros tipos de árvores

--Leaf trees

data LTree a = Tip a
     | Fork (LTree a) (LTree a)

--Full trees
data FTree a b = Leaf b
     | No a (FTree a b) (FTree a b)

--------------------------------------------------------
--Ficha 7

--1

data ExpInt = Const Int
            | Simetrico ExpInt
            | Mais ExpInt ExpInt
            | Menos ExpInt ExpInt
            | Mult ExpInt ExpInt


--a)
calculaExp :: ExpInt -> Int
calculaExp (Const n) = n
calculaExp (Simetrico x) = (- calculaExp x)
calculaExp (Mais a b) = calculaExp a + calculaExp b
calculaExp (Menos a b) = calculaExp a - calculaExp b
calculaExp (Mult a b) = calculaExp a * calculaExp b


--b)
infixa :: ExpInt -> String
infixa (Const n) = show n
infixa (Simetrico exp) = "(-" ++ infixa exp ++ ")"
infixa (Mais x y) = "(" ++ infixa x ++ "+" ++ infixa y ++ ")"
infixa (Menos x y) = "(" ++ infixa x ++ "-" ++ infixa y ++ ")"
infixa (Mult x y) = '(':infixa x ++ "*" ++ infixa y ++ ")"


--c)
posfixa :: ExpInt -> String
posfixa (Const n) = show n ++ " "
posfixa (Simetrico exp) = "-" ++ posfixa exp
posfixa (Mais a b) = posfixa a ++ posfixa b ++ "+ "
posfixa (Menos a b) = posfixa a ++ posfixa b ++ "- "
posfixa (Mult a b) = posfixa a ++ posfixa b ++ "* "

--2
rtree1 = R 6 [R 4 [R 7 [R 1 [],
                        R 3 []],
                   R 9 []],
              R 3 [R 12 []],
              R 6 [],
              R 11 []]

              

--a)
somaRT :: Num a => RTree a -> a
somaRT (R r []) = r
somaRT (R r l) = r + sum (map (somaRT) l) 

--b)
alturaRTe :: RTree a -> Int
alturaRTe (R r []) = 1
alturaRTe (R r l) = 1 + maximum (map alturaRTe l)

--c)
pruneRT :: Int -> RTree a -> RTree a
pruneRT 0 (R r l) = R r []
pruneRT n (R r l) = R r (map (pruneRT (n-1)) l)  


--d)
mirrorRT :: RTree a -> RTree a
mirrorRT (R r l) = R r (map mirrorRT (reverse l))

--e)
postorderRT :: RTree a -> [a]
--postorder -- ordem : e d x
postorderRT (R r []) = [r]
postorderRT (R r l) = concatMap postorderRT l ++ [r]


--3

--a)
sumLT :: Num a => LTree a -> a
sumLT (Tip n) = n
sumLT (Fork a b) = sumLT a + sumLT b

--b)
listaLT :: LTree a -> [a] 
listaLT (Tip n) = [n]
listaLT (Fork a b) = listaLT a ++ listaLT b

--c)
alturaLT :: LTree a -> Int
alturaLT (Tip n) = 0
alturaLT (Fork a b) = 1 + max (alturaLT a) (alturaLT b)

--4

--a)
splitFT :: FTree a b -> (BTree a, LTree b)
splitFT (Leaf n) = (Empty, Tip n)
splitFT (No r e d) = (Node r (fst (splitFT e)) (fst (splitFT d)), Fork (snd (splitFT e)) (snd (splitFT d)))

--b)
joinTrees :: BTree a -> LTree b -> Maybe (FTree a b)
joinTrees (Empty) (Tip n) = Just (Leaf n)
joinTrees (Node r e d) (Fork a b) = Just (No r aux1 aux2)
   where Just aux1 = joinTrees e a
         Just aux2 = joinTrees d b

joinTrees _ _ = Nothing


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
------------------------------------------------------------------------------- 

--Classes e instâncias

{-
para declarar a classe Int e Float como pertencendo à classe Num tẽm de se fazer as seguintes declarações de instância

instance Num Int where
   (+) = primPlusInt
   (*) = primMultInt

instance Num Float where
   (+) = primPlusFloat
   (*) = primMultFloat
   
-}

--------------------------------------------------------
--Ficha 8

--1
data Frac = F Integer Integer

--a)
normaliza :: Frac -> Frac
normaliza (F a b) 
      | b < 0 = normaliza (F (-a) (-b))  
      | otherwise = let d = mdc a b in F (a `div` d) (b `div` d)

mdc :: Integer -> Integer -> Integer
mdc  x 0 = x
mdc 0 y = y
mdc x y = mdc y (x `mod` y)

--b)
instance Eq Frac where
   (==) :: Frac -> Frac -> Bool
   f1 == f2 = a1 == a2 && b1 == b2
         where F a1 b1 = normaliza f1
               F a2 b2 = normaliza f2

--c) 
instance Ord Frac where
   (<=) :: Frac -> Frac -> Bool
   f1 <= f2 = a1 * b2 <= a2 * b1
      where F a1 b1 = normaliza f1
            F a2 b2 = normaliza f2

--d)
instance Show Frac where
   show :: Frac -> String
   show f = show a ++ "/" ++ show b
         where F a b = normaliza f

--e)
instance Num Frac where
   (+) :: Frac -> Frac -> Frac
   (F a b) + (F c d) = normaliza (F (a*d + b*c) (b * d))

   (-) :: Frac -> Frac -> Frac
   x-y = x + negate y

   (*) :: Frac -> Frac -> Frac
   (F a b) * (F c d) = normaliza (F (a*c) (b*d))

   negate :: Frac -> Frac
   negate (F a b) = normaliza $ F (-a) b

   abs :: Frac -> Frac
   abs f = F (abs a) (abs b)
      where F a b = normaliza f

   signum :: Frac -> Frac
   signum f = F (signum a) 1
        where F a b = normaliza f

   fromInteger :: Integer -> Frac
   fromInteger x = F x 1


--f)
fmdobro :: Frac -> [Frac] -> [Frac]
fmdobro (F n d) [] = []
fmdobro (F n d) (h:t) 
      | h > (2 *(F n d)) = h : fmdobro (F n d) t
      | otherwise = fmdobro (F n d) t

--2 

data Exp a = Consta a
 | Simetricoa (Exp a)
 | Maisa (Exp a) (Exp a)
 | Menosa (Exp a) (Exp a)
 | Multa (Exp a) (Exp a)
--a)
instance Show a => Show (Exp a) where
   show (Consta a) = show a
   show (Simetricoa a) = "(-" ++ show a ++ ")"
   show (Maisa a b) = "(" ++ show a ++ "+" ++ show b ++ ")"
   show (Menosa a b) = "(" ++ show a ++ "-" ++ show b ++ ")"
   show (Multa a b) = "(" ++ show a ++ "*" ++ show b ++ ")"


valorDe :: (Num a) => Exp a -> a
valorDe (Consta a) = a
valorDe (Simetricoa a) = - (valorDe a)
valorDe (Maisa a b) = valorDe a + valorDe b
valorDe (Menosa a b) = valorDe a - valorDe b
valorDe (Multa a b) = valorDe a * valorDe b

--b)
instance (Num a, Eq a) => Eq (Exp a) where
    (==) :: (Num a, Eq a) => Exp a -> Exp a -> Bool
    a == b = valorDe a == valorDe b


--c) 
instance (Ord a, Num a) => Num (Exp a) where
    (+) :: Num a => Exp a -> Exp a -> Exp a
    x + y = Maisa x y
    
    (-) :: Num a => Exp a -> Exp a -> Exp a
    x - y = Menosa x y
    
    (*) :: Num a => Exp a -> Exp a -> Exp a
    x * y = Multa x y
    
    negate :: Num a => Exp a -> Exp a
    negate (Simetricoa a) = a
    negate a = Simetricoa a
    
    fromInteger :: Num a => Integer -> Exp a
    fromInteger x = Consta (fromInteger x)
    
    abs :: (Ord a, Num a) => Exp a -> Exp a
    abs (Consta a) = Consta (abs a)
    abs (Simetricoa a) = abs a
    abs op = if valorDe op < 0 
             then negate op
             else op
    
    signum :: Num a => Exp a -> Exp a
    signum a | valorDe a < 0 = Consta (-1)
             | valorDe a == 0 = Consta 0
             | otherwise = Consta 1 


--3
data Movimento = Credito Float | Debito Float
data Data = D Int Int Int
data Extracto = Ext Float [(Data, String, Movimento)]

--a)
{-
instance Ord Data where
   compare :: Data -> Data -> Ordering
   compare (D dia1 mes1 ano1) (D dia2 mes2 ano2)
      | ano1 > ano2 || ano1 == ano2 && (mes1 > mes2 || mes1 == mes2 && dia1 > dia2) = GT
      | ano1 == ano2 && mes1 == mes2 && dia1 == dia2 = EQ
      | otherwise = LT

-}

---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------

-- TESTES




