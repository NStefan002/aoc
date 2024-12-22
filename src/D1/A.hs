module D1.A (main) where

import Data.List (sort)

getOddIndexElements :: [Int] -> [Int]
getOddIndexElements [] = []
getOddIndexElements numbers = [x | (x, i) <- zip numbers ([0 ..] :: [Int]), odd i]

getEvenIndexElements :: [Int] -> [Int]
getEvenIndexElements [] = []
getEvenIndexElements numbers = [x | (x, i) <- zip numbers ([0 ..] :: [Int]), even i]

calculateDistances :: [Int] -> [Int] -> Int
calculateDistances [] [] = 0
calculateDistances [] (_ : _) = 0
calculateDistances (_ : _) [] = 0
calculateDistances (ah : at) (bh : bt) = abs (ah - bh) + calculateDistances at bt

main :: IO ()
main = do
    contents <- readFile "input.txt"
    let numbers = map read (words contents) :: [Int]
    print $ calculateDistances (sort (getEvenIndexElements numbers)) (sort (getOddIndexElements numbers))
