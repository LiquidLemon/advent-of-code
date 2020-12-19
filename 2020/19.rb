raw_rules, raw_messages = DATA.read.split("\n\n")

rules = raw_rules.each_line.map { |l|
  id, content = l.split(": ")
  [
    id.to_i,
    content.split(" | ").map { |terms|
      terms.split.map { |term|
        term[0] == ?" ? term[1...-1] : term.to_i
      }
    }
  ]
}.to_h

messages = raw_messages.each_line.map(&:chomp)

match = ->(string, rule_id, string_pos = 0) {
  rule = rules[rule_id]

  end_pos = []

  rule.each { |alternative|
    last_pos = [string_pos]
    new_last_pos = []
    alternative.each { |term|
      last_pos.each { |pos|
        case term
        when String
          if string[pos..].start_with?(term)
            new_last_pos.push(pos + term.size)
          end
        else
          match.(string, term, pos).each { |p|
            if p > pos
              new_last_pos.push(p)
            end
          }
        end
      }
      last_pos = new_last_pos
      new_last_pos = []
    }
    end_pos += last_pos
  }

  end_pos
}

puts messages.count { |msg|
  end_pos = match.(msg, 0)
  end_pos.any? { |x| x == msg.size }
}

rules[8] = [[42], [42, 8]]
rules[11] = [[42, 31], [42, 11, 31]]

puts messages.count { |msg|
  end_pos = match.(msg, 0)
  end_pos.any? { |x| x == msg.size }
}

__END__
76: 125 57 | 102 58
6: 57 30 | 58 123
62: 58 58 | 57 58
90: 122 57 | 87 58
82: 57 58 | 57 57
118: 102 57 | 125 58
7: 103 57 | 77 58
130: 27 58 | 53 57
101: 58 107 | 57 117
31: 55 58 | 81 57
114: 123 57 | 62 58
48: 103 58 | 94 57
105: 58 113 | 57 20
100: 57 88 | 58 35
127: 121 54
80: 54 58 | 72 57
19: 5 58 | 102 57
28: 95 57 | 23 58
43: 30 58 | 123 57
119: 58 71 | 57 33
44: 94 58 | 24 57
72: 58 58
35: 109 57 | 106 58
85: 127 58 | 132 57
25: 57 30 | 58 102
42: 119 58 | 111 57
86: 58 5 | 57 125
54: 57 121 | 58 57
88: 58 97 | 57 129
71: 110 57 | 46 58
67: 94 57 | 125 58
12: 5 58 | 62 57
112: 58 70 | 57 69
123: 58 57
52: 10 58 | 48 57
122: 14 58 | 68 57
68: 82 58 | 94 57
23: 57 54 | 58 24
64: 58 54 | 57 72
89: 41 57 | 28 58
132: 103 58 | 47 57
115: 58 133 | 57 49
116: 58 103 | 57 77
15: 77 57 | 24 58
92: 58 62 | 57 30
4: 58 99 | 57 75
59: 57 72 | 58 102
26: 52 57 | 108 58
58: "b"
14: 58 103 | 57 30
47: 57 57 | 58 58
37: 58 82 | 57 125
32: 125 57 | 123 58
95: 123 58 | 123 57
83: 57 36 | 58 79
128: 65 58 | 32 57
125: 57 58 | 58 57
11: 42 31
65: 62 58
75: 58 1 | 57 67
30: 57 57
102: 121 121
0: 8 11
111: 50 57 | 93 58
113: 57 126 | 58 40
129: 25 58 | 29 57
45: 5 57 | 94 58
104: 24 121
24: 58 121 | 57 58
49: 57 12 | 58 6
17: 57 123 | 58 54
3: 74 57 | 131 58
94: 57 57 | 58 57
98: 57 86 | 58 2
13: 34 57 | 78 58
21: 57 98 | 58 120
107: 86 58 | 17 57
57: "a"
9: 57 112 | 58 90
40: 57 104 | 58 45
38: 58 94 | 57 30
106: 57 63 | 58 76
97: 57 60 | 58 116
96: 57 77 | 58 72
41: 63 57 | 19 58
63: 24 58 | 62 57
78: 57 47 | 58 103
131: 30 57 | 62 58
77: 57 58
55: 57 9 | 58 100
69: 96 58 | 43 57
36: 72 57 | 123 58
33: 58 101 | 57 26
53: 58 47 | 57 94
70: 38 58 | 37 57
20: 84 57 | 13 58
2: 57 123 | 58 72
84: 58 16 | 57 66
34: 58 5 | 57 62
56: 85 58 | 3 57
126: 15 57 | 59 58
87: 57 80 | 58 51
93: 58 61 | 57 4
99: 58 92 | 57 16
110: 57 83 | 58 124
10: 57 24 | 58 62
27: 57 30
29: 54 57 | 103 58
103: 57 121 | 58 58
46: 57 18 | 58 130
50: 89 57 | 115 58
79: 57 5 | 58 103
1: 123 58 | 77 57
61: 57 128 | 58 39
109: 116 58 | 96 57
66: 82 57 | 47 58
117: 53 58 | 91 57
124: 118 57 | 7 58
22: 77 57 | 125 58
39: 58 66 | 57 44
51: 58 77 | 57 47
73: 57 56 | 58 21
60: 77 57 | 82 58
91: 24 58 | 123 57
16: 30 58 | 82 57
120: 22 57 | 64 58
81: 57 105 | 58 73
133: 58 114 | 57 44
18: 57 60 | 58 22
8: 42
108: 58 10 | 57 118
74: 30 57 | 77 58
121: 58 | 57
5: 57 57 | 58 121

