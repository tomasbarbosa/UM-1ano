import Graphics.Gloss.Interface.Pure.Game

type Estado = (Float,Float)

estadoInicial :: Estado
estadoInicial = (0,0)

desenhaEstado :: Estado -> Picture
desenhaEstado (x,y) = Translate x y $ Color red $ circleSolid 20

reageEvento :: Event -> Estado -> Estado
reageEvento (EventKey k@(SpecialKey KeyUp) Down _ _ ) ((x,y,) ks) = ((x,y+10), k:ks)
reageEvento (EventKey k@(SpecialKey KeyUp) Up _ _ ) ((x,y), ks) = ((x,y+10), delete k ks)
--reageEvento (EventKey (SpecialKey KeyLeft) Down _ _ ) (x,y) = (x-10,y)
--reageEvento (EventKey (SpecialKey KeyRight) Down _ _ ) (x,y) = (x+10,y)
reageEvento _ s = s


reageTempo :: Float -> Estado -> Estado
reageTempo _ ((x,y), []) = ((x,y), [])
reageTempo _ ((x,y), (k:ks)) = (efeitoKey k (x,y), ks)

step :: FLoat
step = 3


efeitoKey :: Key -> (Float,Float) -> (Float,Float)
efeitoKey (SpecialKey KeyUp) (x,y) = (x, y+1)
efeitoKey _ (x,y) = (x,y)


fr :: Int
fr = 50
