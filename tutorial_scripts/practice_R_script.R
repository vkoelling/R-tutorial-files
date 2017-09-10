# Vanessa Koelling, June 8, 2017. This script is for the analysis of coffee 
# consumption and burger eating.

# make these packages and their associated functions available for use in this script
library(dplyr)
library(ggplot2)

# clear R's brain
rm(list = ls())

#some interesting maths in R
1+1
2*4
3/8
11.75-4.813
10^2
log(10) #remember that log is natural in R!
log10(10)
sin(2*pi)
x <- seq(1, 10, 0.5)
y <- seq(101, 110, 0.5)
x + y

# graphing practice
# assignment 1: Plot a graph with x^2 on the y-axis and x on the x-axis
library(ggplot2)
x <- seq(-10, 10, 0.1)
y <- x^2
qplot(x, y, geom = "line")

#assignment 2: Plot a graph with the sine of x on the y-axis and x on the x-axis.
library(ggplot2)
x <- seq(0, 8*pi, 0.1)
y <- sin(x)
qplot(x, y, geom = "line")

# assignment 3: Plot a histogram of 1000 random normal deviates.
library(ggplot2)
x <- rnorm(1000)
qplot(x)
