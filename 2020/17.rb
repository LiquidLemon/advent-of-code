data = DATA.each_line.map { |l| l.chomp.chars }

grid_3d = data.each_with_object(Hash.new(false)).with_index { |(row, hash), y|
  row.each_with_index { |c, x|
    if c == ?#
      hash[[x, y, 0]] = true
    end
  }
}

def count_neighbors_3d(grid, x, y, z)
  count = 0
  (-1..1).each { |dx|
    (-1..1).each { |dy|
      (-1..1).each { |dz|
        itself = dx == 0 && dy == 0 && dz == 0
        if !itself && grid[[x + dx, y + dy, z + dz]]
          count += 1
        end
      }
    }
  }
  count
end

def step_3d(grid)
  x_begin, y_begin, z_begin = Array.new(3) { Float::INFINITY }
  x_end, y_end, z_end = Array.new(3) { -Float::INFINITY }

  grid.keys.each { |x, y, z|
    x_begin = x if x < x_begin
    x_end = x if x > x_end
    y_begin = y if y < y_begin
    y_end = y if y > y_end
    z_begin = z if z < z_begin
    z_end = z if z > z_end
  }

  xr = (x_begin-1..x_end+1)
  yr = (y_begin-1..y_end+1)
  zr = (z_begin-1..z_end+1)

  new = Hash.new(false)
  xr.each { |x|
    yr.each { |y|
      zr.each { |z|
        count = count_neighbors_3d(grid, x, y, z)
        coords = [x, y, z]
        if grid[coords]
          new[coords] = (count == 2 || count == 3)
        else
          new[coords] = count == 3
        end
      }
    }
  }
  new
end

state = grid_3d
6.times { |i|
  state = step_3d(state)
}

puts state.values.filter(&:itself).size

grid_4d = data.each_with_object(Hash.new(false)).with_index { |(row, hash), y|
  row.each_with_index { |c, x|
    if c == ?#
        hash[[x, y, 0, 0]] = true
    end
  }
}

def count_neighbors_4d(grid, x, y, z, w)
  count = 0
  (-1..1).each { |dx|
    (-1..1).each { |dy|
      (-1..1).each { |dz|
        (-1..1).each { |dw|
          itself = dx == 0 && dy == 0 && dz == 0 && dw == 0
          if !itself && grid[[x + dx, y + dy, z + dz, w + dw]]
            count += 1
          end
        }
      }
    }
  }
  count
end

def step_4d(grid)
  x_begin, y_begin, z_begin, w_begin = Array.new(4) { Float::INFINITY }
  x_end, y_end, z_end, w_end = Array.new(4) { -Float::INFINITY }

  grid.keys.each { |x, y, z, w|
    x_begin = x if x < x_begin
    x_end = x if x > x_end
    y_begin = y if y < y_begin
    y_end = y if y > y_end
    z_begin = z if z < z_begin
    z_end = z if z > z_end
    w_begin = w if w < w_begin
    w_end = w if w > w_end
  }

  xr = (x_begin-1..x_end+1)
  yr = (y_begin-1..y_end+1)
  zr = (z_begin-1..z_end+1)
  wr = (w_begin-1..w_end+1)

  new = Hash.new(false)
  xr.each { |x|
    yr.each { |y|
      zr.each { |z|
        wr.each { |w|
          count = count_neighbors_4d(grid, x, y, z, w)
          coords = [x, y, z, w]
          if grid[coords]
            new[coords] = (count == 2 || count == 3)
          else
            new[coords] = count == 3
          end
        }
      }
    }
  }
  new
end

state = grid_4d
6.times { |i|
  state = step_4d(state)
}

puts state.values.filter(&:itself).size
__END__
##..#.#.
###.#.##
..###..#
.#....##
.#..####
#####...
#######.
#.##.#.#
