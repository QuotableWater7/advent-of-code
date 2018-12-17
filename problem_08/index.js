'use strict'

const fs = require('fs')

const makeNode = ({ children, metadataValues }) => ({
  children,
  metadataValues
})

const createChildrenNodes = n => numbers => {
  if (n === 0) {
    const node = makeNode({ children: [], metadataValues: [] })

    return [[node], numbers]
  }

  const [node, remaining] = createNodes(numbers)
  const [nodes, rest] = createChildrenNodes(n - 1)(remaining)

  return [[node, ...nodes], rest]
}

const createNodes = numbers => {
  const [numChildren, numMetadataValues, ...rest] = numbers

  if (numChildren === 0) {
    const metadataValues = rest.slice(0, numMetadataValues)
    const remaining = rest.slice(numMetadataValues)

    return [makeNode({ children: [], metadataValues }), remaining]
  }

  const [children, remaining2] = createChildrenNodes(numChildren)(rest)
  const metadataValues = remaining2.slice(0, numMetadataValues)

  return [
    makeNode({ children, metadataValues }),
    remaining2.slice(numMetadataValues)
  ]
}

const sumMetadataValues = node => {
  return (
    node.children.reduce(
      (childrenTotal, child) => childrenTotal + sumMetadataValues(child),
      0
    ) +
    node.metadataValues.reduce(
      (parentTotal, metadataValue) => parentTotal + metadataValue,
      0
    )
  )
}

const sumMetadataValuesPart2 = node => {
  return node.children.length > 0
    ? node.metadataValues.reduce((total, childIndex) => {
        const child = node.children[childIndex - 1]

        return total + (child ? sumMetadataValuesPart2(child) : 0)
      }, 0)
    : sumMetadataValues(node)
}

const input = fs.readFileSync(__dirname + '/input.txt', 'utf8')

const input2 = '2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2'

const solve = () => {
  const numbers = input.split(' ').map(Number)

  const [node, _] = createNodes(numbers)

  console.log(sumMetadataValues(node))
  console.log(sumMetadataValuesPart2(node))
}

solve()
