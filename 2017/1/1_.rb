DATA = File.read('1.in').chomp.chars.map(&:to_i)

puts DATA.zip(DATA.rotate).select { |p| p[0] == p[1] }.map(&:first).sum

puts DATA.zip(DATA.rotate(DATA.length / 2)).select { |p| p[0] == p[1] }.map(&:first).sum
