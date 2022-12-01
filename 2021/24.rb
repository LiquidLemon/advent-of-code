test="inp w
add z w
mod z 2
div w 2
add y w
mod y 2
div w 2
add x w
mod x 2
div w 2
mod w 2"
#input = test.lines(chomp: true).map { |line|
input = DATA.readlines(chomp: true).map { |line|
  ins, *args = line.split

  [
    ins.to_sym,
    args.map { |arg|
      %w[x y z w].include?(arg) ? arg.to_sym : arg.to_i
    }.freeze
  ].freeze
}.freeze

segments = input.chunk_while { _2[0] != :inp }.to_a.freeze

segments.transpose.each { |seg|
  seg.each { |ins, args|
    print "#{ins} #{args.map(&:to_s).join(" ")}".ljust(11)
  }
  puts
}
puts


def run(program, input=[], registers={})
  registers = registers.dup
  registers.default = 0
  input = input.dup

  program.each { |ins, args|
    case ins
    in :inp
      raise "no input left" if input.empty?
      registers[args[0]] = input.pop

    in :add
      registers[args[0]] += args[1].is_a?(Integer) ? args[1] : registers[args[1]]

    in :mul
      registers[args[0]] *= args[1].is_a?(Integer) ? args[1] : registers[args[1]]

    in :div
      registers[args[0]] /= args[1].is_a?(Integer) ? args[1] : registers[args[1]]

    in :mod
      raise "first argument of mod less than 0" if registers[args[0]] < 0
      arg1 = args[1].is_a?(Integer) ? args[1] : registers[args[1]]
      raise "second argument of mod less than 1" if arg1 <= 0
      registers[args[0]] %= arg1

    in :eql
      bool = registers[args[0]] == (args[1].is_a?(Integer) ? args[1] : registers[args[1]])
      registers[args[0]] = bool ? 1 : 0
    end
  }
  registers
end

def get_possible_input(program, target_z)
  result = []
  9.downto(1).each { |input|
    (0..25).each { |z|
      regs = run(program, [input], { z: z })
      if regs[:z] == target_z
        result << [input, z]
      end
    }
  }

  result
end


__END__
inp w
mul x 0
add x z
mod x 26
div z 1
add x 10
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 12
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 1
add x 12
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 7
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 1
add x 10
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 8
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 1
add x 12
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 8
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 1
add x 11
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 15
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 26
add x -16
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 12
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 1
add x 10
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 8
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 26
add x -11
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 13
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 26
add x -13
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 3
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 1
add x 13
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 13
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 26
add x -8
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 3
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 26
add x -1
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 9
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 26
add x -4
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 4
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 26
add x -14
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 13
mul y x
add z y
