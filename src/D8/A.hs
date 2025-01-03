module D8.A (main) where

import qualified Data.Map as Map
import qualified Data.Set as Set

type Pos = (Int, Int)

getX :: Pos -> Int
getX = fst

getY :: Pos -> Int
getY = snd

getAntennaPositions :: [String] -> [(Char, Pos)]
getAntennaPositions antMap = [(ant, (x, y)) | (x, row) <- zip [0 ..] antMap, (y, ant) <- zip [0 ..] row, ant /= '.']

antinodePositionFromTwoAntennas :: Pos -> Pos -> [Pos]
antinodePositionFromTwoAntennas (x1, y1) (x2, y2) = [(x1 + diffX, y1 + diffY), (x2 - diffX, y2 - diffY)]
  where
    diffX = x1 - x2
    diffY = y1 - y2

allAntinodesPositions' :: [Pos] -> [Pos]
allAntinodesPositions' positions = foldl (\acc e -> acc ++ uncurry antinodePositionFromTwoAntennas e) [] pairs
  where
    pairs :: [(Pos, Pos)]
    pairs = [(x, y) | x <- positions, y <- positions, x > y]

allAntinodesPositions :: [(Char, [Pos])] -> [Pos]
allAntinodesPositions = foldl (\acc e -> acc ++ allAntinodesPositions' (snd e)) []

removeDuplicates :: [Pos] -> [Pos]
removeDuplicates l = Set.toList (Set.fromList l)

filterValidAntinodes :: Int -> Int -> [Pos] -> [Pos]
filterValidAntinodes maxX maxY positions =
    removeDuplicates $
        filter (\e -> getX e >= 0 && getX e <= maxX && getY e >= 0 && getY e <= maxY) positions

main :: IO ()
main = do
    contents <- readFile "input.txt"
    let antMap = lines contents
        maxX = length (head antMap) - 1
        maxY = length antMap - 1
        antPositions = Map.toList (Map.fromListWith (++) $ map (\(a, b) -> (a, [b])) (getAntennaPositions antMap))
    print $ length $ filterValidAntinodes maxX maxY (allAntinodesPositions antPositions)
