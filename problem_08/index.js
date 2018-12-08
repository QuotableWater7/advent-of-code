'use strict'

const fs = require('fs')

const calculateMetadataSum = ({ numbers, currentIndex = 0 }) => {
  const numChildNodes = numbers[currentIndex]
  const numMetadataEntries = numbers[currentIndex + 1]

  let numChildValues = 0
  let sumChildMetadata = 0

  for (let i = 0; i < numChildNodes; i++) {
    const [_numChildValues, _sumChildMetadata] = calculateMetadataSum({
      numbers,
      currentIndex: currentIndex + 2 + numChildValues
    })

    numChildValues += _numChildValues
    sumChildMetadata += _sumChildMetadata
  }

  const parentMetadataStart = currentIndex + 2 + numChildValues
  const parentMetadataEnd = parentMetadataStart + numMetadataEntries

  let sumParentMetadata = 0

  for (let i = parentMetadataStart; i < parentMetadataEnd; i++) {
    sumParentMetadata += numbers[i]
  }

  return [
    2 + numChildValues + numMetadataEntries,
    sumChildMetadata + sumParentMetadata
  ]
}

const input = fs.readFileSync(__dirname + '/input.txt', 'utf8')

const solve = () => {
  const numbers = input.split(' ').map(Number)

  const [_, total] = calculateMetadataSum({ numbers })

  console.log(total)
}

solve()
