PLAYERS, LAST = DATA.read.scan(/\d+/).map(&:to_i)

class Node
  attr_accessor :value, :next, :prev
  def initialize(value)
    @value = value
    @next = self
    @prev = self
  end

  def prepend(value)
    new = Node.new(value)
    new.next = self
    new.prev = self.prev
    self.prev.next = new
    self.prev = new
    self.next = new if self.next == self
    new
  end

  def clockwise(n = 1)
    it = self
    n.times do
      it = it.next
    end
    it
  end

  def counter_clockwise(n = 1)
    it = self
    n.times do
      it = it.prev
    end
    it
  end

  def remove
    self.prev.next = self.next
    self.next.prev = self.prev
    value
  end

  def puts
    print "#{value} "
    it = self.next
    while it != self
      print "#{it.value} "
      it = it.next
    end
    print "\n"
  end
end

def run(players, last)

  current = Node.new(0)
  scores = Hash.new(0)

  (1..last).zip((1..players).cycle).each do |marble, player|
    if marble % 23 == 0
      scores[player] += marble
      current = current.counter_clockwise(6)
      value = current.prev.remove
      scores[player] += value
    else
      current = current.clockwise(2).prepend(marble)
    end
  end
  scores.values.max
end

puts "Part 1: #{run(PLAYERS, LAST)}"
puts "Part 2: #{run(PLAYERS, LAST * 100)}"
__END__
412 players; last marble is worth 71646 points
