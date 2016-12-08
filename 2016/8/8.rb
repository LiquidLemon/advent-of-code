require 'matrix'

class Display < Matrix
  def rect(width, height)
    (0...height).each do |i|
      (0...width).each do |j|
        self[i, j] = true
      end
    end
    self.print(true)
  end

  def rotate_row(row, shift)
    shift.times do
      last = self[row, self.column_count-1]
      (self.column_count-1).downto(1) do |x|
        self[row, x] = self[row, x-1]
      end
      self[row, 0] = last
      self.print(true)
    end
  end

  def rotate_column(column, shift)
    shift.times do
      last = self[self.row_count-1, column]
      (self.row_count-1).downto(1) do |x|
        self[x, column] = self[x-1, column]
      end
      self[0, column] = last
      self.print(true)
    end
  end

  def empty_count
    self.each.count { |x| x }
  end

  def print(clear = false)
    self.each_with_index do |v, row, col|
      $stdout.print (v ? "\u2588" : ' ')
      $stdout.print "\n" if col == 49
    end
    $stdout.print "\e[6A" if clear
    sleep 0.07
    nil
  end
end

INPUT = ARGF.readlines
display = Display.build(6, 50) { false }
Signal.trap('SIGINT') { print "\e[?25h"; exit 0 } # show cursor
print "\e[?25l" # hide cursor
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
end
display.print
puts display.empty_count
print "\e[?25h" # show cursor
