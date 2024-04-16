
--2)

--a)
areaQuadrado :: Double -> Double
areaQuadrado a = a^2 

--b) 
perimetro :: Double -> Double -> Double
perimetro a b = a*2 + b*2

--c)
pertence :: String -> Char -> Bool
pertence s c = elem c s

--d)


--e)

primeiroEUltimo :: [a] -> (a,a)
primeiroEUltimo l = (head l, last l)

--f)
primeiroEUltimoNome :: [String] -> (String, String)
primeiroEUltimoNome a = primeiroEUltimo a

--g)

headPrimeiro :: ([a], [b]) -> (a, [b])
headPrimeiro (xs, ys) = (head xs, ys)

--h) 

abreviaNome :: [String] -> String
abreviaNome n = (head (head n)) : ( "." ++ last n ) 

