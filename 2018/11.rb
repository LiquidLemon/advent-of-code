serial = DATA.read.to_i

GRID = Array.new(300) do |x|
  Array.new(300) do |y|
    power = x + 11
    power *= y + 1
    power += serial
    power *= x + 11
    power = power / 100 % 10
    power -= 5
    power
  end
end

def get_best(sizes = 3..3)
  max_power = -1.0/0
  best_square = nil

  (0..300-sizes.begin).each do |y|
    (0..300-sizes.begin).each do |x|
      bound = [300 - x, 300 - y, sizes.end + 1].min

      sum = 0
      (1...bound).each do |size|
        (y..y+size-1).each do |yy|
          sum += GRID[x + size - 1][yy]
        end
        (x..x+size-2).each do |xx|
          sum += GRID[xx][y + size - 1]
        end

        if sum > max_power && sizes.include?(size)
          max_power = sum
          best_square = [x+1, y+1, size]
        end
      end
    end
  end
  [best_square, max_power]
end

puts "Part 1: #{get_best[0][0, 2].join(',')}"

square, _ = get_best(1..300)
puts "Part 2: #{square.join(',')}"

__END__
1309
