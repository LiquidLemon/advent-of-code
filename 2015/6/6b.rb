data = File.readlines("6.in").map do |line|
    line.scan(/(on|off|toggle) (\d+),(\d+).*?(\d+),(\d+)/).first
end

$lights = Hash.new(0)

def change_state(state, x1, y1, x2, y2)
    (x1..x2).each do |x|
        (y1..y2).each do |y|
            case state 
            when "on"
                $lights[[x,y]] += 1
            when "off"
                $lights[[x,y]] -= 1 if $lights[[x,y]] > 0
            when "toggle"
                $lights[[x,y]] += 2
            else
                puts "error"
            end
        end
    end
end

data.each_with_index do |d,i|
    print "\r" + i.to_s
    change_state(d[0],d[1],d[2],d[3],d[4])
end
print "\n"
puts $lights.values.inject(:+)
