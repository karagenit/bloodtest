#!/usr/bin/env ruby

require 'fiddle'
require 'csv'

libSimulate = Fiddle.dlopen('./libsimulate.so')

simulate = Fiddle::Function.new(
  libSimulate['simulate'],
  [Fiddle::TYPE_INT, Fiddle::TYPE_INT, Fiddle::TYPE_INT, Fiddle::TYPE_DOUBLE],
  Fiddle::TYPE_INT
)

loadSim = Fiddle::Function.new(
  libSimulate['setup'],
  [],
  Fiddle::TYPE_VOID
)

loadSim.call()

POP  = 10000
PROB = 0.01
SIMS = 10000
DIVISOR = 2

puts "Simulating #{(PROB * 100).round}% of #{POP}..."
puts "Running each simulation #{SIMS} times..."

outdata = []

for initial in 10..150 do
  testsTotal = 0
  for i in 1..SIMS do
    print "Simulating... #{(100 * i / SIMS).to_i}%\r"
    testsTotal += simulate.call(initial, DIVISOR, POP, PROB)
  end
  avgTest = (testsTotal / SIMS).round
  outdata.push([initial, DIVISOR, avgTest])
  puts "Staring at #{initial}...   \tdividing by #{DIVISOR}...\tAverage Tests: #{avgTest}"
end

IO.write("./output/#{SIMS}-#{POP}-#{(100 * PROB).round}-#{DIVISOR}.csv", outdata.map(&:to_csv).join)
