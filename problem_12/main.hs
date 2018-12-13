data Rule = Rule { l2 :: Char, l1 :: Char, c :: Char, r1 :: Char, r2 :: Char, next_state :: Char } deriving (Show)

data Rules = Rules [Rule] deriving (Show)

data PlantConfiguration = PlantConfiguration [Char] deriving (Show)

calculateNextState :: Rules -> PlantConfiguration -> PlantConfiguration
calculateNextState rules input = do
  input

main = do
  let input = PlantConfiguration "#..#.#..##......###...###"
  let rules = Rules [Rule { l2 = '.', l1 = '#', c = '#', r1 = '#', r2 = '.', next_state = '#' }]

  let next_state = calculateNextState rules input

  print next_state
