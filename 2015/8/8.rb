strings = File.readlines("8.in").map { |l| l.chomp }
sum = 0;
strings.each do |string|
  sum += string.length - eval(string).length
end
puts sum
sum = 0
strings.each do |string|
  new_string = string.gsub(/(["\\])/, '\\\\\1')
  puts string + ": " + new_string 
  sum += new_string.length + 2 - string.length
end
puts sum
