import System.IO
import Data.List

countOccurrences :: Eq a => [a] -> [(a, Int)]
countOccurrences [] = []
countOccurrences (x:xs) = do
  let (matching, rest) = span (\y -> y == x) xs

  [(x, 1 + (length matching))] ++ countOccurrences rest

numListsWithCharCount :: Int -> [[(Char, Int)]] -> Int
numListsWithCharCount n list = (length . (filter (any (\(ch, numOccurrences) -> numOccurrences == n)))) list

checksum :: [[(Char, Int)]] -> Int
checksum list = (numListsWithCharCount 2 list) * (numListsWithCharCount 3 list)

numDifferent :: [a] -> [a] -> Int
numDifferent [] list = length list
numDifferent list [] = length list
numDifferent (x:xy) (y:yy) =
  | x == y = numDifferent xy yy
  | otherwise = 1 + numDifferent xy yy

main = do
  handle <- openFile "/Users/josephbowler/Documents/practice/advent-of-code/problem_03/input.txt" ReadMode
  contents <- hGetContents handle

  let tags = words contents
  let occurrences = map (countOccurrences . sort) tags

  print $ checksum occurrences