aaaabbaaaaababbaabbbbbbbabbbbaabbabaabbbbbbbaaba
ababaaabbbabababbabbbbba
bbbbaaaaabbbababaaabbbaa
bbbbbaaaabbbababbaaaabab
aaabaababbabaabaaabababaabaaaaabbbbabbba
bbaaabababbaabbbbabaaababababaaaabbbaaba
bbbaabbabaabaabaababaaaaabaaabaabaabbbabbaababbb
aaaaaabbabbaabbbbbbbaaaaaaaaabab
bbaaabbbbaababaabbbbbbaabbbbababbabbabaaaabaababbaaaaabbaabaaaba
ababbbbbabbaabbbbbbbbaab
aabbabaaaaabbaabaaaaaabb
aaabaabaaababbabaaabbaba
bbbaaaabbbbbaaabbababaabaaaaabba
aaaabbbbaaabaabaaaaaaaabbaabbaaababbbbbb
bbbbbbaabbaaababababbaaabbabbbaabaaaaaaa
aaabbaaaaabababaaababbbbabbbbabbbabaaaabbbbaabbb
baabbbbbaabbbabaabbaaabbbaaaabaababaabbaabbabaaa
abbaaababaaabbbaaabbbababbaabbbb
bbbaaababbbbaaabbaabbbaaaaaabababbaabaaaabbaaaababbabbaa
bbaaaaabbbabbabbbbabbbaa
baabababbbaaababbabababbabaaabab
babbababbbaaababbbaaaaaabababbbbabaabbaababbbbaabbbaabab
bababbbbbbaaaaaabaabbbbb
aabaaaabbabababbabaaaabaaabbaaaabbabbbbbbbbbabaaababbabb
baabbaabaababbabbabbbaab
abaaabaaabbbabababbababbbaaaaaab
babbaaabaabababaabaabababaaababa
bbbaaaaaaaabbbababaaabab
aaababaaaabaabbbaabaaaabbbababbabababbabaaabbaabbbaabbababbaabab
abbbaabbbabababbbabaabaabbaabbbbabaabbbb
aaaaaaabbaabaabaaabbaaab
aabbabbabbabaabbabaababaaaaaabaa
aaabbaabbabaabaababbbbaa
baabaababbabbaababbabaabbbabbaabaaabbabbabbaaabb
babbbbabbaababaababbbbabbbbaabab
bbaaaaaaabbbbbaabbbbbaabbaaaabbb
aabbbbbbaabbabbabbbbaaaabbbaaaaaabbbaabaabaabaaa
aaabbabbbaaababbaaabaaaabbbaaaaaabbbbbabbababbba
ababbaaabbbabaabbabbbbabbababababababaabaabaaabb
babaaabababaaaaaabaaabbabbaaaababaababbb
bbbabaabaaaaaaabaaabbaaabaababbb
abbaaaaaabbaaabababababababaaaaabaabbbbbabbabbba
abbbaabbbaabaabaaaabbbabaabaabba
aababbaabbaaaaaaaabaabbbbbababaaabababaa
aaabbabbbabaaababaabaaab
bbaaaabbaaabbabbbbbabaababbbbabaabbabbba
bababaaabbaaaaaabaaaabba
baaabaaabaaabbbbbaaaaaaa
bbbaaabaababaabbbbbaabbaaaaaaaabaabbabab
abaababaaabbaaaaaabaabaaabbbabba
aabbbbbbbaaabbbbaaabaabbbbbaaabaabbaaabaabbbababbabbabba
bbaababaaabbbbabbbbaaabbbbbbbbbaabbbabbbaaaaabaa
aabababbaaabaaaaaaaaabab
babaabbbabaaaaaaababbabaababbbbaaaabbaaabbbaabaa
aabaaaabbbaaabbaaabababbbbbbbabbaabbbaaaaabaababbabaaabbbbababbbabbbbaaa
abaabbababbababbaaaabbabaaaabbaaaaaabaaa
bbbaabaaaaabaaaabaababaaabbaabaabbbbabaa
babbabbbbabababbaabaabbbbbbabbbbabbbbbab
abbbabaaaaaabaabaaabbabbabaaaabbabaaabbb
abaaabbababaaabaaababbaabbabaaabbabaabbbaaaabaaaaababbba
bababbbbbaabaaaabaabababbbbaaabaaabbbbaaaabbbbba
ababbbbbaabababbaaababaababbbbbaabaabbaaabaaaaabaabbbbba
babaabaaabbababbaaabbbabbaababba
baaaabbbbbaaaaaaaababbbbaabaabba
abbababbaabbbbbbbbbbbaba
baaaabaaaabbbaaaabababbbbaaabbabaaaabaaaababaaaabbabbbaa
baababbaaaaaaaaababbaabaabbaaabaabbbbaababbbabaabbabbaaabaaaabbbbaaababa
abaaabaaabbaabbbbababbaabaaababbaabababaabbbaaba
baabbaabbbbbababbbaaaaabaaaabaababbbaaababababaababbaabaababbaab
abbbaabbaaaabbaabbaabaab
aabbbaaaaabbbaaaabbaabab
aaaababbabaabbabaaaaabbb
aaababaaaaaaaabbaaaaabab
aaaaaaababbabbababababaa
aaabaaaabaaababbabaaabaabaaabaaabbabbbaaaaaaabaa
abbbababaabaabbbabaabababbaaababbaabbbaababbbaab
babaaaabbbbbbbbabbbaaaabbababaabbabbaaabbbbababbababbababaabbaaa
aaaabbabababbaaaaababbabbaabaaaaabbaabab
bbabaabbaaababaabbaabbbb
aabaabbbbbabbabaabbbbbbbaaaabaababbaaabaabbabbbb
babbabbbaaaabbaabaabbaabbbbbababbbaabbbaaaabbbbababbbaba
abbbbbbabbabaaaababbaabaabababbabbbbbababbbbbaababbbaaaa
ababbbbbaaaababbbabbabbbabaababbbbababbabbbaababaaabbbbb
baaaaaaabbaabbababababbabbbbbaba
bbaaabbbbabbaaaabbbbbaaabaabbaaa
abaaaaaaababbbabbbbbabba
babababbabbaaaaabbabbaabaabbbbaaabbaabba
bbabaaabbababaabbbbabbba
abaaabbaabbaabbbabbaaaaabaabbaabaabbaabb
babbaaabbabbbbbaaabaaaba
babababbbbbbbabbbababbba
abbbababbababaaabbbbababbabbbaba
bbaaaaabbaaababbbbbbaaabbabaabbbabbabbaa
bbabaaaaabaaaabbbaaaaaba
babaabaababbbbbaaaaaaabababababbaabaabaaabaabbbb
babbabaaaabbabbbbaabbbab
bbabaaabbbbbaaaaababababbaababaaabaabbbaabaaabbb
bababaaabbabbaabbabaaaaababbabbaabbabbba
abbaabababababbbabaaabbb
bbabbbaaaaaabbbbbbbaaababbabaabaaabaaabbaabaabaa
baabbaabbabbbbabbaaabaab
aaaaaaabbbbbababbbbbababbabaabbabbbbbbbb
baabaaaabaabbbbabbaaabbababbabaababaaabb
bbaaaaaaabaababbbbbaabaababbaaba
bbbababaaababbaababaaaabbbaabaabbaabbbbb
abaabbabababaaaabbbaabbabaababbbbabbabba
bbbabababbbbbaaabbbbaaabaabbbbba
abbaabbbbbbbababaaaabbbbabbababbbbaabbab
abaaabaabbabbbaaaabbabbbbbbaabab
babaaaaabbabaaaabbabbaaaababababaababbabbabaabba
bbaaabbbbabaaababbabbabaaaaaaababababababaaaaabbabbabbabbaabbbaaaaaaabba
abaaabaaaaabbaabababaaabbaababaababaabbabbbbbbababbbbaba
bbababbababaaababbabbbba
abbbabbaaababbaabbabbaaaaaabaaaababaabab
aaababaababaabaaaaababbbabaabaaa
bbbbbbaababbaaabbbbaaabaaaaaaaabbbbaaababaaabbab
babbbbbaaabababbababaaaababbbabbaabaabba
bbaaababbbabaababaaabbaabbabaaaaaaaabbaabaaaaabb
aabbbaabbbabaababaabbaabbaababba
bbaaababbabbbabbbabaabbbbbababbb
aaababbaaaaaaababbbaaabbabbbaaabaabbbbaaaabaabab
aaababaaabbbabababaaabbabbaaabaaaaabbbba
bbaaaaaaabbabaabbbbababaaaaabbbbaabaaabb
bbabbbababbbbbbbaaaabbaabbaabababaabaabb
babababbabaaabbabbbabbbb
bbabbaabababaaaaaabbabaabaabaabaaabbaaab
aaaaaaabbbabababbbaaaaba
baababaabbabbababaaaaaab
ababababababababbbbbbabbabaaabababbbbbaa
abaabaabaabaaaaaabbababaabbbabbb
babbbbabbababaabbaababba
bbabaaabbaababaaaaaaaaaa
baaabbbbbbbababaabaababaaabababbabbaababababaaba
abbababbbabaaaabaaaaabba
abaababbaabbbaaabbbabbbababbbbbaabababababbbbbabbbbabaab
bbabbbaabaaabaaaaaaaaabbbbaaaaabbbbbbaab
abbbbaababaabbababbbaaabbaabbbab
abbbabbaabbbababbbbaaababababbba
abbaabbbababaabbabaaaabaabaaaabbbabbaaba
aabbbbbabbaaaabbabbbbbababaabaabbabbabbbabbaaabbbaabababababbbbaaabbababbbabbbba
bbaaabbaabaababbababbaba
abaaabbaabaaabaaaaabbabbbabbbaab
ababababbbabaabbabaabaab
aababbabbababbbbaababaaa
abbaaabaaaabbaabbbbbbaab
aababbbbabbaabbaaabaaaaaabaababbabbbbbbbbabaabbbbbabbabb
ababaabbaaaabaabababbaaaabbbababbbabbbbb
abaabbabbababaaabbbabababaabbabbbbaaaaba
bbbaabbabbabbbabbabaaaaaaaaababbaaabbaabbababaaa
aabbabaaabbbabbabaababababaaaababaababaabaabbbaaabaabbaaabbabbba
aaaabbbbbaaababbbababaabbaaaabbbbbabababbaaaaabb
baaaabbbbbabaaaaaaababbb
abbbbaabaaabbbbbbababaaaabaabbbbbbaabaaabbbabbabbbbaaaabaabbbbabbababbbaaabbbabb
bbaaaabbabaaaabbabbaaababbbabaaabaaabbba
abbababbbbbaabbaaaaaabba
babbabaabbbbbabbaaabaaab
abaaabbaaaababaabbaabbbb
abaabbabaaabbaabbaabababbbbabaaaabababba
ababababbabbbaaaababbabb
bbbbabaabbbbbbbbbabbbabbbbbbabaa
babaaaaaaabbabbababaabaababbabba
bbaaabbabababaabaaaaabab
abbbaaabaabaabbbbabbaaababbababbbaabaaab
abaaabaaaaabbabbbbbaabaaababbbbbaabbbbba
aabababbaaaabbbaaaabbbba
aabbbaabbbbaaabbbbbaabbaabababaa
bababbabbbabaababbbaaababababbaaaababbaabbbababb
bbbababaaababbabbabbbaba
aababababababbaababbbaba
aababbabaabbabbbaabaaaabaabbbabb
bbabababbababaaaaaababbabbbaabbb
aababbabbbaaaaabbbabbbba
bbaaaaabbaabaababaaabaaaaababbabbbbbaabbbaabaabbaaaaabbb
baabbaabbbbaaabbababababbbaabbbb
aaaabaaaaaabaaababaababbabbbbbbbababababaaabbbbbaabaaaba
abbbababbababbaabababbba
abbbbbbbaababbabbabbbaaaabaaaabbbaaabbbbbbaaabaaaaaaabbababbbbaa
babbbbbababbaaaaaaaaabaa
abbbbbbaaaaabaabbaaaaabb
aabaaaabbabababbbbaaababaabbbaabbaabbaaabbaabbaabbbbabaa
baaaabbbbaaabbbbaabbbaabbaabaabaaaaabbaaaaaaabaa
aaababbabababaaaaababbbbabababba
bbabbababaabaabaaabbbbbbababaabbabaaaabbabbbbbab
aababbabbbbaaaabbbaababaaababbaabbbbbaba
bababbabbbbbbbaababbbbaa
ababababaaaaaabaabbbbbbaaababbaabaaabaaaaabaaabb
aabbabbbababaaababaababbaababaaa
bbbaabbabaabbbbabbbaabbabaaaaaaa
aabababbabbaaabaaaabaaaaaaabbbabaabbbaba
aaabbaabbbbabaababbaaaab
baabbbbaaaaabaabbaaaaaaa
aaabbaaaabbbabaaababababbbabbbaabbbbaaaaabbbbaaa
aabbbaabbbbbbabbabaababaaaabaabaabbaaaaa
babbabaaaabbbbbbaaabababbbbbbaab
bbbbbabbbababababaaabaaaabaabbbbabaaabab
babbbbbabbaaababbbbabbaa
aaaaaabbbabbbbabbbaaaaabbbbaaaabaabaabaabaababbb
aabbbaaabbbbaaaaabaabaaa
aabababbbababbabaaaaabba
bbbbababbbaaaaaababaabba
aabbaaaaaabbabaaaaaaaabbbbaaabbabbbbbbab
aaaaaabbbbbbababbaaabbba
bbaaaaaababbababbbaaabaa
aaabbaaabbabbbababbbbabbbabaaaaaabbabbababbbbabaabaabbba
babaabaaaaababaabaabbaba
bbabbabaaabbbbabaaaaaababbbbaaabaabaaaababbbbbab
bbababbaabaababbbabbabbbbbaabbba
baaabbaaababbaaabababbabaabbaaaabaaaaaaa
abaaabababbbaaaaaaaaaabbbababbbabababbab
aaaaababaaabbbbbabbbbbab
aaaabbbabbaaaaaaaabaabaa
aabbbbbbabbaaababbaaaaaaaabbabbbbaabaabb
aabbbaabaaabaaaaaabbbbaabaabbaaa
ababbaaaabbbababbbbababb
babaabbbbaababbbbabbaaaaababbabababaaaabaabaaabaabaabbbababbbabb
baaaabbabbbbabbbbababbbbbbabbbaabbbbaaaabbbabaaa
aaabaaaaaaabaababbbbbabbbaababbaaabbaaba
bbabbaaaababaaabbbababaaaaaaabaaaaaaababaaabbbba
aaaabaabaabababbabaabbbb
bbababbaaababbabbabababaaabbaaba
abaaaabbbabbabaabbbbbbab
babaaaababaababaaabbabbbbbbbabba
aaaabaabaaabbabaaaabaaaaaabbbbaaaaaaaabbbabaabbbababbbbb
aaababaababaaabaabbaabbbaaabaaaababaabbbbaabaabb
baababaabbbbbbbababbaaabababbaaaaaaabbaabbabaabbbaaaaabbaabbbbba
bbabbaaabbbaaaabababbbba
bbbbaabbbabaaaaaaaaaaababaabaaaabaabbbabbbaababbbabbbbbbaabaaabb
abaaaabaaaaabaabababaaaabbbbaaab
ababaabbbbbbababbabbbbababaaaaaaabbbaaaa
aaaabbbbabbbbbbaabbbbabbabaaabbb
aabaababbbbbabbabbaaabaaabbaaaab
bababbabbaaaabbbabbabbab
ababbbbbbbbaabaaababbbbbbbaababb
aababbaaaaaabbbbaabbaaaababababbaabaaaaababbbbbbaabbbabb
bbaaaabbabbbbbbaaaabbaabaabbabab
aabbabbaaabaaaabbaababababaaabbb
ababababbbaaaaabaaaabbbaabbbbbbabaabababbabaaababbaabbbabbaabbaa
aabbabbaabbababbabbabaabbabbabba
baaaabbbabbabaabaaabbaabbaaaabaabaaabbba
bbbbaaabbabaaabaababaaaababbababababbaaababaaabbaabbbabbababbbba
bbbabaabbbbaaabababbaaabababbbbaabbababa
bbbaabaaaabbbbbbababbbbbababbbabbbabbbbabbbabbaa
babbababaaaabbbbabbbbaaa
bbabbbabbbaaaaaaaabaaabb
bbabababbbabaaabbaabbbbaaababaaa
aabaaaabbbbaaaaabababbbbabbaabba
aabbbbbbbabaaaaabaaaabaa
bbaaaaaabbbbbabbbbaabbba
bababbbbbabaaabbaaaabbba
ababaaabbababaabababbbbbabbbaaabbbaabbba
bbbbbbbaaaabbbababaaaaab
aaababbababbababbabbbaaaaaababababaaaababababbabbabbabaabaababbabbaaababbbabbbab
babbababbbabaabaabbbaaaa
babbabaaaaaabbabaababbba
babbaaabbabaaaaaaaaabbbbbbbaabbaaababbba
aaabaababaabaaaaaaaabaabaababababbaabbba
bbbaabbabbbaaaaaaabbbaabbbaaaaababaaaaaaaaaabaaaaaabbbba
abbbabbabbababbababbaaba
bbbaaaaabababbaabbbabaaa
babbabbbabbaaabaabbbaabbaabbbbaaaaabbabbaaabaababaabbaaa
bababbbbbbabbaaaabababaa
bbabbaabababababbaaaabaa
babaabaabbabaabbabbbbbbbababaaaaaabbbbbbbbbbababbaabbaba
bbaaabbaaaabaaaaabbaababaabbabab
bbbaaaaaabbbabbaaababbba
aaaabbaaaabaabbbbabaaaabbbbbbbbb
abbababbbbabbaaabaabaaab
aaababbbabbbaaabbbaaabbbaababbbbbabababaaababababbaabaab
bbabbbbaababbbaaabbbbabaaababaaa
bbbaabaaabbbbabbbaaabaaaaabaaaabbbbbaababbaaabaaaaaaaaaa
aaabbbabbbaaababbbabbaaabaaabbaaaaabababbaabbbab
bbabaabbaabbbbaaaabbaaaabaababbbabaabaaa
baaabbbbbbaaabbaabbbbbbaaaabaaab
bbbaaabbabbaaaaabaababbb
aabbabbbaaabaabbbabababbbabbbbabbbabaaabaaaaaaaaaaabbbba
bbbaabbaaaaabbbababbbbaa
aaaaaaabbbaaababaaabaabababbbaba
babababbbaababababaaaabaaaabbbaa
bbbaaaaaabbbbaabaaabaabbbbbaaabb
bbbbbaaabbbbbbbaaaaabbaaaaaabaaa
aabababbaaabbbabbbabaabbbaaabababaaaaaaa
bababaaabbabbbaabaabbaabaaaabbbbbaaababbbbabbabbbaababbb
bbbbbabbaaabbaabbbaababb
bbaaaabbaaabbabbbbabbbaababbbaabbbbbbbab
ababaabbbbabbaabbaaaaaaa
abaaaabaabaababbbababbabaabaababaaaaaaaa
abbbabaabbabababbbbaaaaaabbaabab
bbbbbabbaabbbbaaabbbbbba
bbaaaabbaaaababbbbbbbabbbababbbbaabbabaaaaabbbbbbabaabba
bbbaabaababaaaabaaabbbba
bbababbabbbbabbababaababbbabbbbbaabaabbaabbbabab
abbbabbabbabaabbbaababaaababaabbbbaabaaa
bababaaaaabbbaabbbbbbaabbaabbabb
abbbbbbaabbaaaaaaabbaaaaaabbbaaababaababbbbabbba
bbbabababbbaaabbabbbaaababbbabbb
aaaabaabaabbaaaaaaaaaabababbaabb
bbaaabbbababaabbbbbbbaaaababbabaaabbbbba
bbbaaabbaabaabbbaabbbbaaaababbbbabbbaabbbbaabbba
ababaaabbbabbbabaabababbabababaabbababaa
aabbabbbbabbaaababbbbbab
abaaabbabababbababbaabbbaaaabbabaababbaabbababaaabababbabbbbbbbb
abaabaaababbaabbbbbabaabbabbaabbabaabbaa
ababbbbbaaababaaaababaaa
abaaaabbaabbabbaaabbaaba
baabaaaabbbbababaabbabaaaababbaaabbabbbaabaabbaa
aaabaababaaababbaabbabbbbbbaabbb
abbbababbbabababbaabaabababbabababbbabbaaaaaaaaabaabbabb
abaaabbaaaaaaabbaaaabbaaaaababbababbabaabbaabbabbaabaabb
bbbaabaabbaaaaabaaabbabbaaaababa
bababbaaabbabbabbaaabbabbabaaabbaaaaabba
aabaabbbbaabbbbabababaababaabbbbbbbabbba
bbaabbbaabaabaaabbaabbbb
bababababaaaabbbbbaabbab
bbbbbabbaabaabbbbababbaaabbbaababbbbbbbb
abababaabbbbaaaababaaaaabbaaabbbabbababbbabaabba
abbbbabbbaabbbbaaabbbaababbbabbabaaaabaaaababaab
abaaaaaabababbaaaabbaaab
bbaaaababbbbbbbbbaaaabab
bbaaabbbaababababaabaaaaabaaabaaababbbabaabaaaababbabbbabbbbabbbababbbbaabbabbab
bbbbaaabbbbabbaaaababaaabababaabbabaabababbbbabbbabbbabbabaabbabbbbaaaaa
aababbabababbbbabbaabbbbbbaabaaaaabbaaabbaaaababbabbabaaababaaaa
aabbbbbbbababbabbbaabaaaabaaaaaabbbbababaaabaabaaabbbbbbabaabbbbaaababbbbaaaabba
baabbbbaaababbbbbbbbaaababaaaaabaabaabab
abaaaababbbbbbbaaaaaaabbbababbaaabbaabab
bbbbaaaaabbbabaaaaaaaaaa
bbbabaabbababbbbaabbabab
bbabaaaaabbaaabaabbaabba
bbabaaabbaabaaaababababaaaabbbbbbbaababb
abbbbaaababaabaababaabbbaabbbbbbbabaabbb
aabbbaababaababbaaabababbababaabaabaaaaa
baaabbbbaabbabbaabbbabbb
aaabbabbbaaabbaaaabbaaaabaabaabb
abaaabbababbaaaaabbbaaaa
aabbabbaaaabbabbaaabbbba
baaabaaabbbbabaabbbabbbbabaaaaababaaabaaabbbbbbaababbbbbbbbbabbaabbabbaababbaabababbaaba
aaabbabbbbbbaaabaaababbbbabbbaaaaaabbbba
aaabaaaaaabbabaaabaabbabaababbbabaababbb
aabababbabaababababbbaba
bbbbaaaabbaaaaaababaabbb
baabaababaaaabbbabbbbaabbaabbabb
baaaabbbaaaaaabaabbbaabbbabaabaaabbaaaab
aaabaabaaaabbabbbbaabbbb
bbbaaaaaababaaaababaabaabbbaabaababbaaaabbaaaaaaaabaaabb
abaabababbbaabaabbaaaaabaabbabab
aaababaabababbaabbbbbaaabaaabbbbbabaababbaabbaba
aaaabaababaabbabaaabbaaaababaaabaaabaabababbababaababaab
aaaaaabbaaabbabbbaabbbab
bbabbaabbbabbaabbbabbaaabbbbbaba
baabbbbaaaaaaababbbbbbbaabaabbbaaabbaabb
bbaaababababaaabbabbbaba
baaabaaabbbaaababbabbbaaaabbabaaabbabbab
bbaaabbbaaabaabbbaabbabb
bbbabaabaabbbbbbbabaabab
babbaaaaaaababbabaabaaaaababaaabbaabaabababababaaaaaabaabbaabbba
bbabbaabbaaabaaabaabaabbaabbabab
babbaaabaaabaaaabaaabbbbaababaaababbbbaa
abbaaaaababbbbbaabbaabaa
babbabababaaaabbbbbabaaa
abaaabaabbaaabbaaaabaabbaabbbabaaaaababa
bbbbabbbabbaabbabaaabbbaabbababbbabbbaabaabbababaabbabaabbabbbaaabaaabbbbbbabbaa
aababbabbbabaababbabaaab
baabbbbabbaababaaabababbaaabbabbaaabaabbaaabbaaabbabbbbbabbbbaaa
ababababababaaaabbbbabba
aabbbaaaaaababbbbbbaabaaabbbabababbaabbbaaaaabaa
bababaabbabbaaabbbbbbaba
abaaaabbbababbbbabaaabaaabbaaaab
babbababbaabbaabaaababaabaaabbaaaabbaaabbbababbbbabbbbaa
aaaabbababbbaabbbababbbbaaababbbabbaabab
bbaaaaaababbbbbaaabbbbbbabbbaaababaabababaaaaaab
abaaabbaaababbabbbbbbaaaababaaaaaabbaaab
aaababbabbbaabaabababbaabbabbbababbaaaabbaaaaaabaaaaabbbbabbaabb
bababbaaababbaaababbabaaaababbba
baabaabaabaaabaaaabbbaabaaaabaaabaaabbab
aaaaaabbabbababbbbaabaab
baabaababbbbaaaababbabab
aaaaaabbaaaabbaaaaaaaababaaaabaabbababbb
bbabaaababaaaabaababbbbbabaabbba
aaaababbbabaaababbbbaaba
babbaaabbaabbaabbbbbababbabaabaaabbbbaabaabbaaba
