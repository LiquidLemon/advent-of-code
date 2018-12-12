require 'set'

def simulate(initial, rules, generations)
  pots = initial.dup

  sum = nil
  shapes = Set.new
  generations.times do |gen|
    new_pots = Hash.new(false)
    first, last = pots.keys.minmax
    (first-2..last+2).each do |i|
      pattern = (-2..2).map { |j| pots[i + j] }
      new_pots[i] = rules[pattern]
    end
    pots = new_pots
    new_sum = pots.select { |_, plant| plant }.keys.sum

    min = nil
    shape = pots
      .select { |_, plant| plant }
      .keys
      .tap { |keys| min = keys.min }
      .map { |key| key - min }

    if shapes.include?(shape)
      return sum + (generations - gen) * (new_sum - sum)
    end

    shapes << shape
    sum = new_sum
  end
  pots.select { |_, plant| plant }.keys.sum
end

input = DATA.readlines
initial = input[0].scan(/[.#]/).map.with_index { |c, i| [i, c == '#'] }.to_h
rules = input[2..-1].map do |rule|
  values = rule.scan(/[.#]/).map { |c| c == '#' }
  [values[0..4], values[5]]
end.to_h
initial.default = false

[20, 50_000_000_000].each.with_index(1) do |generations, part|
  sum = simulate(initial, rules, generations)
  puts "Part #{part}: #{sum}"
end

__END__
initial state: ##.#....#..#......#..######..#.####.....#......##.##.##...#..#....#.#.##..##.##.#.#..#.#....#.#..#.#

#.#.. => .
..##. => .
...#. => .
..#.. => .
##### => #
.#.#. => .
####. => .
###.. => .
.#..# => #
#..#. => #
#.#.# => .
#...# => #
..### => .
...## => #
##..# => #
#.... => .
.#.## => #
#.### => #
.##.# => #
#..## => .
.#... => #
.###. => .
##... => #
##.## => #
##.#. => #
#.##. => #
.##.. => .
..#.# => .
....# => .
###.# => .
..... => .
.#### => .
