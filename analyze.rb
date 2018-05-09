#!/usr/bin/env ruby

require 'csv'

file = ARGV[0]

if file.nil? || !File.file?(file)
  puts "Usage: analyze.rb FILENAME.csv"
  exit
end

data = CSV.parse(IO.read(file))

data.sort! { |x, y| x[2] <=> y[2] }

puts "Start\tDivisor\tAverage Tests"

data.first(10).each do |elem|
  puts "#{elem[0]}\t#{elem[1]}\t#{elem[2]}"
end
