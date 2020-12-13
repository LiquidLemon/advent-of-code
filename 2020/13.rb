first, second = DATA.each_line.to_a
start = first.to_i
ids = second.split(?,).map { |x| Integer(x) rescue nil }

departs = ids.filter(&:itself).map { |x|
  # Assuming we always have to wait at least one time unit.
  [x, x - (start % x)]
}
puts departs.min_by(&:last).reduce(&:*)

congruences = ids
  .each_with_index
  .reject { |x, _| x.nil? }
  .map { |x, i| [-i % x, x] }
  .sort_by(&:last)
  .reverse

x, n = congruences[0]
congruences[1..].each do |a, n_|
  x_ = x
  while x_ % n_ != a
   x_ += n
  end
  x = x_
  n *= n_
end

puts x

__END__
1002461
29,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,41,x,x,x,x,x,x,x,x,x,521,x,x,x,x,x,x,x,23,x,x,x,x,13,x,x,x,17,x,x,x,x,x,x,x,x,x,x,x,x,x,601,x,x,x,x,x,37,x,x,x,x,x,x,x,x,x,x,x,x,19
