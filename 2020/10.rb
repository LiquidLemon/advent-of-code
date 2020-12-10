data = DATA.each_line.map(&:to_i)

sorted = data.sort
sorted.unshift(0)
diffs = sorted[1..].zip(sorted[...-1]).map { |a, b| a - b }

puts diffs.count(1) * (diffs.count(3) + 1)

count = 1
sorted[1...-1].each.with_index(1) do |x, i|
  if sorted[i+1] - sorted[i-1] <= 3
    count *= 2
  end
end

# This is "smart" but relies a lot on the specific properties of the data.
# I couldn't find a way to solve this properly so this will have to do for now.
factors = [1, 2, 4, 7]
puts diffs
  .chunk(&:itself)
  .filter { |x, _| x == 1 }
  .map { |_, ary| factors[ary.size-1] }
  .reduce(&:*)

__END__
160
34
123
159
148
93
165
56
179
103
171
44
110
170
147
98
25
37
137
71
5
6
121
28
19
134
18
7
66
90
88
181
89
41
156
46
8
61
124
9
161
72
13
172
111
59
105
51
109
27
152
117
52
68
95
164
116
75
78
180
81
47
104
12
133
175
16
149
135
99
112
38
67
53
153
2
136
113
17
145
106
31
45
169
146
168
26
36
118
62
65
142
130
1
140
84
94
141
122
22
48
102
60
178
127
73
74
87
182
35
