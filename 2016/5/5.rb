require 'digest'

INPUT = 'wtnhxymk'
password = ''
password2 = []
(0..Float::INFINITY).each do |i|
  md5 = Digest::MD5.hexdigest(INPUT + i.to_s)
  if md5[0..4] == '00000'
    password << md5[5] if password.size < 8
    puts "i: #{i}; md5: #{md5}; password: #{password}"
    if ('0'..'7').include?(md5[5]) && password2[md5[5].to_i].nil?
      password2[md5[5].to_i] = md5[6]
      puts "i: #{i}; md5: #{md5}; password2: #{password2.join}"
    end
  end
  break if password.size == 8 && password2.select { |x| !x.nil? }.size == 8
end
puts password
puts password2.join
