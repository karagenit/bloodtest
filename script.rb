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
  [Fiddle::TYPE_VOID],
  Fiddle::TYPE_VOID
)

loadSim.call(1)

POP  = 10000
PROB = 0.01
SIMS = 1000
THREADCNT = 4
TSIMS = SIMS / THREADCNT # per thread

puts "Simulating #{(PROB * 100).round}% of #{POP}..."
puts "Running each simulation #{SIMS} times..."

outdata = []

for initial in 10..150 do
  breakdown = 2
  threads = []
  (THREADCNT).times do
    thread = Thread.new do
      testsTotal = 0
      for i in 1..TSIMS do
        print "Simulating... #{(100 * i / TSIMS).to_i}%\r"
        testsTotal += simulate.call(initial, breakdown, POP, PROB)
      end
      testsTotal # set Thread.value
    end
    threads.push thread
  end
  testsTotal = threads.inject(0) { |sum, thr| sum += thr.value }
  avgTest = (testsTotal / SIMS).round
  outdata.push([initial, breakdown, avgTest])
  puts "Staring at #{initial}...   \tdividing by #{breakdown}...\tAverage Tests: #{avgTest}"
end

IO.write("output.csv", outdata.map(&:to_csv).join)
