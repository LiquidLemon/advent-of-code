data = gets.chomp
level = 0
data.split("").each.with_index(1) do |x, i|
    if x == "("
        level += 1
    else
        level -= 1
    end
    puts i if level == -1
end
puts level
