#!/usr/bin/env ruby

##
# Initial size to pool by
# Divisor to break down by
#
def simulate(initial, breakdown, population = 8192, occurrence = 0.01)
  population = Array.new(population, false)
  population.map! { |e| rand < occurrence }
  population = [population] #ugh

  tests = 0

  while population.any?
#   p population
#   puts "Tests: #{tests}"
#   gets
    for i in 0...population.length do
      population[i] = population[i].each_slice(initial).to_a
      (population[i].length - 1).downto(0).each do |index|
        tests += 1
        if population[i][index].any? # TODO: cleanup logic
          if population[i][index].length == 1
            population[i].delete_at(index)
          end
        else
          population[i].delete_at(index)
        end
      end
    end
    population.flatten!(1)
    initial = (initial / breakdown).round
  end

  return tests
end

SIMS = 50000
#VARS = [ [10000,10], [1000,10], [100,10], [10,10], [1,10], [10000, 2],
VARS = [ [128,2], [100, 2], [88,2], [80,2], [64,2], [50, 2], [40,2], [32,2], [25,2], [24, 2], [20,2], [16,2] ]
# missing comma here leads to bad initial/breakdown and TypeErrors in simulate

puts "Simulating 1% of 8,192..."
puts "Running each simulation #{SIMS} times..."

VARS.each do |initial, breakdown|
  testsTotal = 0
  for i in 1..SIMS do
    print "Simulating... #{(100 * i / SIMS).to_i}%\r"
    testsTotal += simulate(initial, breakdown)
  end
  puts "Staring at #{initial}...   \tdividing by #{breakdown}...\tAverage Tests: #{testsTotal/SIMS}"
end
