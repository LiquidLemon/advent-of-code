input = DATA.readlines.map { |line| line.split(/[^\d]+/)[2].to_i }

def deterministic(starting_positions)
  dice = 0
  positions = starting_positions.dup
  scores = positions.map { 0 }
  rolls = 0
  player = 0

  loop do
    increment = 0
    3.times {
      dice = (dice % 100) + 1
      increment += dice
    }
    positions[player] = (positions[player] - 1 + increment) % 10 + 1
    scores[player] += positions[player]
    rolls += 3
    if scores[player] >= 1000
      return scores[(player + 1) % 2] * rolls
    end
    player = (player + 1) % 2
  end
end

def dirac(starting_positions)
  universes = { [starting_positions.dup, [0, 0]] => 1 }
  player = 0

  won = [0, 0]
  while !universes.empty?
    new_universes = Hash.new(0)
    universes.each { |(positions, scores), count|
      [
        [3, 1],
        [4, 3],
        [5, 6],
        [6, 7],
        [7, 6],
        [8, 3],
        [9, 1],
      ].each { |increment, multiplier|
        pos_1, pos_2 = positions
        score_1, score_2 = scores

        if player == 0
          pos_1 = (pos_1 - 1 + increment) % 10 + 1
          score_1 += pos_1

          if score_1 >= 21
            won[0] += count * multiplier
            next
          end
        else
          pos_2 = (pos_2 - 1 + increment) % 10 + 1
          score_2 += pos_2

          if score_2 >= 21
            won[1] += count * multiplier
            next
          end
        end

        new_universes[[[pos_1, pos_2], [score_1, score_2]]] += count * multiplier
      }
    }

    universes = new_universes
    player = (player + 1) % 2
  end

  won
end

puts deterministic(input)
puts dirac(input).max

__END__
Player 1 starting position: 4
Player 2 starting position: 10
