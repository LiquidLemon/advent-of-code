messages = File.readlines('6.in').map(&:chomp)
columns = messages.map(&:chars).transpose
message = columns.map { |col| col.uniq.sort_by { |c| col.count(c) }.last }.join
puts message
message = columns.map { |col| col.uniq.sort_by { |c| col.count(c) }.first }.join
puts message
