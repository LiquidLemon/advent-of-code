data = DATA.read.split(?,).map(&:to_i)

def get_turn(input, turns)
  turns_spoken = input.each.with_index(1).map { |x, i| [x, [i]] }.to_h
  turns_spoken.default_proc = proc { [] }

  prev = input.last
  (input.size+1..turns).each { |i|
    if turns_spoken[prev].size > 1
      prev = i - turns_spoken[prev][-2] - 1
    else
      prev = 0
    end
    turns_spoken[prev] <<= i
  }
  prev
end

[2020, 30_000_000].each { |turns|
  puts get_turn(data, turns)
}
__END__
15,5,1,4,7,0
