DATA = File.readlines('5.in').map(&:to_i)

jumps = 0
position = 0

loop do
  jump = DATA[position]
  # For part one switch with
  # DATA[position] += 1
  DATA[position] += (jump >= 3 ? -1 : 1)
  position += jump
  jumps += 1
  break if position > DATA.length - 1
end

puts jumps
