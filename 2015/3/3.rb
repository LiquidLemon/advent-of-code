data = File.read("3.in")
houses = {}
position = [0,0]
houses[position] = true
directions = data.split("").each do |x|
    case x
    when ">"
        position[0] += 1
    when "<"
        position[0] -= 1
    when "^"
        position[1] += 1
    when "v"
        position[1] -= 1
    end
    houses[position.clone] = true
end
puts houses.count

houses = {}
position_1 = [0,0]
position_2 = [0,0]
position = position_1
houses[position.clone] = true
directions = data.split("").each do |x|
    case x
    when ">"
        position[0] += 1
    when "<"
        position[0] -= 1
    when "^"
        position[1] += 1
    when "v"
        position[1] -= 1
    end
    houses[position.clone] = true
    position = position.equal?(position_1) ? position_2 : position_1
end
puts houses.count
