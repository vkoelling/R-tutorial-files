# Vanessa Koelling, July 6, 2017. Simple linear regression example.

# needed libraries
library(dplyr)
library(ggplot2)
library(readr)
library(ggfortify)

# clear the decks
rm(list = ls())

# import the data frame
plant_growth_rate <- read.csv("~/Desktop/R_Practice_Files/datasets/plant.growth.rate.csv")
# look at the data
glimpse(plant_growth_rate)

# explore the data in a scatter plot
ggplot(plant_growth_rate, aes(x = soil.moisture.content, y = plant.growth.rate)) + geom_point() + ylab("Plant Growth Rate (mm/week)") + theme_bw()

# fit the general linear model
model_pgr <- lm(plant.growth.rate ~ soil.moisture.content, data = plant_growth_rate)

# produces four plots critical to evaluating your data analysis
# 1) residuals vs. fitted: evaluates whether or not a line is appropriate to fit to the data
# 2) normal Q-Q: evaluates the assumption of normality of the residuals
# 3) scale-location: evaluates the assumption of equal variance
# 4) residuals vs. leverage: evaluates leverage to detect outliers and influential data points
autoplot(model_pgr, smooth.colour = NA) # the smooth.colour = NA argument eliminates unnecessary lines fitted to these plots

# calculate the sums-of-squares table
anova(model_pgr)

# calculate the y-intercept and slope of the regression line
summary(model_pgr)

# produce a scatterplot with the regression line
# the geom_smooth(method = 'lm') adds the regression line; not appropriate for more complicated models
ggplot(plant_growth_rate, aes(x = soil.moisture.content, y = plant.growth.rate)) + geom_point() + geom_smooth(method = 'lm') + ylab("Plant Growth Rate (mm/week)") + theme_bw()
