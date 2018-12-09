PLAYERS, LAST = DATA.read.scan(/\d+/).map(&:to_i)

def run(players, last)
  board = [0]

  current = 0
  scores = Hash.new(0)

  (1..last).zip((1..players).cycle).each do |marble, player|
    if marble % 23 == 0
      scores[player] += marble
      current = (current - 7) % board.size
      scores[player] += board.delete_at(current)
    else
      current = (current + 2) % board.size
      board.insert(current, marble)
    end
  end
end

max = scores.values.max
puts "Part 1: #{max}"
__END__
412 players; last marble is worth 71646 points
