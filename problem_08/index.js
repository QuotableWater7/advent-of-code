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

const calculateMetadataSumBetter = ({ numbers }) => {
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

const calculateMetadataSumPart2 = ({ numbers, currentIndex = 0 }) => {
  const numChildNodes = numbers[currentIndex]
  const numMetadataEntries = numbers[currentIndex + 1]

  let numChildValues = 0
  let sumChildMetadata = 0

  let childValues = [0]

  for (let i = 0; i < numChildNodes; i++) {
    const [_numChildValues, _sumChildMetadata] = calculateMetadataSumPart2({
      numbers,
      currentIndex: currentIndex + 2 + numChildValues
    })

    numChildValues += _numChildValues
    sumChildMetadata += _sumChildMetadata

    childValues.push(_sumChildMetadata)
  }

  const parentMetadataStart = currentIndex + 2 + numChildValues
  const parentMetadataEnd = parentMetadataStart + numMetadataEntries

  const parentMetadataValues = numbers.slice(
    parentMetadataStart,
    parentMetadataEnd
  )

  const value =
    numChildNodes > 0
      ? parentMetadataValues.reduce(
          (total, currentIndex) => total + (childValues[currentIndex] || 0),
          0
        )
      : parentMetadataValues.reduce((total, value) => total + value)

  return [2 + numChildValues + numMetadataEntries, value]
}

const input = fs.readFileSync(__dirname + '/input.txt', 'utf8')

const input2 = '2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2'

const solve = () => {
  const numbers = input.split(' ').map(Number)

  const [_, total] = calculateMetadataSumPart2({ numbers })

  console.log(total)
}

solve()
