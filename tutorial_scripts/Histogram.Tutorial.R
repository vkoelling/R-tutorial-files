#Vanessa Koelling, June 30, 2017. Practice script for data visualization, specifically creating a histogram.

library(dplyr)
library(ggplot2)
library(readr)

rm(list = ls())
compensation <- read_csv("~/Desktop/R_Practice_Files/datasets/compensation.csv")
glimpse(compensation)

# makes a histogram of Fruit Production
ggplot(compensation, aes(x = Fruit)) + geom_histogram()

# adjust the number of bins R uses
ggplot(compensation, aes(x = Fruit)) + geom_histogram(bins = 10)

# adjust the bin width R uses
ggplot(compensation, aes(x = Fruit)) + geom_histogram(binwidth = 15)

# group by treatment; the ~ symbol precedes the grouping variable
ggplot(compensation, aes(x = Fruit)) + geom_histogram(binwidth = 15) + facet_wrap(~Grazing)

# one method of saving your histogram figure
ggsave("FruitProductionByGrazingTreatmentHistogram.png")
