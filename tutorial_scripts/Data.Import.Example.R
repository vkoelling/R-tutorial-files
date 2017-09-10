# Vanessa Koelling, June 9th, 2017. This script is for some practice data import and analysis.

# make these packages and their associated functions available to use in this script
library(dplyr)
library(ggplot2)

#clear R's brain
rm(list = ls())

# read in the datafile "compensation.csv"
library(readr)
compensation <- read_csv("~/Desktop/R_Practice_Files/datasets/compensation.csv")

# tells me the names of each column
names(compensation)

# shows the first 6 rows of the dataset
head(compensation)

# shows the last 6 rows of the dataset
tail(compensation)

# gives the number of rows and columns in the dataset
dim(compensation)

# gives the structure of the dataset
str(compensation)

# gives a horizontal view of your data frame
glimpse(compensation)

# gives a vertical view of your data frame
tbl_df(compensation)

# import nasty format data and tidy it
nasty.format <- read.csv("nasty format.csv")

# view that data frame
str(nasty.format)

# filter out rows that do not have an entry in the "Bottle" variable
nasty.format <- filter(nasty.format, Bottle != "")
glimpse(nasty.format)

# load tidyr library
library(tidyr)

# use the gather function to make a new variable for the Date and to move the 
# baterial abundance data from columns 4 to 11 to the Abundance variable
tidy_data <- gather(nasty.format, Date, Abundance, 4:11)
glimpse(tidy_data)

library(stringr)
# mutate function allows you to change or add variables within a data frame
# sub_str function denotes the variable to work on and where to start; in this
# case, we tell it to keep from the second character to the 20th character
# this removes the "X" from the beginning of the Date variable
tidy_data <- mutate(tidy_data, Date = substr(Date, 2, 20))
tbl_df(tidy_data)

library(lubridate)

# the $ allows you to refer to a variable inside a data frame
unique(tidy_data$Date)

# change the Date variable to recognize the values as dates in Day-Month-Year format
tidy_data <- mutate(tidy_data, Date = dmy(Date))
tbl_df(tidy_data)

# make a plot; specify the data, the x and y variables, that it is a scatterplot, and
# specify one graph for each of the Bottles
ggplot(data = tidy_data, aes(x = Date, y = Abundance)) + geom_point() + facet_wrap(~Bottle)
