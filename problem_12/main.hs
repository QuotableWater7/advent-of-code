import System.IO

data Rule = Rule { configuration :: [Char], next_state :: Char }

-- map over a list, but each iteration of map provides n items from the list
-- e.g. [1, 2, 3, 4, 5] with chunkSize of 2 provides [1, 2], then [2, 3], then [3, 4], etc
chunkMap :: Int -> ([a] -> a) -> [a] -> [a]
chunkMap chunkSize fn [] = []
chunkMap chunkSize fn list
  | (length list) > chunkSize = (fn (take chunkSize list)) : (chunkMap chunkSize fn (tail list))
  | otherwise = [fn list]

-- from list of rules, find rule matching our configuration of 5 plants and then apply the next state
applyMatchingRule :: [Rule] -> [Char] -> Char
applyMatchingRule [] plants = (head . (drop 2)) plants
applyMatchingRule ((Rule configuration next_state):rule_tail) plants =
  if configuration == plants
    then next_state
    else applyMatchingRule rule_tail plants

-- take a list of rules, num_generations to apply, and a full plant configuration
-- return what that plant configuration looks like in num_generations of applying the rules
calculateConfiguration :: [Rule] -> Int -> [Char] -> [Char]
calculateConfiguration rules 0 list = list
calculateConfiguration rules numGenerations list = do
  calculateConfiguration rules (numGenerations - 1) (chunkMap 5 (applyMatchingRule rules) (".." ++ list ++ ".."))

parseRule :: [Char] -> Rule
parseRule letters = do
  Rule { configuration = take 5 letters, next_state = last letters }

main = do
  handle <- openFile "/Users/josephbowler/Documents/practice/advent-of-code/problem_12/input.txt" ReadMode
  contents <- hGetContents handle
  let file_lines = lines contents

  let input = snd . (splitAt 15) . head $ file_lines
  let rules = (map parseRule) . snd . (splitAt 2) $ file_lines

  let output = calculateConfiguration rules 20 input

  print input
  print output
