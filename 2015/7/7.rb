require 'pry'

OPERATORS = {
  "NOT" => lambda { |args| 65535 - args[0] },
  "AND" => lambda { |args| args[0] & args[1] },
  "OR" => lambda { |args| args[0] | args[1] },
  "LSHIFT" => lambda { |args| args[0] << args[1] },
  "RSHIFT" => lambda { |args| args[0] >> args[1] },
}

DATA = File.readlines(ARGV[0]).map do |line|
  /(?<left>.*) -> (?<right>.*)/ =~ line
  left = left.split(' ')
  left.map! do |symbol|
    symbol.match(/\d+/) ? symbol.to_i : symbol
  end

  [right] << case left.size
  when 1
    { args: left }
  when 2
    { op: left.first, args: [left.last] }
  when 3
    { op: left[1], args: [left.first, left.last] }
  end
end.to_h

def evaluate(key)
  left = DATA[key]
  if !left.has_key?(:op)
    puts "Retrieving #{key}"
    left[:args][0].is_a?(Integer) ? left[:args][0] : evaluate(left[:args][0])
  else
    puts "Evaling #{key}"
    value = OPERATORS[left[:op]].call(left[:args].map { |x| x.is_a?(Integer) ? x : evaluate(x) })
    DATA[key] = { args: value }
    value
  end
end

Signal.trap('INT') do
  exit 1
end
puts evaluate(ARGV[1])

