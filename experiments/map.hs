import qualified Data.Map as Map

main = do
  let input = [('a', 4), ('b', 5)]
  let map = Map.fromList input

  print map
