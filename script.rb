#!/usr/bin/env ruby

##
# Initial size to pool by
# Divisor to break down by
#
def simulate(initial, breakdown, population = 10000, occurrence = 0.01)
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

SIMS = 500
VARS = [ [10000,10], [1000,10], [100,10], [10,10], [1,10],
         [10000, 2], [1000, 2], [200, 2], [100, 2], [50, 2], [10, 2] ]

puts "Simulating 1% of 10,000..."
puts "Running each simulation #{SIMS} times..."

VARS.each do |initial, breakdown|
  testsTotal = 0
  for i in 1..SIMS do
    testsTotal += simulate(initial, breakdown)
  end
  puts "Staring at #{initial}... \tdividing by #{breakdown}...\tAverage Tests: #{testsTotal/SIMS}"
end
