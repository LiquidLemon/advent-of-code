boxes = File.read("2.in")
dimensions = Array.new
paper_total = 0
ribbon_total = 0
boxes.split("\n").each do |x|
    dimensions = x.scan(/\d+/).map { |s| s.to_i }.sort
    sides = dimensions.permutation(2).to_a
    sides.each do |x|
        paper_total += x.first*x.last
    end
    paper_total += sides.map { |x| x.first*x.last}.min 
    ribbon_total += (dimensions[0]+dimensions[1])*2 + dimensions.inject(:*)
end
puts paper_total
puts ribbon_total
