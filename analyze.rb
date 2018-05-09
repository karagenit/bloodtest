#!/usr/bin/env ruby

require 'csv'

data = CSV.parse(IO.read('output.csv'))

data.sort! { |x, y| x[2] <=> y[2] }

puts "Start\tDivisor\tAverage Tests"

data.first(10).each do |elem|
  puts "#{elem[0]}\t#{elem[1]}\t#{elem[2]}"
end
