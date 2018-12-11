import System.IO
import Data.Char

data Node = Null | Leaf [Int] | Parent [Node] [Int] deriving(Show)

extractNChildren :: Int -> [Int] -> ([Node], [Int])
extractNChildren 1 list = do
  let (node, remaining) = parseIntoNode list

  ([node], remaining)
extractNChildren n list = do
  let (node, remaining) = parseIntoNode list
  let (nodes, rest) = extractNChildren (n - 1) remaining

  (nodes ++ [node], rest)


parseIntoNode :: [Int] -> (Node, [Int])
parseIntoNode (0:numMetadataValues:xs) = do
  (Leaf (take numMetadataValues xs), drop numMetadataValues xs)
parseIntoNode [] = (Null, [])
parseIntoNode (numChildNodes:numMetadataValues:xs) = do
  let (children, rest) = extractNChildren numChildNodes xs

  let metadata_values = take numMetadataValues rest
  let remaining_input = drop numMetadataValues rest

  ((Parent children metadata_values), remaining_input)

sumOfMetadata :: Node -> Int
sumOfMetadata Null = 0
sumOfMetadata (Leaf []) = 0
sumOfMetadata (Leaf (x:xs)) = x + sumOfMetadata (Leaf xs)
sumOfMetadata (Parent children metadata_values) = (foldr (+) 0 (map sumOfMetadata children)) + (sumOfMetadata (Leaf metadata_values))

-- tokenizeInput :: String -> [Int]
-- tokenizeInput [] = []
-- tokenizeInput (' ':xs) = tokenizeInput xs
-- tokenizeInput (x:xs) = [digitToInt x] ++ (tokenizeInput xs)

main = do
  -- handle <- openFile "/Users/josephbowler/Documents/practice/advent-of-code/problem_08/input.txt" ReadMode
  -- contents <- hGetContents handle

  -- print ((filter (/= '\n') contents))

  let (node, _) = parseIntoNode [2, 3, 0, 3, 10, 11, 12, 1, 1, 0, 1, 99, 2, 1, 1, 2]

  print . sumOfMetadata $ node
