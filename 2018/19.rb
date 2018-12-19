input = DATA.each_line

ip_reg = input.next.split(' ')[1].to_i

instructions = input.map do |l|
  op, *args = l.split
  [op.to_sym, args.map(&:to_i)]
end

def exec(name, args, regs)
  a, b, c = args
  regs[c] = case name
            when :addr then regs[a] + regs[b]
            when :addi then regs[a] + b
            when :mulr then regs[a] * regs[b]
            when :muli then regs[a] * b
            when :banr then regs[a] & regs[b]
            when :bani then regs[a] & b
            when :borr then regs[a] | regs[b]
            when :bori then regs[a] | b
            when :setr then regs[a]
            when :seti then a
            when :gtir then a > regs[b] ? 1 : 0
            when :gtri then regs[a] > b ? 1 : 0
            when :gtrr then regs[a] > regs[b] ? 1 : 0
            when :eqir then a == regs[b] ? 1 : 0
            when :eqri then regs[a] == b ? 1 : 0
            when :eqrr then regs[a] == regs[b] ? 1 : 0
            end
  regs
end

def run_program(program, regs, ip_reg)
  ip = 0
  states = []
  while (0...program.size).include?(regs[ip_reg])
    (states << regs[0]; puts states.last) unless states.include? regs[0]
    regs[ip_reg] = ip
    regs = exec(*program[ip], regs)
    ip = regs[ip_reg] + 1
  end
  p states
  regs
end

puts "Part 1: #{run_program(instructions, [0] * 6, ip_reg)[0]}"
#puts "Part 2: #{run_program(instructions, [1] + [0] * 6, ip_reg)[0]}"

__END__
#ip 2
addi 2 16 2
seti 1 8 5
seti 1 0 3
mulr 5 3 4
eqrr 4 1 4
addr 4 2 2
addi 2 1 2
addr 5 0 0
addi 3 1 3
gtrr 3 1 4
addr 2 4 2
seti 2 1 2
addi 5 1 5
gtrr 5 1 4
addr 4 2 2
seti 1 1 2
mulr 2 2 2
addi 1 2 1
mulr 1 1 1
mulr 2 1 1
muli 1 11 1
addi 4 2 4
mulr 4 2 4
addi 4 12 4
addr 1 4 1
addr 2 0 2
seti 0 9 2
setr 2 3 4
mulr 4 2 4
addr 2 4 4
mulr 2 4 4
muli 4 14 4
mulr 4 2 4
addr 1 4 1
seti 0 1 0
seti 0 4 2
