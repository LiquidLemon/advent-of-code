example = ".#..#
.....
#####
....#
...##"

width = nil
height = nil

asteroids = DATA
  .readlines
  .tap { |x| height = x.length }
  .map
  .with_index { |line, y|
    line
      .chomp
      .each_char
      .with_index
      .map { |c, x| [[x, y], c == ?#] }
      .tap { |x| width = x.length }
      .select(&:last)
  }
  .flatten(1)
  .to_h


get_visible = proc do |x, y|
  asteroids.keys.select do |other_x, other_y|
    x_dir = other_x - x
    y_dir = other_y - y

    magnitude = x_dir.gcd(y_dir)

    next true if magnitude == 1
    next false if magnitude == 0

    x_dir /= magnitude
    y_dir /= magnitude

    (1..magnitude - 1).none? do |m|
      location = [
        x + x_dir * m,
        y + y_dir * m
      ]
      asteroids[location]
    end
  end
end

visible = asteroids.map do |(x, y), _|
  [[x, y], get_visible.(x, y).count]
end.to_h

station, visible_asteroids = visible.max_by(&:last)

puts "Part 1: #{visible_asteroids}"

nth_destroyed = proc do |n, x, y|
  destroyed = 0

  asteroid = nil

  while destroyed < n
    targets = get_visible.(x, y)

    targets.sort_by! do |other_x, other_y|
      -Math.atan2(other_x - x, other_y - y)
    end

    targets.each do |target|
      destroyed += 1
      asteroids.delete(target)
      asteroid = target
      break if destroyed == n
    end
  end

  asteroid
end

x, y = station
asteroid = nth_destroyed.(200, x, y)

answer = asteroid[0] * 100 + asteroid[1]

puts "Part 2: #{answer}"

__END__
.#.####..#.#...#...##..#.#.##.
..#####.##..#..##....#..#...#.
......#.......##.##.#....##..#
..#..##..#.###.....#.#..###.#.
..#..#..##..#.#.##..###.......
...##....#.##.#.#..##.##.#...#
.##...#.#.##..#.#........#.#..
.##...##.##..#.#.##.#.#.#.##.#
#..##....#...###.#..##.#...##.
.###.###..##......#..#...###.#
.#..#.####.#..#....#.##..#.#.#
..#...#..#.#######....###.....
####..#.#.#...##...##....#..##
##..#.##.#.#..##.###.#.##.##..
..#.........#.#.#.#.......#..#
...##.#.....#.#.##........#..#
##..###.....#.............#.##
.#...#....#..####.#.#......##.
..#..##..###...#.....#...##..#
...####..#.#.##..#....#.#.....
####.#####.#.#....#.#....##.#.
#.#..#......#.........##..#.#.
#....##.....#........#..##.##.
.###.##...##..#.##.#.#...#.#.#
##.###....##....#.#.....#.###.
..#...#......#........####..#.
#....#.###.##.#...#.#.#.#.....
.........##....#...#.....#..##
###....#.........#..#..#.#.#..
##...#...###.#..#.###....#.##.
