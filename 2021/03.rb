input = DATA.readlines.map { |x| x.chomp.chars.map(&:to_i) }

counts = Hash.new(0)
input.each { |digits|
  digits.reverse.each_with_index { |d, i|
    counts[i] += d
  }
}

gamma = 0
epsilon = 0

counts.each { |k, v|
  # If the count is below length / 2 then 0 was most common, otherwise 1
  if v > input.length / 2
    gamma += 2 ** k
  else
    epsilon += 2 ** k
  end
}

puts gamma * epsilon

# part 2

require 'set'

puts [:==, :!=].map { |op|
  candidates = Set.new(input)

  i = 0
  while candidates.length > 1
    count = 0

    candidates.each { |number|
      count += number[i]
    }

    threshold = count / (candidates.size / 2)
    candidates.reject! { |number|
      number[i].send(op, threshold)
    }

    i += 1
  end

  value = candidates.first.map(&:to_s).join.to_i(2)

}.reduce(&:*)

__END__
011110111101
110010010001
111011111111
110011010100
111100000011
010101001001
010101000010
100111101000
110110101110
001001101000
101100100110
101001100110
101110000110
011111111100
110010000101
000011111001
101000110001
100111011101
011011011011
111100000100
010100101100
110010000110
101000001101
010100110011
111101101100
100101000011
101000100111
111010010000
011111000110
110100101010
011010000000
101110100111
010000001000
001111001010
001011101011
100001110010
001100100100
111110011110
000011101011
101100111011
000000101011
101000000100
001000101011
110101000111
011010111011
100011101011
110101011000
001110110010
100011101110
001101011001
000101100100
010000101100
100010001100
100101001010
011010110001
111001110110
111101111101
000010011000
110100111000
011010000100
000000010110
100000001001
110101101001
111010100001
101011110000
110100101111
010000010110
111010110100
011110010110
001100001111
001110001110
111001110101
010111000110
101111001101
010011010011
000001110101
101100010001
111101110011
101000010101
100110011001
010101011101
111111101110
010011010010
110000101111
100101111001
011110100110
111100110000
100000111000
011010011111
101001101110
110001110111
101011001111
010101110010
000110001100
101110011011
000111111100
001001011110
010000100101
110110111101
001000011001
011011110101
100000001011
010110000011
110011001100
110000110010
111000110111
110000001000
011110101001
001111101010
001111000111
100010100010
001001010100
001101101001
000011000011
101010101101
101101011000
000010001000
011101110101
000001011110
001000101001
000110000000
100010111011
001111111111
001101110101
001101100100
101000011110
010001010101
111011010000
000011011101
101101001010
010000110001
111110011000
110011100111
000110111100
010110001101
010100010100
101010100001
011010111001
010001100100
010100111011
010010010111
011100011011
101110110111
011111101000
101110001101
001001100111
101100101010
100001010101
100101000101
101000000011
110000101110
001000111000
011100000000
101100111110
000100101001
010100111111
000101110000
101111100010
110011101110
011001000100
111001001000
000001111010
100100010011
101010101001
010110010000
110011110111
101000010000
100000101010
110010011010
001001001111
001011011000
011101100110
100101101010
110010111100
110000100100
010010001100
010011010101
110011000010
101111110010
001011010001
001011001010
100000001010
000110010010
000111101111
110011101100
110100110010
100100010100
010001100010
001101101111
111110110001
111101000101
000101101111
000100110100
001000111011
011000111000
101000011001
110110110000
111111111010
000000001010
000010101010
001000001001
101001100101
001001000101
101111110111
101101001100
001110111011
101000111101
010100000000
110011011011
000110100001
100110111010
000011100001
010000010111
110111011100
111100001011
001111011001
000011011100
111110011011
010110000010
001000010100
011110011110
111100001101
110011100101
011111110000
100111011010
000000111011
111111001010
010100111100
000101111000
110010011111
110111101001
100011000001
111001100010
100101000001
010111111101
110010110001
001101001001
100101101001
011000110101
101110011001
101111101010
100111010001
011100111000
001100000111
001110011110
010010000101
010010110001
111010001101
000010110001
010110101110
011111111000
100000101001
111101011101
000001010100
000011001011
110000011100
000011001110
110101010110
011000110011
000111111000
100000110000
001010101010
001001101001
011101011011
100011110000
111011011000
111101110100
000001010110
100011110100
101101000010
000011011011
101011110110
100001101011
010111100000
000011000010
000111001111
011001100100
110110010010
000011110111
101001001011
010110110101
001100000110
000111101110
110011010011
101001010010
010011110100
110101011010
101100101011
101110010110
010000000011
010001101001
101010011110
010101100001
100100000110
000010010111
101100101110
000111000001
110100111111
010011100000
011101110000
011111011110
101011011110
100011110010
001100011100
011010010111
101010011001
110100100110
001011100111
001001101110
010001001000
101111100100
101011010001
100101100001
010000101001
000100000011
101011101000
000001100101
110001101111
001110000111
010010000110
101001101101
100110011000
100110000110
000000110010
000111100001
001000101110
110000000111
110011101111
101110010010
110010001110
101111011010
000001000000
110010100111
100111010111
001100101111
001110111001
111100011100
011000010100
100101101101
100001001110
111110100011
101111001000
010111000100
110001110010
001110101111
101000000111
010001010111
000000000111
010001111100
011100000110
010100010000
101000010001
101110000100
111111110001
110000001101
111001111111
000100011111
111001101000
001011111111
110100001011
111011000001
001111101101
101011110100
101010110010
101111110011
011100100100
001101011110
000100001011
100001011101
101000010110
001011110111
110101000101
011011011110
001010000001
000111000010
100101001001
000001110010
110100010011
111100101101
100111011001
000110101111
101010000100
011101011000
001110000010
001000111101
110000011000
010010010110
100101011000
000010010100
110001101010
101010000110
111111010010
001111001000
110100101001
010001000001
001111110010
110001011011
111100000001
011011110111
111001001111
110010000100
100101111011
001000111001
111010001010
101100100100
101000111110
000100101110
111000101001
001001010110
100100101101
111111011100
111001110011
011111001100
101010101100
000011010001
110111001110
010100000111
110011100000
101001000010
000111101001
010100011111
011101001001
100110010010
100110101010
010001110010
011101000101
001111100010
011010111111
110110001110
010010010000
101100110011
111111011101
000011000101
100000111100
111101010011
100111010011
110010011011
000011111100
011110011000
101100000101
111110000011
100100001011
000010011001
111000011101
111000110101
110010100010
101001010100
010001110011
001101001011
010000101111
111011100000
000110000111
000011100000
000101011101
000101100001
011100100000
011100001011
011110111011
111110010010
111000010110
000110001110
111100011001
010110000110
000001010111
100001111001
100111100001
011000111011
111111101001
001000000001
001101100011
111101010100
001101110001
110100111011
000111011010
000111110100
010100000011
010001110101
101100000011
110011111000
010010101001
101111011100
101101101101
111110000100
001011000000
010100001110
001001011011
011000011101
110111110101
101010010111
110101000010
111111000000
101010101110
101100110101
100110001011
011010110010
000010110010
000101001001
000011110011
101010111111
011000101101
111001100101
000110101001
110100000001
110010000001
111011011110
101110110101
000001111001
100100011011
011111111001
100111101110
101010010011
000010110000
011110111010
000011110100
101010010001
110000011001
100100110010
100110100110
110000110001
100111010100
000111011100
110001000100
011000010010
101111111110
011100011100
000001001110
111101101000
110011001011
010001000110
000111000000
000001001001
100100011100
101111011101
000111001001
010001011111
001100100101
011101000100
011001110101
100111100110
010110000100
111011100011
110000011010
011000101111
100010100011
111101001111
000111010110
011001110000
101101011011
010011000111
110001101100
000100001110
110101111000
111100001110
100101011110
111011101110
110010101111
110111101101
110100011001
000111111111
011001101110
001100010000
110011110000
011010110101
011110111100
100001110000
110101101110
000010001100
011001101100
100000110110
100111110111
101110001100
010101000011
110001110001
011001011001
011001111001
111010011001
110011011010
001011011110
111000000100
101110111001
110000111010
101010110101
110001011111
011001011111
101110010101
010110110111
010101100101
010111111000
010000011101
100111010000
100001111101
001101111010
001000000011
010110111011
010001110111
000011001000
110001111010
111101001001
110000000100
111100001000
111010000110
000100011110
110101101011
001011110100
011101011001
110101010100
110010011001
100101001111
100110110100
000101001101
001011101110
101000001010
001100101010
100010011011
100011100001
000101011111
111001100110
101110101011
111101111100
001000001010
001100010100
111010100111
000101110001
001010100001
001111110110
110110101000
110110000110
011110111110
100111110001
011000001110
110101010011
010110001110
111110010001
100101111000
001111100101
110011001010
111101010010
111111000011
001100101011
100001101100
100001110110
110000000001
000101001011
111111110111
000100010000
101010110011
111001101011
010111100010
001000011011
010010110011
001010111101
010011011011
011110000001
010101011111
001011101100
010000010000
111001100111
111001010011
111000111010
001100011110
010111011101
010110000111
010101100010
011110011100
100101000111
011010000111
000101010111
100101001100
011010110011
011000011110
010011110101
111000101111
111010101111
101111010110
100100101000
101011111100
100001001000
000100010101
001001100000
110100100001
100011110001
101110110110
110011000100
011001000101
111001110111
111011010110
101110110010
100110111001
110101011011
110110000011
000111101101
100011010010
111000100101
010001100000
010011111001
010101010101
110011110101
100000100110
110010101000
000100110101
010010110111
111000001001
001011111011
010000111001
111011001110
011101110110
010001111001
111001111110
101010101111
101111111101
110011101010
010011000110
101001111010
101110000101
000010000110
111110000111
001010111011
010110011111
001011101101
011101011110
000010000010
101011010011
011100011000
111000100011
011111011111
110000001010
000100000100
101010111101
110000111000
001100110000
111111011010
110100110000
000000000000
101001000000
110010110101
011011001100
101101101110
010110100011
101111000000
111011100101
110100100010
010111000001
110110011000
011101111110
000010110110
111000000011
001101110010
100000110011
000110000011
100111110000
011110110011
111010101010
010010001011
101111000110
001010000011
101111010000
011000111001
001001111101
010100011001
000000010011
001111001001
011000010000
011001111111
100010101001
010000100011
111111101101
011011001000
011001010011
111011011001
010001110110
110010110000
000000000011
110110000000
011101001101
011010000101
101011100110
001101010010
100000000100
100100010001
100110011111
111100001010
001100011111
000100000110
011011010010
011010001100
011111101011
011010101001
110111000110
110000110110
011110110000
010011011101
010011100100
000110111001
111011111001
101111010010
011000111100
101111111010
110011000001
000100011000
110101110100
011001101010
100011011101
001011110011
110010111110
000110001101
111011101001
100110100001
101011011010
001000101010
101011100111
110110000001
100100000010
101100010011
111001010101
011100000101
100010111100
010110100010
100100110001
100111001001
011101010010
101101111000
111100100111
111011001000
100111011111
111001100001
010001111011
011110100100
111111010101
101011111110
110101101100
000100101111
011110001000
101101001110
001111111010
110011100110
110110011100
111111100000
000000010001
100100001101
101000101110
100001011010
100011000100
110011110110
000000110100
010110001010
101000110000
110110001001
000001000101
011111100111
000011110101
101111010101
010101001111
110111001111
101001110010
011001010111
101000101010
100100000111
100011001011
110010000000
001000110001
100010001101
010001000010
101101111111
111001001011
101001011100
000100111100
110000000101
101010011101
000101000111
111000101100
001100000100
010010100101
011010100010
111000100110
001001111010
101001001111
011000100011
011000001100
011110101111
111011111110
101001001010
010000001111
000000000101
000111001010
100001000111
111101010001
010011001111
001110010000
101101001001
000110110111
001101011011
111100100010
101010001000
001001101100
011110001101
000101000011
111101100111
100110000010
111010100101
011010011110
000000101000
001011001000
001001011010
011100000100
000011010101
111110011100
001101110110
100011101111
011001110010
011100100111
010101001100
000101010000
101001101001
100101110111
101101100110
000101100010
111011000011
010010010011
000111111110
010101100011
000001010010
111100110010
101011001010
010110011110
011001101111
011100001010
001111001100
000110100011
101011101010
011111111110
100011011011
101010011111
010001110001
100010101101
010101010011
100001010001
111010011000
011110100010
001111000101
111101101010
011110100000
111110001101
110010010100
000001010011
000100101100
111000111111
011111000011
010000011001
000110001011
111100101110
001000110101
001011111100
001111010001
101000100101
000101001100
000110101010
010010011111
111101001000
101110110011
111100100110
101010101011
101010101010
100000111001
000101000001
100010010101
011000101000
100100001111
110111100011
101100000000
001011110001
110011001111
000001000011
001100111011
101100010000
001111000001
111100000101
101010111011
011111110010
011111010001
101011010100
000111111011
110000100110
110111110000
100101101110
001011000001
101100001101
011100010010
000110100110
010101110111
111100101011
101101001101
011011111110
011100011001
110010011100
000001011100
101110100110
010001011100
011111001010
100111100101
111111000010
