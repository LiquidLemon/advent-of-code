input = DATA.readlines.map { |l| l.split(', ').map(&:to_i) }
min_x = input.map(&:first).min
max_x = input.map(&:first).max
min_y = input.map(&:last).min
max_y = input.map(&:last).max

areas = [0] * input.length
close = 0

(min_x..max_x).each do |x|
  (min_y..max_y).each do |y|
    closest = input.each.with_index.map do |point, i|
      distance = (point[0] - x).abs + (point[1] - y).abs
      [distance, i]
    end.sort

    close += 1 if closest.sum(&:first) < 10_000

    next if closest[0].first == closest[1].first

    if [min_x, max_x].include?(x) || [min_y, max_y].include?(y)
      areas[closest[0].last] = -Float::INFINITY
    else
      areas[closest[0].last] += 1
    end
  end
end

puts "Part 1: #{areas.max}"
puts "Part 2: #{close}"

__END__
61, 90
199, 205
170, 60
235, 312
121, 290
62, 191
289, 130
131, 188
259, 82
177, 97
205, 47
302, 247
94, 355
340, 75
315, 128
337, 351
73, 244
273, 103
306, 239
261, 198
355, 94
322, 69
308, 333
123, 63
218, 44
278, 288
172, 202
286, 172
141, 193
72, 316
84, 121
106, 46
349, 77
358, 66
309, 234
289, 268
173, 154
338, 57
316, 95
300, 279
95, 285
68, 201
77, 117
313, 297
259, 97
270, 318
338, 149
273, 120
229, 262
270, 136
