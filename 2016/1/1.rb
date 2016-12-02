file = File.read('1.in')
Directive = Struct.new(:dir, :distance)
directives = file.split(', ').map { |d| Directive.new(d[0], d[1..-1].to_i) }
position = [0, 0]
positions = [[0,0]]
directions = [[0, 1], [1, 0], [0, -1], [-1, 0]]
directives.each do |d|
  if d.dir == 'R'
    directions.push(directions.shift)
  else
    directions.unshift(directions.pop)
  end
  d.distance.times do |i|
    positions.push([position[0] + i.next*directions.first[0], position[1] + i.next*directions.first[1]])
  end
  position[0] += directions[0][0] * d.distance
  position[1] += directions[0][1] * d.distance
end
puts "Part 1: #{position.map(&:abs).reduce(&:+)}"
found = positions.select { |x| positions.count(x) > 1 }.tap { |x| p x }.first
puts "Part 2: #{found.map(&:abs).reduce(&:+)}"
