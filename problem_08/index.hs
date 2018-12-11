import System.IO

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
parseIntoNode (0:num_metadata_values:xs) = do
  let (metadata_values, rest) = splitAt num_metadata_values xs
  (Leaf metadata_values, rest)
parseIntoNode [] = (Null, [])
parseIntoNode (num_child_nodes:num_metadata_values:xs) = do
  let (children, rest) = extractNChildren num_child_nodes xs
  let (metadata_values, remaining_input) = splitAt num_metadata_values rest

  ((Parent children metadata_values), remaining_input)

sumOfMetadata :: Node -> Int
sumOfMetadata Null = 0
sumOfMetadata (Leaf []) = 0
sumOfMetadata (Leaf list) = foldr (+) 0 list
sumOfMetadata (Parent children metadata_values) = (foldr (+) 0 (map sumOfMetadata children)) + (foldr (+) 0 metadata_values)

main = do
  handle <- openFile "/Users/josephbowler/Documents/practice/advent-of-code/problem_08/input.txt" ReadMode
  contents <- hGetContents handle

  let numbers = map read (words contents)
  let (node, _) = parseIntoNode numbers
  print . sumOfMetadata $ node
