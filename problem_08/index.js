'use strict'

const fs = require('fs')

const calculateMetadataSum = numbers => {
  const [numChildNodes, numMetadataEntries, ...remainingData] = numbers

  let numChildValues = 0
  let sumChildMetadata = 0

  for (let i = 0; i < numChildNodes; i++) {
    const [_numChildValues, _sumChildMetadata] = calculateMetadataSum(
      remainingData.slice(numChildValues)
    )

    numChildValues += _numChildValues
    sumChildMetadata += _sumChildMetadata
  }

  const parentMetadataValues = remainingData.slice(
    numChildValues,
    numChildValues + numMetadataEntries
  )

  const sumParentMetadata = parentMetadataValues.reduce(
    (total, curr) => total + curr
  )

  return [
    2 + numChildValues + numMetadataEntries,
    sumChildMetadata + sumParentMetadata
  ]
}

const input = fs.readFileSync(__dirname + '/input.txt', 'utf8')

const solve = () => {
  const numbers = input.split(' ').map(Number)

  const [_, total] = calculateMetadataSum(numbers)

  console.log(total)
}

solve()
