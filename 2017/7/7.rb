Program = Struct.new(:name, :weight, :programs)

DATA = File.readlines('7.in').map do |line|
  match = line.match(/(\w+) \((\d+)\)(?: -> (.*))?/)
  if match[3]
    Program.new(match[1], match[2].to_i, match[3].split(', '))
  else
    Program.new(match[1], match[2].to_i, [])
  end
end

root = DATA.find do |program|
  !DATA.any? { |p| p.programs.include? program.name }
end

puts root.name

def get_tree(root)
  root.programs.map! do |p|
    get_tree(DATA.find { |x| x.name == p })
  end
  root
end

get_tree(root)

def get_weight(root)
  root.weight + root.programs.map { |p| get_weight(p) }.sum
end

def find_unbalanced(root)
  weights = root.programs.map { |p| get_weight(p) }
  return nil if weights.uniq.length == 1
  if root.programs.length == 2
    puts "found a pair"
    return root.programs
  else
    pairs = root.programs.zip(weights)
    unbalanced = pairs.find do |pair|
      pairs.count { |(_, weight)| weight == pair[1] } == 1
    end.first
    find_unbalanced(unbalanced)
  end
end

puts find_unbalanced(root).name
