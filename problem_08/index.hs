import System.IO

data Node = Node [Node] [Int]

parseChildrenNodes :: Int -> [Int] -> ([Node], [Int])
parseChildrenNodes 0 list = do
  ([Node [] []], list)
parseChildrenNodes n list = do
  let (node, remaining) = parseNode list
  let (nodes, rest) = parseChildrenNodes (n - 1) remaining
  (nodes ++ [node], rest)

parseNode :: [Int] -> (Node, [Int])
parseNode (0:num_metadata_values:xs) = do
  let (metadata_values, rest) = splitAt num_metadata_values xs
  (Node [] metadata_values, rest)
parseNode [] = (Node [] [], [])
parseNode (num_child_nodes:num_metadata_values:xs) = do
  let (children, rest) = parseChildrenNodes num_child_nodes xs
  let (metadata_values, remaining_input) = splitAt num_metadata_values rest

  ((Node children metadata_values), remaining_input)

sumOfMetadata :: Node -> Int
sumOfMetadata (Node children metadata_values) = (foldr (+) 0 (map sumOfMetadata children)) + (foldr (+) 0 metadata_values)

main = do
  handle <- openFile "/Users/josephbowler/Documents/practice/advent-of-code/problem_08/input.txt" ReadMode
  contents <- hGetContents handle

  let numbers = map read (words contents)
  let (node, _) = parseNode numbers
  print . sumOfMetadata $ node
