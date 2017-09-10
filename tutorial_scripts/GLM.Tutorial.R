# Vanessa Koelling, July 11, 2017. Generalized linear models (GLM) examples.

# needed libraries
library(dplyr)
library(ggplot2)
library(readr)
library(ggfortify)

# clear the decks
rm(list = ls())

# import the data frame
soay <- read_csv("~/Desktop/R_Practice_Files/datasets/SoaySheepFitness.csv")
glimpse(soay)

# evaluate the hypothesis that body mass and fitness are positively associated in Soay sheep
# plot the data using two models
ggplot(soay, aes(x = body.size, y = fitness)) + geom_point() + geom_smooth(method = "lm", se = FALSE) + geom_smooth(span = 1, colour = "red", se = FALSE) + xlab("Body mass (kg)") + ylab("Lifetime Fitness")

# first try the general linear model: predicted fitness = intercept + slope x body size
soay.model <- lm(fitness ~ body.size, data = soay)

# evalute the model assumptions
autoplot(soay.model, smooth.colour = NA)

# using a Poisson GLM: Natural Log[Predicted Fitness] = Intercept + Slope x Body Size
# Predicted Fitness = e^Intercept + Slope x Body Size
# ?family will show the canonical link function; can be specified using link =
# e.g. soay.glm <- glm(fitness ~ body.size, data = soay, family = poisson (link = "log"))
soay.glm <- glm(fitness ~ body.size, data = soay, family = poisson)

# evaluate the model fit
autoplot(soay.glm, smooth.colour = NA)

# produce analysis of deviance table
# specify the test distribution needed to calculate p-values, in this case the chi-squared distribution
# the test performed is a likelihood ratio test
anova(soay.glm, test = "Chisq")

# produce the summary table of coefficients
summary(soay.glm)

# use $ to get body.size column in the data frame
min.size <- min(soay$body.size)
max.size <- max(soay$body.size)

# make the new.x values; we use the body.size variable name to name the column as in the original data frame
new.x <- expand.grid(body.size = seq(min.size, max.size, length = 1000))
head(new.x)
tail(new.x)

# generate fits and standard errors at new.x values
new.y <- predict(soay.glm, newdata = new.x, se.fit = TRUE)
new.y <- data.frame(new.y)
head(new.y)

# housekeeping to bring new.x and new.y together
addThese <- data.frame(new.x, new.y)
# exponentiate the fitness and CI's to get back the 'response' scale
# note we don't need rename() because mutate() works with the fit values each time, and we rename inside mutate 
addThese <- mutate(addThese, fitness = exp(fit), lwr = exp(fit - 1.96 * se.fit), upr = exp(fit + 1.96 * se.fit))
head(addThese)

# plot the data
ggplot(soay, aes(x = body.size, y = fitness)) + geom_point(size = 3, alpha = 0.5) + geom_smooth(data = addThese, aes(ymin = lwr, ymax = upr), stat = 'identity') + theme_bw()

# the data are not overdispersed, but if they are the quasi model is an option
soay.glm <- glm(fitness ~ body.size, data = soay, family = quasipoisson)
soay.glm
# when you use the quasi model, you must change the distribution used by anova
anova(soay.glm, test = "F")

# another option is to use the negative binomial model
library(MASS)
soay.glm.nb <- glm.nb(fitness ~ body.size, data = soay)
soay.glm.nb

# if your data is zero-inflated (many zeros in the data set), you have options in package pscl
# the functions zeroinfl() and hurdle()
library(pscl)

