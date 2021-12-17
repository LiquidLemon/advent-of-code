# There's probably an O(1) solution at least for the first part. I gave up
# halfway through because it's probably way more complex than I thought.
# Instead it's just bruteforce with random bounds. Oh well.

input = [20, 30, -10, -5]
input = DATA.read.split(/[^-\d]+/).map(&:to_i).drop(1).freeze
min_x, max_x, min_y, max_y = input

def t(n)
  n * (n+1) / 2
end

def it(n)
  (Math.sqrt(8 * n + 1) + 1) / 2 - 1
end

puts (1..200).map { t(_1) }.filter { |y|
  hit_y = y - t(it(y - max_y).ceil)
  hit_y >= min_y
}.last

puts (1..max_x).sum { |vx|
  xs = (vx - 1).downto(1).reduce([vx]) { |acc, v| acc << acc[-1] + v }

  next 0 if xs.find_index { _1 >= min_x && _1 <= max_x }.nil?

  (min_y..200).count { |vy|
    y = vy
    i = 0
    loop do
      x = i < xs.length ? xs[i] : xs[-1]

      break true if y >= min_y && y <= max_y && x >= min_x && x <= max_x
      break false if y < min_y

      i += 1
      vy -= 1
      y += vy
    end
  }
}

__END__
target area: x=211..232, y=-124..-69
