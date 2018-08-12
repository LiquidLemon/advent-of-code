#!/usr/bin/ruby
JUMPS = ARGF.each_line.map(&:to_i)

# 1
jumps = JUMPS.dup
i = 0
steps = 0
while !jumps[i].nil? && i < jumps.size
  jmp = jumps[i]
  jumps[i] += 1
  i += jmp
  steps += 1
end

puts steps

# 2
jumps = JUMPS.dup
i = 0
steps = 0
while !jumps[i].nil? && i < jumps.size
  jmp = jumps[i]
  jumps[i] += jmp >= 3 ? -1 : 1
  i += jmp
  steps += 1
end

puts steps
