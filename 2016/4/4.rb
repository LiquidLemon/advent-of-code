class Room
  attr_reader :id
  def initialize(name, id, sum)
    @name = name
    @id = id
    @sum = sum
  end

  def valid?
    @sum == get_sum
  end

  def get_sum
    histogram = @name.gsub(/-/, '').chars.group_by { |x| x }.map { |k, v| [k, v.size] }
    histogram.sort do |x, y|
      (x[1] <=> y[1]).zero? ? x[0] <=> y[0] : y[1] <=> x[1]
    end.map(&:first).first(5).join
  end

  def self.parse(string)
    /(?<name>.+)-(?<id>\d+)\[(?<sum>\w+)\]/ =~ string
    self.new(name, id.to_i, sum)
  end

  def get_decrypted_name
    shift = @id % 26
    table = ('a'..'z').to_a.zip(('a'..'z').to_a.rotate(shift)).to_h
    @name.chars.map do |c|
      table.fetch(c, ?-)
    end.join
  end
end

rooms = File.readlines('4.in')
rooms.map! { |line| Room.parse(line) }
puts rooms.select(&:valid?).reduce(0) { |memo, room| memo + room.id }
#require 'pry'; binding.pry
puts rooms.select { |x| x.get_decrypted_name.match(/northpole/i) }.map { |x| "#{x.get_decrypted_name} #{x.id}" }
