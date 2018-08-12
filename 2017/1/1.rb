DATA = File.read('1.in').chars.map(&:to_i)

def calculate(data)
  step = DATA.size / 2
  data.each_with_index.reduce(0) do |acc, (n, i)|
    acc + (n == data[(i + step) % (data.length - 1)] ? n : 0)
  end
end

puts calculate(DATA)
