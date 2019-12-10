class Interpreter
  attr_accessor :input

  def initialize(program, input=[])
    @memory = program.dup
    @input = input
  end

  def run
    ip = 0

    Enumerator.new do |y|
      loop do
        opcode = @memory[ip].digits
        index = opcode[0] + opcode[1].to_i * 10

        arity = case index
                when 1 then 3
                when 2 then 3
                when 3 then 1
                when 4 then 1
                when 5 then 2
                when 6 then 2
                when 7 then 3
                when 8 then 3
                when 99 then 0
                end

        args = @memory[ip + 1..ip + arity]
        modes = opcode.drop(2)

        get_param = proc do |i|
          case modes[i].to_i
          when 0
            @memory[args[i]]
          when 1
            args[i]
          end
        end

        jump = false

        case index
        when 1
          @memory[args[2]] = get_param.(0) + get_param.(1)
        when 2
          @memory[args[2]] = get_param.(0) * get_param.(1)
        when 3
          @memory[args[0]] = @input.shift
        when 4
          y << get_param.(0)
        when 5
          if get_param.(0) != 0
            jump = true
            ip = get_param.(1)
          end
        when 6
          if get_param.(0) == 0
            jump = true
            ip = get_param.(1)
          end
        when 7
          @memory[args[2]] = if get_param.(0) < get_param.(1) then 1 else 0 end
        when 8
          @memory[args[2]] = if get_param.(0) == get_param.(1) then 1 else 0 end
        when 99
          break
        end

        ip += arity + 1 unless jump
      end
    end
  end
end

controller = DATA.read.split(?,).map(&:to_i)

results = [*0..4].permutation.map do |phases|
  phases.reduce(0) do |acc, phase|
    Interpreter.new(controller, [phase, acc]).run.next
  end
end

puts "Part 1: #{results.max}"

results = [*5..9].permutation.map do |phases|
  amps = phases.map { |phase| Interpreter.new(controller, [phase]) }

  signal = 0

  amps.map(&:run).each_with_index.cycle do |outputs, i|
    amps[i].input << signal
    begin
      signal = outputs.next
    rescue StopIteration
      break
    end
  end

  signal
end

puts "Part 2: #{results.max}"

__END__
3,8,1001,8,10,8,105,1,0,0,21,46,67,76,101,118,199,280,361,442,99999,3,9,1002,9,4,9,1001,9,2,9,102,3,9,9,101,3,9,9,102,2,9,9,4,9,99,3,9,1001,9,3,9,102,2,9,9,1001,9,2,9,1002,9,3,9,4,9,99,3,9,101,3,9,9,4,9,99,3,9,1001,9,2,9,1002,9,5,9,101,5,9,9,1002,9,4,9,101,5,9,9,4,9,99,3,9,102,2,9,9,1001,9,5,9,102,2,9,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,99,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,99,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,101,2,9,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,2,9,4,9,99,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,99
