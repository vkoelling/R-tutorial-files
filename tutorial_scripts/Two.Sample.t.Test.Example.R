# Vanessa Koelling, June 30, 2017. Two-sample t-test example.


# needed libraries
library(dplyr)
library(ggplot2)
library(readr)

# clear the decks
rm(list = ls())

# read in the data frame
garden_ozone <- read.csv("~/Desktop/R_Practice_Files/datasets/GardenOzone.csv")
glimpse(garden_ozone)

# visualize data as two stacked histograms
ggplot(garden_ozone, aes(x = Ozone)) + geom_histogram(binwidth = 10) + facet_wrap(~ Garden.location, ncol = 1) + theme_bw()

# if you take out the ncol = 1 argument, then you get the histrograms side-by-side rather than stacked
ggplot(garden_ozone, aes(x = Ozone)) + geom_histogram(binwidth = 10) + facet_wrap(~ Garden.location) + theme_bw()

# calculate the mean ozone for each garden location
mean_ozone <- garden_ozone %>% group_by(Garden.location) %>% summarise(meanOzone = mean(Ozone), sdOzone = sd(Ozone))
mean_ozone

# do a Welch Two Sample t-test; Welch relaxes the equality of variance assumption
t.test(Ozone ~ Garden.location, data = garden_ozone)

# if you want to test the equality of variance, but not recommended for t-test because R will do the Welch version
var.test(Ozone ~ Garden.location, data = garden_ozone)

