INPUT = ARGF.read.sub("\n", '')
chars = INPUT.chars
decompressed = ''
loop do
  if chars.first != '('
    decompressed << chars.first
    chars.shift(1)
  else
    pattern = chars.shift(chars.find_index(')')+1).join
    /(?<length>\d+)x(?<reps>\d+)/ =~ pattern
    seq = chars.shift(length.to_i).join
    reps.to_i.times do
      decompressed << seq
    end
  end
  break if chars.empty?
end
puts decompressed.size

chars = INPUT.chars
def part2(input)
  if (/\((?<length>\d+)x(?<reps>\d+)\)(?<rest>.*)/ =~ input).nil?
    input ? input.size : 0
  else
    reps, length = reps.to_i, length.to_i
    reps * part2(rest[0...length]) + part2(rest[length..-1])
  end
end
puts part2(INPUT)
