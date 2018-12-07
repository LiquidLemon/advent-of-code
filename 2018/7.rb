require 'set'

input = (ARGV.empty? ? DATA : ARGF).readlines.map do |line|
  line.scan(/[[:upper:]]/)[1, 2]
end

steps = Hash.new { |h, k| h[k] = Set.new }
dependent = Set.new

BLOCKS = Hash.new(0)

input.each do |name, nxt|
  steps[name] << nxt
  dependent << nxt
  BLOCKS[nxt] += 1
end

order = []

available = steps.keys.reject { |step| dependent.include? step }.sort

blocks = BLOCKS.dup

while !available.empty?
  name = available.shift

  order << name
  steps[name].each do |nxt|
    if blocks[nxt] <= 1
      available << nxt
    else
      blocks[nxt] -= 1
    end
  end
  available.sort!
end

puts "Part 1: #{order.join}"

time_spent = 0

queue = steps.keys.reject { |step| dependent.include? step }.sort
workers = []

WORKERS = 5
BASE_TIME = 60

blocks = BLOCKS.dup

queued = Set.new
while !queue.empty? || !workers.empty?
  while workers.length < WORKERS && !queue.empty?
    task = queue.shift
    workers << [task.ord - ?A.ord + BASE_TIME + 1, task]
    queued << task
  end

  unless workers.empty?
    workers.sort!
    forward = workers[0][0]
    time_spent += forward
    workers.map! { |time, task| [time - forward, task] }
  end

  while !workers.empty? && workers[0][0] <= 0
    _, name = workers.shift
    steps[name].each do |nxt|
      blocks[nxt] -= 1
      if blocks[nxt] == 0 && !queued.include?(nxt)
        queue << nxt
      end
    end
  end
  queue.sort!
end

puts "Part 2: #{time_spent}"

__END__
Step M must be finished before step D can begin.
Step E must be finished before step Z can begin.
Step F must be finished before step W can begin.
Step T must be finished before step K can begin.
Step L must be finished before step Z can begin.
Step K must be finished before step Q can begin.
Step H must be finished before step V can begin.
Step Q must be finished before step P can begin.
Step B must be finished before step S can begin.
Step W must be finished before step P can begin.
Step P must be finished before step R can begin.
Step A must be finished before step D can begin.
Step G must be finished before step Z can begin.
Step I must be finished before step D can begin.
Step V must be finished before step D can begin.
Step Z must be finished before step R can begin.
Step X must be finished before step R can begin.
Step S must be finished before step U can begin.
Step J must be finished before step D can begin.
Step R must be finished before step U can begin.
Step U must be finished before step Y can begin.
Step D must be finished before step C can begin.
Step Y must be finished before step N can begin.
Step O must be finished before step C can begin.
Step N must be finished before step C can begin.
Step Q must be finished before step O can begin.
Step K must be finished before step Z can begin.
Step X must be finished before step N can begin.
Step F must be finished before step I can begin.
Step F must be finished before step O can begin.
Step V must be finished before step X can begin.
Step E must be finished before step N can begin.
Step V must be finished before step C can begin.
Step B must be finished before step P can begin.
Step J must be finished before step U can begin.
Step D must be finished before step Y can begin.
Step Z must be finished before step J can begin.
Step I must be finished before step U can begin.
Step E must be finished before step O can begin.
Step X must be finished before step U can begin.
Step G must be finished before step S can begin.
Step K must be finished before step X can begin.
Step G must be finished before step N can begin.
Step X must be finished before step O can begin.
Step P must be finished before step G can begin.
Step L must be finished before step G can begin.
Step B must be finished before step Y can begin.
Step W must be finished before step G can begin.
Step B must be finished before step A can begin.
Step T must be finished before step S can begin.
Step J must be finished before step C can begin.
Step A must be finished before step U can begin.
Step R must be finished before step D can begin.
Step U must be finished before step O can begin.
Step D must be finished before step N can begin.
Step O must be finished before step N can begin.
Step Q must be finished before step A can begin.
Step V must be finished before step J can begin.
Step W must be finished before step O can begin.
Step F must be finished before step R can begin.
Step A must be finished before step X can begin.
Step H must be finished before step O can begin.
Step P must be finished before step X can begin.
Step E must be finished before step Y can begin.
Step M must be finished before step U can begin.
Step T must be finished before step C can begin.
Step A must be finished before step S can begin.
Step P must be finished before step S can begin.
Step Q must be finished before step B can begin.
Step V must be finished before step S can begin.
Step S must be finished before step Y can begin.
Step X must be finished before step Y can begin.
Step H must be finished before step S can begin.
Step J must be finished before step R can begin.
Step V must be finished before step U can begin.
Step X must be finished before step C can begin.
Step I must be finished before step X can begin.
Step Y must be finished before step O can begin.
Step V must be finished before step O can begin.
Step F must be finished before step L can begin.
Step T must be finished before step Q can begin.
Step R must be finished before step O can begin.
Step E must be finished before step W can begin.
Step Q must be finished before step Y can begin.
Step E must be finished before step H can begin.
Step I must be finished before step R can begin.
Step B must be finished before step D can begin.
Step F must be finished before step A can begin.
Step J must be finished before step Y can begin.
Step R must be finished before step N can begin.
Step W must be finished before step A can begin.
Step D must be finished before step O can begin.
Step P must be finished before step N can begin.
Step E must be finished before step Q can begin.
Step G must be finished before step V can begin.
Step G must be finished before step I can begin.
Step X must be finished before step S can begin.
Step M must be finished before step C can begin.
Step G must be finished before step X can begin.
Step T must be finished before step P can begin.
Step Q must be finished before step Z can begin.
