#!/usr/bin/env Rscript

args = commandArgs(TRUE)
input = args[1]
output = gsub("csv", "png", input)

nums = regmatches(input, gregexpr("[0-9]+", input))
sims = nums[[1]][1]
pop = nums[[1]][2]
prob = nums[[1]][3]
div = nums[[1]][4]
title = paste("Average Trials by Initial Group, ", sims, " Simulations\nN = ", pop,
              ", P = ", prob, "%, Divisor: ", div, sep='')

data <- read.csv(input, header=FALSE)

x11()
plot(data$V1, data$V3, type="n", main=title, xlab="Initial Group Size", ylab="Average Trials")
lines(data$V1, data$V3, type="o")

dev.print(png, output, width=1080, height=600)

Sys.sleep(1000)
