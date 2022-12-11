input = DATA.read.split("\n\n").map { |monkey|
  lines = monkey.lines(chomp: true)
  items = lines[1].split(?:)[1].split(?,).map(&:to_i).freeze
  operation = lines[2].split("= ")[1].freeze
  test = lines[3].split.last.to_i
  if_true = lines[4].split.last.to_i
  if_false = lines[5].split.last.to_i

  [items, operation, test, if_true, if_false].freeze
}.freeze

def simulate(input, rounds, relief_factor)
  monkey_items = input.map { _1[0].dup }
  inspected = input.map { 0 }
  common_factor = input.map { _1[2] }.inject(&:*)

  rounds.times { |round|
    input.each_with_index { |monkey, i|
      monkey_items[i].each { |item|
        inspected[i] += 1
        expr = monkey[1].split

        arg = expr[2] == "old" ? item : expr[2].to_i
        new_value = item.send(expr[1].to_sym, arg) / relief_factor
        new_value %= common_factor
        new_monkey = new_value % monkey[2] == 0 ? monkey[3] : monkey[4]
        monkey_items[new_monkey] << new_value
      }

      monkey_items[i] = []
    }
  }
  inspected
end

p simulate(input, 20, 3).max(2).inject(&:*)
p simulate(input, 10_000, 1).max(2).inject(&:*)

__END__
Monkey 0:
  Starting items: 89, 73, 66, 57, 64, 80
  Operation: new = old * 3
  Test: divisible by 13
    If true: throw to monkey 6
    If false: throw to monkey 2

Monkey 1:
  Starting items: 83, 78, 81, 55, 81, 59, 69
  Operation: new = old + 1
  Test: divisible by 3
    If true: throw to monkey 7
    If false: throw to monkey 4

Monkey 2:
  Starting items: 76, 91, 58, 85
  Operation: new = old * 13
  Test: divisible by 7
    If true: throw to monkey 1
    If false: throw to monkey 4

Monkey 3:
  Starting items: 71, 72, 74, 76, 68
  Operation: new = old * old
  Test: divisible by 2
    If true: throw to monkey 6
    If false: throw to monkey 0

Monkey 4:
  Starting items: 98, 85, 84
  Operation: new = old + 7
  Test: divisible by 19
    If true: throw to monkey 5
    If false: throw to monkey 7

Monkey 5:
  Starting items: 78
  Operation: new = old + 8
  Test: divisible by 5
    If true: throw to monkey 3
    If false: throw to monkey 0

Monkey 6:
  Starting items: 86, 70, 60, 88, 88, 78, 74, 83
  Operation: new = old + 4
  Test: divisible by 11
    If true: throw to monkey 1
    If false: throw to monkey 2

Monkey 7:
  Starting items: 81, 58
  Operation: new = old + 5
  Test: divisible by 17
    If true: throw to monkey 3
    If false: throw to monkey 5
