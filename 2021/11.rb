require 'set'

ADJACENT = [
  [0, 1],
  [1, 1],
  [1, 0],
  [1, -1],
  [0, -1],
  [-1, -1],
  [-1, 0],
  [-1, 1],
]


input = DATA.readlines(chomp: true).map { |line| line.chars.map(&:to_i).freeze }.freeze
grid = input

Y_BOUNDS = 0...grid.length
X_BOUNDS = 0...grid.first.length

flashes = 0
i = 0

loop do
  i += 1
  flashing = []
  flashed = []

  new_grid = grid.map.with_index { |line, y|
    line.map.with_index { |energy, x|
      flashing << [x, y] if energy == 9
      energy + 1
    }
  }

  while !flashing.empty?
    x, y = flashing.pop

    ADJACENT.map { |dx, dy|
      [x + dx, y + dy]
    }.filter { |x_, y_|
      X_BOUNDS.include?(x_) && Y_BOUNDS.include?(y_)
    }.each { |x_, y_|
      value = new_grid[y_][x_] += 1
      if value == 10
        flashing << [x_, y_]
      end
    }

    flashed << [x, y]
  end

  flashes += flashed.length

  if i == 100
    puts flashes
  end

  flashed.each { |x, y|
    new_grid[y][x] = 0
  }

  if flashed.length == X_BOUNDS.size * Y_BOUNDS.size
    puts i
    break
  end

  grid = new_grid
end

__END__
7612648217
7617237672
2853871836
7214367135
1533365614
6258172862
5377675583
5613268278
8381134465
3445428733
