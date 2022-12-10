input = DATA.readlines(chomp: true).map { |line|
  args = line.split
  args.length == 1 ? [args[0], nil] : [args[0], args[1].to_i]
}

def simulate(input)
  program = input.flat_map { |op, arg|
    if op == "addx"
      [["noop", nil], [op, arg]]
    else
      [[op, arg]]
    end
  }

  sig_strength = 0
  crt = Array.new(240) { "." }

  reg = 1
  counter = 0

  program.each { |op, arg|
    if (reg-1..reg+1).include?(counter % 40)
      crt[counter] = "#"
    end

    counter += 1

    if counter % 40 == 20
      sig_strength += counter * reg
    end

    if op == "addx"
      reg += arg
    end
  }

  crt_str = crt.each_slice(40).map(&:join)
  [sig_strength, crt_str]
end

puts simulate(input)

__END__
noop
noop
noop
addx 6
noop
addx 30
addx -26
noop
addx 5
noop
noop
noop
noop
addx 5
addx -5
addx 6
addx 5
addx -1
addx 5
noop
noop
addx -14
addx -18
addx 39
addx -39
addx 25
addx -22
addx 2
addx 5
addx 2
addx 3
addx -2
addx 2
noop
addx 3
addx 2
addx 2
noop
addx 3
noop
addx 3
addx 2
addx 5
addx 4
addx -18
addx 17
addx -38
addx 5
addx 2
addx -5
addx 27
addx -19
noop
addx 3
addx 4
noop
noop
addx 5
addx -1
noop
noop
addx 4
addx 5
addx 2
addx -4
addx 5
noop
addx -11
addx 16
addx -36
noop
addx 5
noop
addx 28
addx -23
noop
noop
noop
addx 21
addx -18
noop
addx 3
addx 2
addx 2
addx 5
addx 1
noop
noop
addx 4
noop
noop
noop
noop
noop
addx 8
addx -40
noop
addx 7
noop
addx -2
addx 5
addx 2
addx 25
addx -31
addx 9
addx 5
addx 2
addx 2
addx 3
addx -2
noop
addx 3
addx 2
noop
addx 7
addx -2
addx 5
addx -40
addx 20
addx -12
noop
noop
noop
addx -5
addx 7
addx 7
noop
addx -1
addx 1
addx 5
addx 3
addx -2
addx 2
noop
addx 3
addx 2
noop
noop
noop
noop
addx 7
noop
noop
noop
noop
