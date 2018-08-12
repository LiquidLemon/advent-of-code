banks = File.read('6.in').split("\t").map(&:to_i)

states = [banks.join(?,)]

while states.uniq.length == states.length
  biggest_bank = banks.find_index(banks.max)
  value = banks[biggest_bank]
  banks[biggest_bank] = 0
  i = (biggest_bank + 1) % banks.length
  while value > 0
    banks[i] += 1
    value -= 1
    i = (i + 1) % banks.length
  end
  states.push(banks.join ?,)
end
puts states.length - 1

puts states.drop_while { |x| x != states.last }.length - 1
