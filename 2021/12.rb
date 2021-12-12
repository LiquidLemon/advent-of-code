class String
  def upper?
    chars.all? { |c| ('A'..'Z').include?(c) }
  end
end

input = DATA.readlines(chomp: true).flat_map { |line|
  a, b = line.split("-")
  [[a, b], [b, a]]
}.group_by(&:first).map { |k, v| [k, v.map(&:last)] }.to_h

def get_paths(map, repeat, start="start", visited=[])
  new_path = visited.dup << start

  if start == "end"
    return [new_path]
  end

  if repeat
    repeat_visit_allowed = new_path.reject(&:upper?).tally.values.all? { |x| x < 2 }
  end

  map[start]
    .filter { |loc|
      loc != "start" && (loc.upper? || !visited.include?(loc) || (repeat && repeat_visit_allowed))
    }.map { |loc|
      get_paths(map, repeat, loc, new_path)
    }.flatten(1)
end

puts get_paths(input, false).length
puts get_paths(input, true).length

__END__
xx-end
EG-xx
iy-FP
iy-qc
AB-end
yi-KG
KG-xx
start-LS
qe-FP
qc-AB
yi-start
AB-iy
FP-start
iy-LS
yi-LS
xx-AB
end-KG
iy-KG
qc-KG
FP-xx
LS-qc
FP-yi
