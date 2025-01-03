module D8.B (main) where

import qualified Data.Map as Map
import qualified Data.Set as Set

type Pos = (Int, Int)

getAntennaPositions :: [String] -> [(Char, Pos)]
getAntennaPositions antMap = [(ant, (x, y)) | (x, row) <- zip [0 ..] antMap, (y, ant) <- zip [0 ..] row, ant /= '.']

antinodePositionFromTwoAntennas :: Int -> Int -> Pos -> Pos -> [Pos]
antinodePositionFromTwoAntennas maxX maxY (x1, y1) (x2, y2) =
    [(x1 + n * diffX, y1 + n * diffY) | n <- [0 .. maxX], inBounds maxX maxY (x1 + n * diffX, y1 + n * diffY)]
        ++ [(x2 - n * diffX, y2 - n * diffY) | n <- [0 .. maxX], inBounds maxX maxY (x2 - n * diffX, y2 - n * diffY)]
  where
    diffX = x1 - x2
    diffY = y1 - y2

antinodesPositions' :: Int -> Int -> [Pos] -> [Pos]
antinodesPositions' maxX maxY positions = foldl (\acc e -> acc ++ uncurry (antinodePositionFromTwoAntennas maxX maxY) e) [] pairs
  where
    pairs :: [(Pos, Pos)]
    pairs = [(x, y) | x <- positions, y <- positions, x > y]

antinodesPositions :: Int -> Int -> [(Char, [Pos])] -> [Pos]
antinodesPositions maxX maxY l = filterValidAntinodes maxX maxY (foldl (\acc e -> acc ++ antinodesPositions' maxX maxY (snd e)) [] l)

removeDuplicates :: [Pos] -> [Pos]
removeDuplicates l = Set.toList (Set.fromList l)

inBounds :: Int -> Int -> Pos -> Bool
inBounds maxX maxY (x, y) = x >= 0 && x <= maxX && y >= 0 && y <= maxY

filterValidAntinodes :: Int -> Int -> [Pos] -> [Pos]
filterValidAntinodes maxX maxY positions = removeDuplicates (filter (inBounds maxX maxY) positions)

main :: IO ()
main = do
    contents <- readFile "input.txt"
    let antMap = lines contents
        maxX = length (head antMap) - 1
        maxY = length antMap - 1
        antPositions = Map.toList (Map.fromListWith (++) $ map (\(a, b) -> (a, [b])) (getAntennaPositions antMap))
    print $ length $ antinodesPositions maxX maxY antPositions
