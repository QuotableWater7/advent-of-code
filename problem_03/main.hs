import System.IO
import Data.List

countOccurrences :: Eq a => [a] -> [(a, Int)]
countOccurrences [] = []
countOccurrences (x:xs) = do
  let (matching, rest) = span (\y -> y == x) xs

  [(x, 1 + (length matching))] ++ countOccurrences rest

main = do
  handle <- openFile "/Users/josephbowler/Documents/practice/advent-of-code/problem_03/input.txt" ReadMode
  contents <- hGetContents handle

  let tags = words contents
  let occurrences = map (countOccurrences . sort) tags
  let with2 = (length . (filter (any (\(ch, numOccurrences) -> numOccurrences == 2)))) occurrences
  let with3 = (length . (filter (any (\(ch, numOccurrences) -> numOccurrences == 3)))) occurrences

  print (with2 * with3)
