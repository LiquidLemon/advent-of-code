require 'set'

class Set
  def pop_min
    min = self.min
    delete(min)
    min
  end
end

Cart = Struct.new(:x, :y, :dir, :next_turn) do
  def <=> other
    raise ArgumentError unless other.is_a? Cart
    [y, x] <=> [other.y, other.x]
  end
end

carts = Set.new
grid = ARGF.readlines.map(&:chomp).map.with_index do |line, y|
  line.chars.map.with_index do |c, x|
    case c
    when ?<
      carts << Cart.new(x, y, [-1, 0], 0)
      '-'
    when ?>
      carts << Cart.new(x, y, [1, 0], 0)
      '-'
    when ?^
      carts << Cart.new(x, y, [0, -1], 0)
      '|'
    when ?v then
      carts << Cart.new(x, y, [0, 1], 0)
      '|'
    else
      c
    end
  end
end.transpose

debug = proc do
  grid.transpose.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      if cart = carts.find { |c| c.x == x && c.y == y }
        case cart.dir
        when [-1, 0] then print ?<
        when [1, 0] then print ?>
        when [0, 1] then print ?v
        when [0, -1] then print ?^
        end
      else
        print cell
      end
    end
    print "\n"
  end
end

run = ->(carts, part) do
  loop do
    new_carts = Set.new
    until carts.empty?
      cart = carts.pop_min
      cart.x += cart.dir[0]
      cart.y += cart.dir[1]

      if coll = (carts + new_carts).find { |c| c.x == cart.x && c.y == cart.y }
        return cart if part == 1
        if part == 2
          carts.delete(coll)
          new_carts.delete(coll)
          next
        end
      end

      case grid[cart.x][cart.y]
      when ?/
        cart.dir = [-cart.dir[1], -cart.dir[0]]
      when ?\\
        cart.dir = [cart.dir[1], cart.dir[0]]
      when ?+
        case cart.next_turn
        when 0
          if cart.dir[0] == 0
            cart.dir = [cart.dir[1], cart.dir[0]]
          else
            cart.dir = [-cart.dir[1], -cart.dir[0]]
          end
        when 2
          if cart.dir[0] == 0
            cart.dir = [-cart.dir[1], -cart.dir[0]]
          else
            cart.dir = [cart.dir[1], cart.dir[0]]
          end
        end

        cart.next_turn = (cart.next_turn + 1) % 3
      end
      new_carts << cart
    end
    carts = new_carts
    if part == 2 && carts.size == 1
      return carts.to_a.first
    end
  end
end

first = run.(carts.dup, 1)
puts "Part 1: #{first.x},#{first.y}"

last = run.(carts.dup, 2)
puts "Part 2: #{last.x},#{last.y}"
