require 'matrix'

lookup = {
  'U' => Vector[0,1],
  'D' => Vector[0,-1],
  'R' => Vector[1,0],
  'L' => Vector[-1,0]
}

def get_char(keypad, vector)
  chr = keypad[vector[0]][vector[1]]
  chr.nil? ? nil : chr.to_s
end

lines = File.readlines('2.in').map(&:chomp)

keypad = [
  [7, 4, 1],
  [8, 5, 2],
  [9, 6, 3]
]

position = Vector[1,1]
code = ''
lines.each do |line|
  line.each_char do |char|
    tmp = position + lookup[char]
    position = tmp if tmp.all? { |x| (0..2).include? x }
  end
  code += get_char(keypad, position)
end
puts code

keypad2 = [
  [nil, nil, 5, nil, nil],
  [nil, ?A, 6, 2, nil],
  [?D, ?B, 7, 3, 1],
  [nil, ?C, 8, 4, nil],
  [nil, nil, 9, nil, nil]
]

position = Vector[0, 2]
code = ''
lines.each do |line|
  line.each_char do |char|
    tmp = position + lookup[char]
    if tmp.all? { |x| (0..4).include? x } && !get_char(keypad2, tmp).nil?
      position = tmp
    end
  end
  code += get_char(keypad2, position)
end
puts code
