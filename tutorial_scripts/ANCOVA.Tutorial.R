# Vanessa Koelling, July 11, 2017. Analysis of covariance (ANCOVA) example.

# needed libraries
library(dplyr)
library(ggplot2)
library(readr)
library(ggfortify)

# clear the decks
rm(list = ls())

# import the data frame
limpet.repro <- read_csv("~/Desktop/R_Practice_Files/datasets/limpet.csv")

# look at the data
glimpse(limpet.repro)

# convert character string to factor for column SEASON
limpet.repro <- mutate(limpet.repro, SEASON = factor(SEASON))
# check that it worked
glimpse(limpet.repro)

# create a plot of density vs. egg production grouped by season
ggplot(limpet.repro, aes(x = DENSITY, y = EGGS, colour = SEASON)) + geom_point() + scale_colour_manual(values = c(spring = "green", summer = "red")) + theme_bw()

# specify the general linear model; y = density + season + density:season
# the ~ is used to separate the left- and right-hand sides in a model formula
limpet.model <- lm(EGGS ~ DENSITY * SEASON, data = limpet.repro)

# see what info has been collected by lm
names(limpet.model)

# check model assumptions
autoplot(limpet.model, smooth.colour = NA)

# produce the ANOVA table
anova(limpet.model)

# produce the summary table
summary(limpet.model)

# expand.grid() is a function that builds a factorial representation of any variables you provide
# i.e, returns a grid of numbers
# predict() generates fitted values from a model
# can be used with the argument "interval" to get 95% confidence intervals on the fitted values
# create the new values of x (density) at which we want values of y (eggs)

# i.e., make some new DENSITY values at which we request predictions and do it at each level of SEASON
new.x <- expand.grid(DENSITY = seq(from = 8, to = 45, length.out = 10), SEASON = levels(limpet.repro$SEASON))

# check it worked
head(new.x)
new.x

# generate fits and confidence interval at new.x values
new.y <- predict(limpet.model, newdata = new.x, interval = 'confidence')

# check it worked
head(new.y)
new.y

# housekeeping to bring new.x and new.y together
# rename fit to be EGGS, which matches the original data
addThese <- data.frame(new.x, new.y)
addThese <- rename(addThese, EGGS = fit)

# check that it worked
head(addThese)

# predict the number of eggs for each season at the mean limpet density
# new.x2 with DENSITY set to mean
new.x2 <- expand.grid(DENSITY = mean(limpet.repro$DENSITY), SEASON = levels(limpet.repro$SEASON))

# predictions
predEgg <- predict(limpet.model, newdata = new.x2)

# housekeeping
EggAtMeanDensity <- data.frame(new.x2, predEgg)
head(EggAtMeanDensity)

# plot the data, adding the fits and CIs
ggplot(limpet.repro, aes(x = DENSITY, y = EGGS, colour = SEASON)) + geom_point(size = 5) + geom_smooth(data = addThese, aes(ymin = lwr, ymax = upr, fill = SEASON), stat = 'identity') + scale_colour_manual(values = c(spring = "green", summer = "red")) + scale_fill_manual(values = c(spring = "green", summer = "red")) + theme_bw()

