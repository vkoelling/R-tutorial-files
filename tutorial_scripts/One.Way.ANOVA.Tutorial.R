# Vanessa Koelling, July 7, 2017. One-way ANOVA example.

# needed libraries
library(dplyr)
library(ggplot2)
library(readr)
library(ggfortify)

# clear the decks
rm(list = ls())

# import the data frame
Daphniagrowth <- read_csv("~/Desktop/R_Practice_Files/datasets/Daphniagrowth.csv")
# look at the data
glimpse(Daphniagrowth)

# visualize the data with a boxplot
ggplot(Daphniagrowth, aes(x = parasite, y = growth.rate)) + geom_boxplot() + theme_bw()

# flip the x- and y-axes; gets the species names to fit
ggplot(Daphniagrowth, aes(x = parasite, y = growth.rate)) + geom_boxplot() + theme_bw() + coord_flip()

# apply the general linear model to the data
model_daphnia_growth <- lm(growth.rate ~ parasite, data = Daphniagrowth)
model_daphnia_growth

# evaluate the model assumptions using four plots (same as in simple linear regression example)
autoplot(model_daphnia_growth, smooth.colour = NA)

# calculate the one-way ANOVA
anova(model_daphnia_growth)

# get the summary table
summary(model_daphnia_growth) 
# note that Intercept in the summary table is the control treatment in this example
# Intercept will always be the first level of the alphabetically ordered treatment levels

# get the mean growth rates
sumDat <- Daphniagrowth %>% group_by(parasite) %>% summarise(meanGR = mean(growth.rate))
sumDat

# create a new scatterplot color figure with the mean growth rate for each treatment layered on
ggplot(Daphniagrowth, aes(x = parasite, y = growth.rate, colour = parasite)) + geom_point(size = 2) + geom_point(data = sumDat, aes(x = parasite, y = meanGR, colour = parasite), size = 5, shape = 18) + theme_bw() + coord_flip() + xlab("Parasite Treatment") + ylab("Daphnia Growth Rate")

