const fs = require('fs')

const { createCanvas } = require('canvas')

const DATA_REGEX = /position=< *(-?\d+), *(-?\d+)> velocity=< *(-?\d+), *(-?\d+)>/

const input = fs.readFileSync(__dirname + '/input.txt', 'utf8')

const parseVector = line => {
  const matches = line.match(DATA_REGEX)

  return {
    x: Number(matches[1]),
    y: Number(matches[2]),
    dx: Number(matches[3]),
    dy: Number(matches[4])
  }
}

const renderVectors = async ({ vectors, iterations = 0 }) => {
  const canvas = createCanvas(500, 500)
  const ctx = canvas.getContext('2d')

  const out = fs.createWriteStream(__dirname + `/images/img_${iterations}.png`)

  vectors.forEach(({ x, y }) => {
    if (x >= 0 && x <= 500 && y >= 0 && y <= 500) {
      ctx.fillRect(x, y, 1, 1)
    }
  })

  const stream = canvas.createPNGStream()
  stream.pipe(out)

  if (iterations > 300) {
    return
  }

  renderVectors({
    vectors: vectors.map(({ x, y, dx, dy }) => ({
      x: x + dx,
      y: y + dy,
      dx,
      dy
    })),
    iterations: iterations + 1
  })
}

async function main() {
  const vectors = input
    .split('\n')
    .filter(x => x)
    .map(parseVector)
    .map(({ x, y, dx, dy }) => ({
      x: x + dx * 10500,
      y: y + dy * 10500,
      dx,
      dy
    }))

  renderVectors({ vectors })
}

main()
