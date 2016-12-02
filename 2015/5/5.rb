data = File.read("5.in").chomp.split("\n")
count = 0
data.each do |s|
    if s.scan(/([aeiou])/).length > 2
        if !s.scan(/(\w)\1/).empty?
            if s.scan(/(ab|cd|pq|xy)/).empty?
                count += 1
            end
        end
    end
end
puts count
count = 0
data.each do |s|
    if !s.scan(/(\w{2}).*\1/).empty?
        if !s.scan(/(\w).\1/).empty?
            count += 1
        end
    end
end
puts count
