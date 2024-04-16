



data BTree a = Empty | Node a (BTree a) (BTree a) deriving Show

arvore = Node 5 (Node 2 (Node 1 Empty
                                Empty)
                        (Node 3 Empty
                                Empty))
                (Node 9 (Node 7 (Node 6 Empty 
                                        Empty)
                                (Node 8 Empty
                                        Empty))
                         Empty)


--1

--a)

altura :: BTree a -> Int
altura Empty = 0
altura (Node e l r ) = max (altura l) (altura r) + 1

contaNodos :: BTree a -> Int
contaNodos Empty = 0
contaNodos (Node _ l r) = 1 + contaNodos l + contaNodos r


prune :: Int -> BTree a -> BTree a
prune 0 _ = Empty
prune n (Node e l r) = (Node e (prune (n-1) l) (prune (n-1) r))

--f)
mirror :: BTree a -> BTree a 
mirror Empty = Empty
mirror (Node e l r) = (Node e (mirror r) (mirror l))

--g)
zipWithBT :: (a -> b -> c) -> BTree a -> BTree b -> BTree c
zipWithBT f Empty _ = Empty
zipWithBT f _ Empty = Empty
zipWithBT f (Node e1 l1 r1) (Node e2 l2 r2) = Node (f e1 e2) (zipWithBT f l1 l2) (zipWithBT f r1 r2)



--2)


minimo :: Ord a => BTree a -> a
minimo Empty = error "arvore vazia"
minimo (Node e Empty _) = e
minimo (Node e l r) = minimo l

semMinimo :: Ord a => BTree a -> BTree a
semMinimo Empty = error "arvore vazia"
semMinimo (Node e Empty _) = Empty
semMinimo (Node e l r) = Node e (semMinimo l) r


--3

type Aluno = (Numero,Nome,Regime,Classificacao)
type Numero = Int
type Nome = String
data Regime = ORD | TE | MEL deriving Show
data Classificacao = Aprov Int
                    | Rep
                    | Faltou
            deriving Show
type Turma = BTree Aluno

tEsts :: Turma -> [(Numero, Nome)]
tEsts Empty = []
tEsts (Node (numero, nome, TE, _) l r) = tEsts l ++ [(numero,nome)] ++ tEsts r
tEsts (Node _ l r) = tEsts l ++ tEsts r