class Triangle
  attr_accessor :sides
  def initialize(sides)
    @sides = sides
  end

  def valid?
    sides = @sides.sort
    sides[0] + sides[1] > sides[2]
  end
end

input = File.readlines('3.in').map(&:chomp)
triangles = input.map { |x| Triangle.new(x.split.map(&:to_i)) }
puts triangles.select(&:valid?).size

triangles2 = input.map { |x| x.split.map(&:to_i) }.transpose.flatten.each_slice(3).map { |x| Triangle.new(x) }
puts triangles2.select(&:valid?).size
