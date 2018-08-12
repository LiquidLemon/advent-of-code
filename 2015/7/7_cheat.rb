trans = {
  'AND'    => '&',
  'OR'     => '|',
  'NOT'    => '~',
  'LSHIFT' => '<<',
  'RSHIFT' => '>>'
}

p eval ARGF.
  read.
  gsub(Regexp.union(trans.keys), trans).
  gsub(/(.+?) -> (\w+)/) { "%2s = #$1" % $2 }.
  upcase.
  split("\n").
  sort.
  rotate.
  join(?;)
