const fs = require('fs')

const DATA_REGEX = /Step (\w) must be finished before step (\w) can begin./

class Graph {
  constructor({ edges }) {
    this.adjacencyList = new Map()
    this.inDegrees = {}

    edges.forEach(edge => this.addEdge(edge))
  }

  addEdge({ v1, v2 }) {
    if (!this.adjacencyList.has(v1)) {
      this.adjacencyList.set(v1, [])
    }

    if (!this.adjacencyList.has(v2)) {
      this.adjacencyList.set(v2, [])
    }

    this.adjacencyList.get(v1).push(v2)

    if (!this.inDegrees.hasOwnProperty(v1)) {
      this.inDegrees[v1] = 0
    }

    this.inDegrees[v2] = (this.inDegrees[v2] || 0) + 1
  }

  printDependencyOrdering() {
    const inDegrees = { ...this.inDegrees }

    const solution = []

    while (Object.keys(inDegrees).length) {
      const first = Object.keys(inDegrees)
        .filter(key => inDegrees[key] === 0)
        .sort()[0]

      solution.push(first)

      delete inDegrees[first]

      const neighbors = this.adjacencyList.get(first)
      neighbors.forEach(neighbor => inDegrees[neighbor]--)
    }

    console.log(solution.join(''))
  }
}

const parseEdges = line => {
  const match = line.match(DATA_REGEX)

  const v1 = match[1]
  const v2 = match[2]

  return { v1, v2 }
}

const solve = () => {
  const fileLines = fs
    .readFileSync(__dirname + '/input2.txt', 'utf8')
    .split('\n')
    .filter(x => x.trim())

  const edges = fileLines.map(parseEdges)

  const graph = new Graph({ edges })

  graph.printDependencyOrdering()
}

solve()
