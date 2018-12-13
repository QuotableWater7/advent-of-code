data Rule = Rule { configuration :: [Char], next_state :: Char }

chunkMap :: Int -> ([a] -> a) -> [a] -> [a]
chunkMap n fn [] = []
chunkMap n fn list
  | (length list) > n = (fn (take n list)) : (chunkMap n fn (tail list))
  | otherwise = [fn list]

applyMatchingRule :: [Rule] -> [Char] -> Char
applyMatchingRule [] plants = (head . (drop 2)) plants
applyMatchingRule ((Rule configuration next_state):rule_tail) plants =
  if configuration == plants
    then next_state
    else applyMatchingRule rule_tail plants

calculateConfiguration :: [Rule] -> Int -> [Char] -> [Char]
calculateConfiguration rules 0 list = list
calculateConfiguration rules numGenerations list = do
  calculateConfiguration rules (numGenerations - 1) (chunkMap 5 (applyMatchingRule rules) (".." ++ list ++ ".."))

main = do
  let rules = [Rule {configuration = ".###.", next_state = '#'},
               Rule {configuration = "#.##.", next_state = '.'},
               Rule {configuration = ".#.##", next_state = '#'},
               Rule {configuration = "...##", next_state = '.'},
               Rule {configuration = "###.#", next_state = '#'},
               Rule {configuration = "##.##", next_state = '.'},
               Rule {configuration = ".....", next_state = '.'},
               Rule {configuration = "#..#.", next_state = '#'},
               Rule {configuration = "..#..", next_state = '#'},
               Rule {configuration = "#.###", next_state = '#'},
               Rule {configuration = "##.#.", next_state = '.'},
               Rule {configuration = "..#.#", next_state = '#'},
               Rule {configuration = "#.#.#", next_state = '#'},
               Rule {configuration = ".##.#", next_state = '#'},
               Rule {configuration = ".#..#", next_state = '#'},
               Rule {configuration = "#..##", next_state = '#'},
               Rule {configuration = "##..#", next_state = '#'},
               Rule {configuration = "#...#", next_state = '.'},
               Rule {configuration = "...#.", next_state = '#'},
               Rule {configuration = "#####", next_state = '.'},
               Rule {configuration = "###..", next_state = '#'},
               Rule {configuration = "#.#..", next_state = '.'},
               Rule {configuration = "....#", next_state = '.'},
               Rule {configuration = ".####", next_state = '#'},
               Rule {configuration = "..###", next_state = '.'},
               Rule {configuration = "..##.", next_state = '#'},
               Rule {configuration = ".##..", next_state = '.'},
               Rule {configuration = "#....", next_state = '.'},
               Rule {configuration = "####.", next_state = '#'},
               Rule {configuration = ".#.#.", next_state = '.'},
               Rule {configuration = ".#...", next_state = '#'},
               Rule {configuration = "##...", next_state = '#'}]

  let input = "##.######...#.##.#...#...##.####..###.#.##.#.##...##..#...##.#..##....##...........#.#.#..###.#"

  let output = calculateConfiguration rules 20 input

  print input
  print output
