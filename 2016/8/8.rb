require 'matrix'

class Display < Matrix
  def rect(width, height)
    (0...height).each do |i|
      (0...width).each do |j|
        self[i, j] = true
      end
    end
  end

  def rotate_row(row, shift)
    shift.times do
      last = self[row, self.column_count-1]
      (self.column_count-1).downto(1) do |x|
        self[row, x] = self[row, x-1]
      end
      self[row, 0] = last
    end
  end

  def rotate_column(column, shift)
    shift.times do
      last = self[self.row_count-1, column]
      (self.row_count-1).downto(1) do |x|
        self[x, column] = self[x-1, column]
      end
      self[0, column] = last
    end
  end

  def empty_count
    self.each.count { |x| x }
  end

  def print
    self.each_with_index do |v, row, col|
      $stdout.print (v ? "\u2588" : ' ')
      $stdout.print "\n" if col == 49
    end
    nil
  end
end

INPUT = ARGF.readlines
display = Display.build(6, 50) { false }
#require 'pry'; binding.pry
INPUT.each do |line|
  if match = line.match(/rect (?<width>\d+)x(?<height>\d+)/)
    display.rect(match[:width].to_i, match[:height].to_i)
  else
    if match = line.match(/x=(?<column>\d+) by (?<shift>\d+)/)
      display.rotate_column(match[:column].to_i, match[:shift].to_i)
    elsif match = line.match(/y=(?<row>\d+) by (?<shift>\d+)/)
      display.rotate_row(match[:row].to_i, match[:shift].to_i)
    end
  end
  display.print
  print "\e[K" + line
  print "\e[7A"
  sleep 0.3
end
display.print
puts display.empty_count
