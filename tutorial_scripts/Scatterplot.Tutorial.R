#Vanessa Koelling, June 21, 2017. Practice script for data visualization, specifically using a scatterplot.

library(dplyr)
library(ggplot2)
library(readr)

rm(list = ls())
compensation <- read_csv("~/Desktop/R_Practice_Files/datasets/compensation.csv")
glimpse(compensation)

# make a scatterplot with Root on the x-axis and Fruit on the y-axis
# the first argument to give the function ggplot() is the data frame
# the second argument is a function called aes(), which defines the mapping
# between variables in the dataset and features of the graph (i.e., x and y)
# the data and aesthetics are always the first layer of the graph
# the "+" is how the layers are added to the graph
# geom_point() adds the geometric layer, telling it we want points on the graph
ggplot(compensation, aes(x = Root, y = Fruit)) + geom_point() + theme_bw()

# theme_bw() gets rid of the gray background on the plot (makes it black and white)
ggplot(compensation, aes(x = Root, y = Fruit)) + geom_point() + theme_bw()

# make the size of the points larger by increasing the size argument
ggplot(compensation, aes(x = Root, y = Fruit)) + geom_point(size = 5) + theme_bw()

# change the labels on the axes
ggplot(compensation, aes(x = Root, y = Fruit)) + geom_point(size = 5) + xlab("Root Biomass") + ylab("Fruit Production") + theme_bw()

# adjust the colors of the points to match specific levels in a group
ggplot(compensation, aes(x = Root, y = Fruit, colour = Grazing)) + geom_point(size = 5) + xlab("Root Biomass") + ylab("Fruit Production") + theme_bw()

# change the shape of the points to match specific levels in a group
ggplot(compensation, aes(x = Root, y = Fruit, shape = Grazing)) + geom_point(size = 5) + xlab("Root Biomass") + ylab("Fruit Production") + theme_bw()

# change the shape and the colour at the same time
ggplot(compensation, aes(x = Root, y = Fruit, colour = Grazing, shape = Grazing)) + geom_point(size = 5) + xlab("Root Biomass") + ylab("Fruit Production") + theme_bw()
