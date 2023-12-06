INPUT = DATA.read.lines.map { |line|
  line.split(":").last.split.map(&:to_i)
}.transpose

JOINED_INPUT = INPUT.transpose.map { |x|
  x.map(&:to_s).join.to_i
}

[INPUT, [JOINED_INPUT]].map { |input|
  p input.map { |time, distance|
    # (time - hold_time) * hold_time > distance
    delta_sqrt = Math.sqrt(time ** 2 - 4 * distance)
    x1 = ((time - delta_sqrt) / 2).ceil
    x2 = ((time + delta_sqrt) / 2).floor
    # Sometimes need to adjust by 2 for >
    x2 - x1 + 1 - (delta_sqrt == delta_sqrt.to_i ? 2 : 0)
  }.inject(&:*)
}

__END__
Time:        42     89     91     89
Distance:   308   1170   1291   1467
