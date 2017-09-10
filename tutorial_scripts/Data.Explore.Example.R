# Vanessa Koelling, June 13th, 2017. This is a script for data management, 
#manipulation, and exploration practice using dplyr.

# import libraries
library(dplyr)
library(ggplot2)

# clear R's brain
rm(list = ls())

# import compensation data
compensation <- read.csv("~/Desktop/R_Practice_Files/datasets/compensation.csv")
tbl_df(compensation) # check the data has the correct numbers of rows and columns

# get summary statistics for the compensation variables
summary(compensation)

# using dplyr; always takes and uses a data frame

# selects columns
select(compensation, Fruit) # grabs the Fruit column
select(compensation, -Root) # grabs everything but the Root column

# selects rows
slice(compensation, 2) # gets the second row
slice(compensation, 2:10) # gets row 2 to 10
# c function collects the row numbers
slice(compensation, c(2, 3, 10)) # gets the 2nd, 3rd, and 10th rows

# look in this data frame, do what comes next, and then stop looking
with(compensation, Fruit > 80) # the > will yield True/False for each observation in the data frame

# filter selects subsets of rows, conditional upon values in a column
# find the rows where it is true that Fruit is >80 and return them as a data frame
filter(compensation, Fruit > 80)
filter(compensation, Fruit > 80 | Fruit < 20) # | is the Boolean "or" symbol
# assign the values from filter to an object so they can be used again
lo_hi_fruit <- filter(compensation, Fruit > 80 | Fruit < 20)
# now look at it
lo_hi_fruit

# what does compensation look like now?
head(compensation)

# mutate creates new variables in the data frame
# log(Fruit) is in the column logFruit
# all of which gets put into the object compensation
compensation <- mutate(compensation, logFruit = log(Fruit))

# see first 6 rows of the new compensation
head(compensation)

# sorts rows in ascending order
arrange(compensation, Fruit) # puts the observations in order of increasing fruit production

# Root values from Fruit > 80 subset
select(filter(compensation, Fruit > 80), Root)

# Root values from Fruit > 80 subset
# Via piping
# %>% puts the answer of the left-hand command into the function on the right
compensation %>% filter(Fruit > 80) %>% select(Root)

# return the mean for Grazed and Ungrazed fruit production
mean.fruit <- summarise(group_by(compensation, Grazing), meanFruit = mean(Fruit))
mean.fruit

# return the mean for Grazed and Ungrazed fruit production via piping
mean.fruit <- compensation %>% group_by(Grazing) %>% summarise(meanFruit = mean(Fruit))
mean.fruit

# also return the standard deviation
mean.fruit <- compensation %>% group_by(Grazing) %>% summarise(meanFruit = mean(Fruit), sdFruit = sd(Fruit))
mean.fruit

# subtract the mean of each group from the corresponding value in each group
compensation_mean_centered <- compensation %>% group_by(Grazing) %>% mutate(Fruit_minus_mean = Fruit - mean(Fruit))
compensation_mean_centered

library(broom)
# this one doesn't work; need to investigate the error
compensation_lms <- compensation %>% group_by(Grazing) %>% do(tidy(lm(Fruit - Root, data=.)))
