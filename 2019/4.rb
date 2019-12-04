def is_password(combination)
  digits = combination.digits
  return false if digits.length == digits.chunk(&:itself).to_a.length
  digits[0..-2].zip(digits.drop(1)).all? { |x, y| x >= y }
end

def is_actual_password(combination)
  digits = combination.digits
  return false unless digits.chunk(&:itself).map(&:last).map(&:length).any?(2)
  digits[0..-2].zip(digits.drop(1)).all? { |x, y| x >= y }
end

low, high = DATA.read.split(?-).map(&:to_i)

passwords = (low..high).count(&method(:is_password))

puts "Part 1: #{passwords}"

actual_passwords = (low..high).count(&method(:is_actual_password))

puts "Part 2: #{actual_passwords}"
__END__
156218-652527
