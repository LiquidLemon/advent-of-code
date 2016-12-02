data = File.readlines("7.in").map do |line|
  hash = {};
  if match = line.match(/(\w+) ([A-Z]+) (\w+) -> (\w+)/)
    hash[:arguments] = [match[1], match[3]]
    hash[:operator] = match[2]
  elsif match = line.match(/([A-Z]+) (\w+) -> (\w+)/) 
    hash[:arguments] = [match[2]]
    hash[:operator] = match[1]
  elsif match = line.match(/(\w+) -> (\w+)/)
    hash[:arguments] = match[1]
    hash[:operator] = "ASSIGN"
  end
  hash[:output] = match.to_a.last
  hash
end

wires = {};

