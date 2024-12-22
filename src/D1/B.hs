module D1.B (main) where

getOddIndexElements :: [Int] -> [Int]
getOddIndexElements [] = []
getOddIndexElements numbers = [x | (x, i) <- zip numbers ([0 ..] :: [Int]), odd i]

getEvenIndexElements :: [Int] -> [Int]
getEvenIndexElements [] = []
getEvenIndexElements numbers = [x | (x, i) <- zip numbers ([0 ..] :: [Int]), even i]

calculateSimilarityScore :: [Int] -> [Int] -> Int
calculateSimilarityScore [] _ = 0
calculateSimilarityScore (ah : at) b = ah * length (filter (== ah) b) + calculateSimilarityScore at b

main :: IO ()
main = do
    contents <- readFile "input.txt"
    let numbers = map read (words contents) :: [Int]
    print $ calculateSimilarityScore (getEvenIndexElements numbers) (getOddIndexElements numbers)
