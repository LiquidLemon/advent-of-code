DATA = File.readlines('4.in').map(&:chomp).map { |pass| pass.split(' ') }

puts DATA.select { |pass| pass.length == pass.uniq.length }.length

valid = DATA.select do |pass|
  pass.permutation(2).all? do |pair|
    pair.map { |word| word.chars.sort.join }.uniq.length == 2
  end
end

puts valid.length
