import Graphics.Gloss

data Tile = TileA | TileB
drawTile :: Float -> Tile -> Picture
drawTile side TileB = Rotate (-90) $ drawTile side TileA
drawTile side TileA = Translate (-side/2) (side/2) $ Pictures [arc1, arc2]
        where arc1 = ThickArc (-90) 0 (side/2) 5
              arc2 = Translate side (-side) $ Rotate 190 arc1

drawList :: Float -> [Tile] -> Picture
drawList side [] = Blank
drawList side (h:t) = Pictures [desenhaTile, resto]
    where desenhaTile = drawTile side h
          resto = Translate side 0 $ drawList side t

drawList' :: Float -> [Tile] -> Picture
drawList' spc = Pictures . zipWith (\idx -> Translate (idx*spc) 0 . drawTile spc) [0..]

drawGrid :: Float -> [[Tile]] -> Picture
drawGrid side [] = Blank
drawGrid side (h:t) = Pictures [desenhaLinha, resto]
    where desenhaLinha = drawList side  -- falta algo
          resto = Translate 0 (-side) $ drawGrid side t
        