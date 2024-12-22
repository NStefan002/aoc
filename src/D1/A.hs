module D1.A (main) where

import Data.List (sort)

split :: Char -> String -> [String]
split _ "" = []
split c s = first : split c rest
  where
    first = takeWhile (/= c) s
    rest = drop (length first + 1) s

getOddIndexElements :: [Int] -> [Int]
getOddIndexElements [] = []
getOddIndexElements numbers = [x | (x, i) <- zip numbers [0 ..], odd i]

getEvenIndexElements :: [Int] -> [Int]
getEvenIndexElements [] = []
getEvenIndexElements numbers = [x | (x, i) <- zip numbers [0 ..], even i]

calculateDistances :: [Int] -> [Int] -> Int
calculateDistances [] [] = 0
calculateDistances (ah : at) (bh : bt) = abs (ah - bh) + calculateDistances at bt

main :: IO ()
main = do
    contents <- readFile "input.txt"
    let numbers = map read (words contents) :: [Int]
    print $ calculateDistances (sort (getEvenIndexElements numbers)) (sort (getOddIndexElements numbers))
