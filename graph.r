#!/usr/bin/env Rscript

args = commandArgs(TRUE)
input = args[1]
print(input)
output = gsub("csv", "png", input)

data <- read.csv(input, header=FALSE)

x11()
plot(data$V1, data$V3, type="n", 
     main="Average Trials by Initial Group (100,000 Simulations)", 
     xlab="Initial Group Size", ylab="Average Trials")
lines(data$V1, data$V3, type="o")

dev.print(png, output, width=1080, height=600)

Sys.sleep(1000)
