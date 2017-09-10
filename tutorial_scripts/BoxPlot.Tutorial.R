#Vanessa Koelling, June 30, 2017. Practice script for data visualization, specifically using a box-and-whisker plot.

library(dplyr)
library(ggplot2)
library(readr)

rm(list = ls())
compensation <- read_csv("~/Desktop/R_Practice_Files/datasets/compensation.csv")
glimpse(compensation)

# makes a black and white box-and-whisker plot
ggplot(compensation, aes(x = Grazing, y = Fruit)) + geom_boxplot() + xlab("Grazing Treatment") + ylab("Fruit Production") + theme_bw()

# makes a black and white box-and-whisker plot with the raw data added; alpha is the transparency value
ggplot(compensation, aes(x = Grazing, y = Fruit)) + geom_boxplot() + geom_point(size = 4, colour = 'lightgrey', alpha = 0.5) + xlab("Grazing Treatment") + ylab("Fruit Production") + theme_bw()

# makes a black and white box-and-whisker plot of Fruit Production grouped by Root Diameter
ggplot(compensation, aes(x = Grazing, y = Fruit)) + geom_boxplot() + geom_point(size = 4, colour = 'lightgrey', alpha = 0.5) + xlab("Grazing Treatment") + ylab("Fruit Production") + theme_bw()
