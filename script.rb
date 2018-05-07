#!/usr/bin/env ruby

##
# Initial size to pool by
# Divisor to break down by
#
def simulate(initial, breakdown, population = 10000, occurrence = 100)
  population = Array.new(population - occurrence, false) + Array.new(occurrence, true)
  population.shuffle!
  population = [population] #ugh

  tests = 0

  while population.any?
    p population
    puts "Tests: #{tests}"
    gets
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
    initial = initial / breakdown
  end

  return tests
end

puts simulate(1, 1, 100, 1)
puts simulate(100, 10, 100, 1)
