def is_password(combination)
  digits = combination.digits
  return false unless digits.each_cons(2).any? { |x, y| x == y }
  digits.each_cons(2).all? { |x, y| x >= y }
end

def is_actual_password(combination)
  digits = combination.digits

  unless (digits[0] == digits[1] && digits[1] != digits[2]) ||
         (digits[-1] == digits[-2] && digits[-2] != digits[-3]) ||
         digits.each_cons(4).any? { |a, b, c, d| b == c && a != b && c != d }
    return false
  end

  digits.each_cons(2).all? { |x, y| x >= y }
end

low, high = DATA.read.split(?-).map(&:to_i)

passwords = (low..high).count(&method(:is_password))

puts "Part 1: #{passwords}"

actual_passwords = (low..high).count(&method(:is_actual_password))

puts "Part 2: #{actual_passwords}"
__END__
156218-652527
