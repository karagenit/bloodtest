#!/usr/bin/env ruby

require 'fiddle'

libSimulate = Fiddle.dlopen('./libsimulate.so')

simulate = Fiddle::Function.new(
  libSimulate['simulate'],
  [Fiddle::TYPE_INT, Fiddle::TYPE_INT, Fiddle::TYPE_INT, Fiddle::TYPE_DOUBLE],
  Fiddle::TYPE_INT
)

loadSim = Fiddle::Function.new(
  libSimulate['setup'],
  [Fiddle::TYPE_VOID],
  Fiddle::TYPE_VOID
)

loadSim.call(1)

POP  = 10000
PROB = 0.01
SIMS = 10000
#VARS = [ [10000,10], [1000,10], [100,10], [10,10], [1,10], [10000, 2],
VARS = [ [128,2], [100, 2], [88,2], [80,2], [64,2], [50, 2], [40,2], [32,2], [25,2], [24, 2], [20,2], [16,2] ]
# missing comma here leads to bad initial/breakdown and TypeErrors in simulate

puts "Simulating #{(PROB * 100).round}% of #{POP}..."
puts "Running each simulation #{SIMS} times..."

VARS.each do |initial, breakdown|
  testsTotal = 0
  for i in 1..SIMS do
    print "Simulating... #{(100 * i / SIMS).to_i}%\r"
    testsTotal += simulate.call(initial, breakdown, POP, PROB)
  end
  puts "Staring at #{initial}...   \tdividing by #{breakdown}...\tAverage Tests: #{testsTotal/SIMS}"
end
