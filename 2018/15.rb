require 'set'

Unit = Struct.new(:type, :x, :y, :health, :power) do
  def <=> other
    [y, x] <=> [other.y, other.x]
  end

  def to_s
    "#{type}(#{health})"
  end

  def attack other
    other.health -= power
  end
end

DIRS = [[1, 0], [-1, 0], [0, 1], [0, -1]]
INPUT = DATA.readlines.map(&:chomp)

def run(elf_power)
  units = []
  grid = INPUT.map.with_index do |l, y|
    l.chomp.chars.map.with_index do |c, x|
      case c
      when ?E, ?G
        unit = Unit.new(c, x, y, 200, c == 'G' ? 3 : elf_power)
        units << unit
        unit
      else
        c
      end
    end
  end

  elves = units.count { |u| u.type == ?E }

  obstructed = ->(point) do
    cell = grid[point[1]][point[0]]
    cell.is_a?(Unit) || cell == '#'
  end

  get_path = ->(src, dst) do
    to_visit = DIRS
      .map { |x, y| [src[0] + x, src[1] + y] }
      .select { |x| !obstructed.(x) }
      .sort_by(&:reverse)

    visited_from = to_visit.zip([src] * to_visit.size).to_h

    until to_visit.empty?
      point = to_visit.shift
      if point == dst
        path = []
        while point != src
          path << point
          point = visited_from[point]
        end
        return path.reverse
      end
      nxt = DIRS
        .map { |x, y| [point[0] + x, point[1] + y] }
        .select { |p| !obstructed.(p) && !visited_from.include?(p) }
      to_visit.concat(nxt)
      visited_from.merge!(nxt.zip([point] * nxt.size).to_h)
    end
    nil
  end

  debug = ->() do
    grid.each.with_index do |row, y|
      row.each.with_index do |cell, x|
        print case cell
              when Unit; cell.type
              when '#'; '#'
              else '.'
              end
      end
      print "\n"
    end
  end

  i = 0
  catch :done do
    loop do
      units.sort!
      processed = []
      until units.empty?
        unit = units.shift
        targets = (processed + units).select { |x| x.type != unit.type }
        if targets.empty?
          units.concat(processed)
          units << unit
          throw :done
        end
        in_range = targets.map do |t|
          DIRS
            .map { |x, y| [t.x + x, t.y + y] }
            .select { |x, y| !grid[y][x].is_a?(Unit) && grid[y][x] != '#' }
        end.flatten(1).to_set

        to_attack = DIRS
          .map { |x, y| grid[unit.y + y][unit.x + x] }
          .select { |c| c.is_a?(Unit) && c.type != unit.type }
          .min_by { |x| [x.health, x.y, x.x] }

        if !in_range.empty? && !to_attack
          paths = in_range
            .map { |point| get_path.([unit.x, unit.y], point) }
            .reject(&:nil?)

          unless paths.empty?
            shortest = paths.min_by(&:size).size
            path = paths
              .select { |p| p.size == shortest }
              .sort_by { |p| p.last.reverse }
              .first
            grid[unit.y][unit.x] = nil
            unit.x = path[0][0]
            unit.y = path[0][1]
            grid[unit.y][unit.x] = unit
          end

          to_attack = DIRS
            .map { |x, y| grid[unit.y + y][unit.x + x] }
            .select { |c| c.is_a?(Unit) && c.type != unit.type }
            .min_by { |x| [x.health, x.y, x.x] }
        end

        if to_attack
          unit.attack(to_attack)
          if to_attack.health <= 0
            processed.delete(to_attack)
            units.delete(to_attack)
            grid[to_attack.y][to_attack.x] = nil
          end
        end

        processed << unit
      end
      units = processed
      i += 1
    end
  end
  [units.map(&:health).sum * i, units.first.type == 'E' && units.size == elves]
end

puts "Part 1: #{run(3)[0]}"

power = 4
power += 1 until (result = run(power))[1]
puts "Parth 2: #{result[0]}"

__END__
################################
###.GG#########.....#.....######
#......##..####.....G.G....#####
#..#.###...######..........#####
####...GG..######..G.......#####
####G.#...########....G..E.#####
###.....##########.........#####
#####..###########..G......#####
######..##########.........#####
#######.###########........###.#
######..########G.#G.....E.....#
######............G..........###
#####..G.....G#####...........##
#####.......G#######.E......#..#
#####.......#########......E.###
######......#########........###
####........#########.......#..#
#####.......#########.........##
#.#.E.......#########....#.#####
#............#######.....#######
#.....G.G.....#####.....########
#.....G.................########
#...G.###.....#.....############
#.....####E.##E....##.##########
##############.........#########
#############....#.##..#########
#############.#######...########
############.E######...#########
############..####....##########
############.####...E###########
############..####.E.###########
################################
