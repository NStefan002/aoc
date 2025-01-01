module D5.A (main) where

import Data.List (tails)
import qualified Data.Map as Map

-- Split a string by a given character
splitOn :: Char -> String -> [String]
splitOn c s = if untilC == s then [s] else untilC : splitOn c afterC
  where
    untilC = takeWhile (/= c) s
    afterC = drop 1 (dropWhile (/= c) s)

-- Check if an update is in the correct order
isInRightOrder :: Map.Map Int [Int] -> [Int] -> Bool
isInRightOrder comesAfter update = all (\(a, b) -> b `elem` Map.findWithDefault [] a comesAfter) pairs
  where
    pairs = [(x, y) | (x : ys) <- tails update, y <- ys]

addMiddleNumbers :: [[Int]] -> Int
addMiddleNumbers = foldl (\acc e -> acc + (e !! (length e `div` 2))) 0

main :: IO ()
main = do
    contents <- readFile "input.txt"
    let rules = map ((\p -> (read (head p) :: Int, read (p !! 1) :: Int)) . splitOn '|') (takeWhile (/= "") (lines contents))
        updates = map (map read . splitOn ',') (drop 1 (dropWhile (/= "") (lines contents)))
        comesAfterMap = Map.fromListWith (++) $ map (\(a, b) -> (a, [b])) rules
        validUpdates = filter (isInRightOrder comesAfterMap) updates
    print $ addMiddleNumbers validUpdates
