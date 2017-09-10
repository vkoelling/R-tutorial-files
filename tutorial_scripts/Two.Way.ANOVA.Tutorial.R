# Vanessa Koelling, July 7, 2017. Two-way ANOVA example.

# needed libraries
library(dplyr)
library(ggplot2)
library(readr)
library(ggfortify)

# clear the decks
rm(list = ls())

# import the data frame
growth.moo <- read_csv("~/Desktop/R_Practice_Files/datasets/growth.csv")
# look at the data
glimpse(growth.moo)

# convert the diet and supplement columns from characters to factors
growth.moo <- mutate(growth.moo, diet = factor(diet), supplement = factor(supplement))

# check that it worked
glimpse(growth.moo)

# grab the levels for the diet column
levels(growth.moo$diet)

# grab the levels for the supplement column
levels(growth.moo$supplement)

# relevel the supplement column
# this is so that the reference (the control) is listed first
growth.moo <- mutate(growth.moo, supplement = relevel(supplement, ref = "control"))

# check it worked
levels(growth.moo$supplement)

# calculate mean and sd of gains for all 12 combinations
sumMoo <- growth.moo %>% group_by(diet, supplement) %>% summarise(meanGrow = mean(gain))

# make sure it worked
sumMoo

# plot the means by supplement type
ggplot(sumMoo, aes(x = supplement, y = meanGrow)) + geom_point() + theme_bw()

# connects the dots by diet and distinguishes the diets by color
ggplot(sumMoo, aes(x = supplement, y = meanGrow, colour = diet, group = diet)) + geom_point() + geom_line() + theme_bw()

# specify the general linear model with an interaction term as well as main effects
model_cow <- lm(gain ~ diet * supplement, data = growth.moo)

# check model assumptions
autoplot(model_cow, smooth.colour = NA)

# produce the ANOVA table
anova(model_cow)

# produce the summary table
summary(model_cow)

# calculate mean, sd, and se of gains for all 12 combinations
# the n function counts the number of rows in each group; caution: it will count missing values!
# the n function can only be used within summarise, mutate, or filter
sumMoo <- growth.moo %>% group_by(diet, supplement) %>% summarise(meanGrow = mean(gain), seGrow = sd(gain)/sqrt(n()))
# an alternative to use if you have missing values: sd(gain)/sqrt(sum(!is.na(gain)))

# create line graph with standard error bars
ggplot(sumMoo, aes(x = supplement, y = meanGrow, colour = diet, group = diet)) + geom_point() + geom_line() + geom_errorbar(aes(ymin = meanGrow - seGrow, ymax = meanGrow + seGrow), width = 0.1) + theme_bw()
