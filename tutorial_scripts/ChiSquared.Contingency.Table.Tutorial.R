# Vanessa Koelling, June 30, 2017. Chi-squared contingency table analysis example.
# also includes bar chart example

# needed libraries
library(dplyr)
library(ggplot2)
library(readr)

# clear the decks
rm(list = ls())

# import and check the data
ladybirds_morph_colour <- read_csv("~/Desktop/R_Practice_Files/datasets/ladybirds_morph_colour.csv")
glimpse(ladybirds_morph_colour)

# produce the totals (4 numbers) for the contingency table
totals <- ladybirds_morph_colour %>% group_by(Habitat, morph_colour) %>% summarise(total.number = sum(number))

# make a preliminary bar chart of the data to make sure the counts look correct
# fill creates the second grouping legend and puts a solid color on the bars
# stat = 'identity' tells it to use the data you've given it and not do any other calculation
# position = 'dodge' makes separate bars; removing that makes a stacked bar chart
ggplot(totals, aes(x = Habitat, y = total.number, fill = morph_colour)) + geom_bar(stat = 'identity', position = 'dodge') + ylab("Total Number")

# change the colors so that black and red ladybirds are represented by those colors in the chart
ggplot(totals, aes(x = Habitat, y = total.number, fill = morph_colour)) + geom_bar(stat = 'identity', position = 'dodge') + ylab("Total Number") + scale_fill_manual(values = c(black = "black", red = "red"))

# converts the data frame into the matrix needed for the chi-squared test
# formula reads: Please cross-tabulate the number column of counts in the totals data frame
# by the Habitat and morph_colour variables.
lady.mat <- xtabs(number ~ Habitat + morph_colour, data = ladybirds_morph_colour)

# the chi-squared test
chisq.test(lady.mat)

# assign the chi-squared information to a new variable
lady.chi <- chisq.test(lady.mat)
# look at the values available from the test
names(lady.chi)
# show the calculated expected values (for comparison to the observed)
lady.chi$expected
