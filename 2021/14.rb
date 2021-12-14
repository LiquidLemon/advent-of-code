# There's a lot of repeated code here, I didn't want to extract it until I had
# something more optimized (for which I just don't have the time now).
# All this does is it cuts the iteration length in half, which makes
# a bruteforce approach somewhat viable at 3 minutes on my machine.
# That's good enough considering I can't come up with a proper algorithm.

input = DATA.readlines(chomp: true)

template = input[0].freeze
rules = input.drop(2).map { |x|
  pair, _, insert = x.split
  [pair, insert]
}.to_h.freeze

polymer = template
10.times { |i|
  last = polymer[-1]
  polymer = polymer.each_char.each_cons(2).flat_map { |pair|
    a, _ = pair
    [a, rules[pair.join]]
  }.join
  polymer += last
}

counts = polymer.each_char.tally.values
puts counts.max - counts.min


growth = Hash.new
rules.keys.each { |pair|
  polymer = pair
  20.times {
    last = polymer[-1]
    polymer = polymer.each_char.each_cons(2).flat_map { |pair|
      a, _ = pair
      [a, rules[pair.join]]
    }.join
    polymer += last
  }
  tally = polymer.each_char.tally
  tally[pair[0]] -= 1
  tally[pair[1]] -= 1
  growth[pair] = tally
}

polymer = template
20.times { |i|
  last = polymer[-1]
  polymer = polymer.each_char.each_cons(2).flat_map { |pair|
    a, _ = pair
    [a, rules[pair.join]]
  }.join
  polymer += last
}

tally = polymer.each_char.tally
polymer.each_char.each_cons(2) { |pair|
  growth[pair.join].each { |k, v|
    tally[k] += v
  }
}

counts = tally.values
puts counts.max - counts.min

__END__
BNSOSBBKPCSCPKPOPNNK

HH -> N
CO -> F
BC -> O
HN -> V
SV -> S
FS -> F
CV -> F
KN -> F
OP -> H
VN -> P
PF -> P
HP -> H
FK -> K
BS -> F
FP -> H
FN -> V
VV -> O
PS -> S
SK -> N
FF -> K
PK -> V
OF -> N
VP -> K
KB -> H
OV -> B
CH -> F
SF -> F
NH -> O
NC -> N
SP -> N
NN -> F
OK -> S
BB -> S
NK -> S
FH -> P
FC -> S
OB -> P
VS -> P
BF -> S
HC -> V
CK -> O
NP -> K
KV -> S
OS -> V
CF -> V
FB -> C
HO -> S
BV -> V
KS -> C
HB -> S
SO -> N
PH -> C
PN -> F
OC -> F
KO -> F
VF -> V
CS -> O
VK -> O
FV -> N
OO -> K
NS -> S
KK -> C
FO -> S
PV -> S
CN -> O
VC -> P
SS -> C
PO -> P
BN -> N
PB -> N
PC -> H
SH -> K
BH -> F
HK -> O
VB -> P
NV -> O
NB -> C
CP -> H
NO -> K
PP -> N
CC -> S
CB -> K
VH -> H
SC -> C
KC -> N
SB -> B
BP -> P
KP -> K
SN -> H
KF -> K
KH -> B
HV -> V
HS -> K
NF -> B
ON -> H
BO -> P
VO -> K
OH -> C
HF -> O
BK -> H
