DATA = File.readlines('2.in').map { |row| row.split.map(&:to_i) }

result = DATA.reduce(0) do |acc, row|
  acc + row.max - row.min
end

puts result

result2 = DATA.reduce(0) do |acc, row|
  pair = row.permutation(2).select { |pair| pair.max % pair.min == 0 }.first
  acc + pair.max / pair.min
end

puts result2
