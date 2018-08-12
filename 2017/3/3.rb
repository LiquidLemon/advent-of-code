DATA = 325489

Vector2 = Struct.new(:x, :y) do
  def taxi_distance
    x.abs + y.abs
  end

  def +(other)
    Vector2.new(x + other.x, y + other.y)
  end

  def adjacent
    [
      self + Vector2.new(1, 0),
      self + Vector2.new(1, 1),
      self + Vector2.new(0, 1),
      self + Vector2.new(-1, 1),
      self + Vector2.new(-1, 0),
      self + Vector2.new(-1, -1),
      self + Vector2.new(0, -1),
      self + Vector2.new(1, -1)
    ]
  end
end

class Cell
  attr_accessor :address

  def initialize(address)
    @address = address
  end

  def get_pos
    ring = Math.sqrt(@address).ceil / 2
    ring_start = Vector2.new(ring, -ring+1)
    side_len = ring * 2 + 1
    first_in_ring = (side_len - 2) ** 2 + 1

    corners = []
    corners[0] = first_in_ring + side_len - 2
    corners[1] = corners[0] + side_len - 1
    corners[2] = corners[1] + side_len - 1
    corners[3] = corners[2] + side_len - 1

    case @address
    when first_in_ring
      ring_start
    when first_in_ring..corners[0]
      ring_start + Vector2.new(0, @address - first_in_ring)
    when corners[0]..corners[1]
      ring_start + Vector2.new(corners[0] - @address, corners[0] - first_in_ring)
    when corners[1]..corners[2]
      ring_start + Vector2.new(-side_len + 1, corners[1] - @address + side_len - 2)
    when corners[2]..corners[3]
      ring_start + Vector2.new(@address - corners[3], -1)
    end
  end
end

puts Cell.new(DATA).get_pos.taxi_distance

address = 2
values = Hash.new(0)
values[Vector2.new(0, 0)] = 1

loop do
  cell = Cell.new(address)
  pos = cell.get_pos
  values[pos] = pos.adjacent.map { |v| values[v] }.sum
  if values[pos] > DATA
    puts values[pos]
    break
  end
  address += 1
end
