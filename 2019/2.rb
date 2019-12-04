memory = DATA.read.split(',').map(&:to_i)

INSTRUCTIONS = {
  1 => [
    ->(args, memory) { memory[args[2]] = memory[args[0]] + memory[args[1]] },
    3
  ],
  2 => [
    ->(args, memory) { memory[args[2]] = memory[args[0]] * memory[args[1]] },
    3
  ],
  99 => [
    ->(_args, _memory) { throw :exit },
    0
  ],
}

def run_program(program, noun, verb)
  memory = program.dup

  memory[1] = noun
  memory[2] = verb

  ip = 0
  catch :exit do
    loop do
      opcode = memory[ip]
      op, arity = INSTRUCTIONS[opcode]
      args = memory[ip + 1..ip + arity]
      op.call(args, memory)
      ip += arity + 1
    end
  end

  memory[0]
end

puts "Part 1: #{run_program(memory, 12, 2)}"

catch :done do
  (0..99).each do |noun|
    (0..99).each do |verb|
      if run_program(memory, noun, verb) == 19690720
        puts "Part 2: #{noun * 100 + verb}"
        throw :done
      end
    end
  end
  puts "No solution to part 2 found!"
end

__END__
1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,10,1,19,1,6,19,23,1,23,13,27,2,6,27,31,1,5,31,35,2,10,35,39,1,6,39,43,1,13,43,47,2,47,6,51,1,51,5,55,1,55,6,59,2,59,10,63,1,63,6,67,2,67,10,71,1,71,9,75,2,75,10,79,1,79,5,83,2,10,83,87,1,87,6,91,2,9,91,95,1,95,5,99,1,5,99,103,1,103,10,107,1,9,107,111,1,6,111,115,1,115,5,119,1,10,119,123,2,6,123,127,2,127,6,131,1,131,2,135,1,10,135,0,99,2,0,14,0
