require 'pry'
require 'set'
diffs = DATA.readlines.map(&:to_i)

sum = diffs.sum

puts "Part 1: #{sum}"

freqs = Set.new
diffs.cycle.reduce do |freq, diff|
  if freqs.include?(freq)
    puts "Part 2: #{freq}"
    break
  end
  freqs.add freq
  freq + diff
end

__END__
+16
+9
+11
+13
+11
+3
+8
+9
+14
+16
-5
-15
+5
-7
-5
-18
-9
+2
+1
+18
+15
+6
+19
-9
+1
+15
-10
-3
-18
+7
-1
+7
+6
+13
+10
+10
+9
+18
+2
+15
-19
+13
+8
-18
+6
-12
+10
+5
-6
+14
+8
+2
+2
+12
-2
+5
-11
-2
+7
+7
-19
-6
-1
-12
+16
-2
+13
+17
+15
-9
+3
+16
+13
+14
+17
-10
+1
+3
+10
-18
-1
-15
+5
-16
-7
-9
+18
+17
+3
+8
+7
-3
-11
-19
-8
-10
-11
-5
-1
+19
-8
-9
+11
+16
+11
+3
+17
+14
+9
+15
+7
-15
+16
+6
-2
+13
+5
+16
-6
-3
+7
+10
-4
-18
+16
-6
-1
-18
-3
+13
-18
-10
+19
-13
+20
-10
-17
-10
-1
+10
-8
-15
+4
+18
-16
-13
-15
-8
+4
-6
-14
+4
-22
-9
-6
+9
-4
-16
+19
-25
+12
-10
-21
-3
-6
-4
+16
-21
-17
+13
-10
-8
+6
-19
+15
+17
-5
+3
-8
-12
-11
-14
+16
-6
-11
+8
+19
-9
+7
-21
-22
+4
-10
-2
-11
-10
-2
+19
+18
+10
+5
+3
+7
+1
+10
+4
-6
+23
-5
+4
+10
-12
+21
+7
-20
+3
+29
-11
-22
-16
-1
-9
-4
+22
-29
-5
-2
-24
-9
-13
-10
-16
-15
-18
+13
-2
-12
-3
-16
-9
-6
-3
-7
-18
-16
-12
-9
-19
-5
-11
+1
-5
-4
-11
-7
+15
+5
-3
+2
+16
-6
+15
-6
+9
-13
+21
-5
-4
+18
+13
-6
-3
+8
+2
+12
+2
+17
-4
-16
+15
-8
+1
-11
+2
-15
+21
+1
+5
-16
-4
+22
+17
+17
+7
+6
-16
+5
-10
+17
+6
-14
+7
+12
+3
-11
+6
+4
+19
+10
-12
-10
+1
-16
+19
+4
+11
+13
-14
-2
-13
+8
-13
-11
-18
-5
-15
-7
+10
+14
-1
-12
+9
+12
-18
+14
-27
+17
-5
+2
+33
-2
+25
+14
-6
-1
+15
+1
-8
-13
+9
+7
-26
-6
+26
+8
+10
-5
+18
-5
+14
-11
+6
+28
-40
-6
+8
+12
-5
-23
-8
-3
-21
-43
-9
-5
-9
-16
-16
-13
-3
-4
+13
+12
+1
+16
+21
-1
-8
-24
+14
-21
-6
-7
-19
+3
-4
-14
+8
+8
+10
+7
-10
-12
-13
-13
+11
-13
-10
-7
-9
-18
+13
-4
-20
-7
-4
+9
+1
+13
-11
-10
-10
+4
-6
-5
-19
-14
+1
+1
+10
+10
-14
-11
-13
-11
-12
-11
-7
-13
+22
+31
+6
-1
+42
+21
+11
+5
+10
+1
+2
+20
+10
-14
-1
-8
+2
+19
+26
-14
-2
-1
+2
-20
+13
+25
-15
+14
+33
-3
+7
+20
+12
+14
-7
+36
-2
+7
+71
+30
-16
-4
+69
-15
-32
+203
-7
-6
-4
-5
-20
-28
-21
-21
+18
+183
+22
+11
+16
+2
-31
-28
+21
-61
-104
+7
+50
-58
+178
-89
+68771
-13
-18
+6
-4
-9
+17
+13
-7
+1
+19
+19
+12
+1
+12
+18
-6
-7
+18
-19
+13
+10
+6
+9
+3
-19
-16
-14
+19
+14
-15
-8
-9
-12
+14
+20
-3
-14
-16
-13
-2
-10
-12
+11
+10
+11
+1
+13
-1
-1
+5
-19
-14
+3
-9
-17
+4
+18
-7
-3
+13
+7
+2
+8
-22
+21
+8
-1
-13
+24
+19
+16
+1
-13
+15
+8
+17
+5
+2
+16
+7
-11
+14
-18
-1
-16
-8
+4
-12
+13
+13
-15
-16
-13
+3
+9
-5
-14
+4
+13
+17
+8
-2
-12
+7
+19
-15
+13
-5
+6
+10
+8
-6
-21
+15
+18
+19
-5
-1
+3
+15
-8
+13
+5
-1
+8
+12
-14
-17
-11
+19
-4
-23
-18
+5
-2
+7
+15
-19
+14
-3
-2
-14
+18
+9
-5
-12
+19
+2
+20
+10
-1
-15
-8
+15
+11
+7
-16
+10
+12
+4
-15
+12
+9
+4
+14
-4
-3
-5
+4
-14
-1
-13
+7
-19
+3
+20
+6
-1
+18
+13
-16
-8
+15
+18
-7
-4
-19
+14
-3
+5
+11
+20
-4
+10
-11
+13
+4
-2
-18
+6
+19
-13
+15
+11
+1
+1
+13
+19
+14
-8
-4
+17
-12
+8
+7
+9
+2
-16
-5
+13
+10
-8
-16
+12
-20
-15
+8
+14
+10
-16
-10
-20
-9
-11
+8
+8
+13
-6
+3
+2
+11
-18
+9
+7
-2
+1
+18
-9
+19
+10
-15
+3
+14
+19
-8
+3
+17
-7
-11
+7
+3
-19
+17
+19
+9
+10
+8
-14
-6
-18
+10
+15
-10
-1
-13
-4
+20
-14
+18
+18
+1
+1
+11
+14
+18
+4
-18
+13
+3
+13
+9
-6
+8
-7
-9
+2
-24
-3
+9
+9
-14
-8
-7
-1
-3
-7
-19
-2
-19
+5
-6
-10
+8
-16
-23
+14
+30
+7
+20
+17
-3
+10
-9
+12
+19
-18
-3
+19
-9
-15
+6
-7
+21
-9
-8
-11
-13
-4
+18
-6
-1
-13
+17
-2
-7
+8
-18
-19
+24
-13
+4
-36
-17
+7
-4
-6
-21
+4
-17
+6
-26
+13
-7
-17
+10
-7
+12
-18
-17
-3
+12
-15
-12
+3
-12
+19
-20
+5
+4
+8
-15
+14
-20
+18
+18
+15
-8
-1
-12
+17
+17
+13
+15
+20
+21
+16
-21
+11
-8
+24
-7
-5
-7
+36
+12
-1
-20
+66
-5
+16
+5
+5
-11
+24
+14
-9
-13
+39
-11
-26
+14
+14
-11
+44
-4
-2
+15
+12
-4
+2
+21
+17
-22
+2
+17
+15
+7
+17
+13
+7
+14
+9
-12
-7
+23
+7
+4
-16
-23
+16
+21
+3
+13
-4
+6
+18
-19
+5
+10
-25
+23
+11
+14
-1
-14
+19
+22
+2
+8
+22
+18
-38
+4
-20
-26
+20
-13
-20
-11
-3
-23
-31
-8
-1
+10
-31
-3
-22
-11
+19
+18
+1
-23
-5
-33
+8
-7
-33
-3
+44
-60
+11
+85
+177
+18
-126
+50
+128
-44
+68095
-7
-6
-17
-18
-137490
