# Vanessa Koelling, July 17, 2017. More ways to customize graphs using ggplot2.

# needed libraries
library(dplyr)
library(ggplot2)
library(readr)
library(gridExtra)

# clear the decks
rm(list = ls())

# import data frame
compensation <- read_csv("~/Desktop/R_Practice_Files/datasets/compensation.csv")

# base scatterplot
eg_scatter <- ggplot(data = compensation, aes(x = Root, y = Fruit)) + geom_point()

# base box-and-whiskers plot
eg_box <- ggplot(data = compensation, aes(x = Grazing, y = Fruit)) + geom_boxplot()

eg_scatter + theme_bw()

# place multiple plots on the same page
# nrow places plots side-by-side; ncol stacks plots
grid.arrange(eg_scatter, eg_box, nrow = 1)

# change axis labels
eg_scatter + xlab("Root Biomass") + ylab("Fruit Production")

# add a title to the graph; this is usually unnecessary
eg_scatter + ggtitle("My Superb Title")

# all in one go
eg_scatter + labs(title = "My Useless Title", x = "Root Biomass", y = "Fruit Production")

# change the range of the x- and y-axes
eg_scatter + xlim(0, 20) + ylim(0, 140)

# add text to the figure
# the coordinates for the first piece of text are x = 6 and y = 105
# the coordinates for the second piece of text are x = 8 and y = 25
eg_scatter + annotate("text", x = c(6, 8), y = c(105, 25), label = c("Text up here...", "...and text down here"))

# adjust the range of the x-axis and specify the frequency and location of tick marks
eg_scatter + scale_x_continuous(limits = c(4, 11), breaks = 4:11)

# distinguish treatment groups by color
ggplot(data = compensation, aes(x = Root, y = Fruit, colour = Grazing)) + geom_point() + scale_colour_manual(values = c(Grazed = "brown", Ungrazed = "green"))

# log10 transform a variable on the plot and generate a log-y axis
eg_box + scale_y_continuous(breaks = seq(from = 10, to = 150, by = 20), trans = "log10")

# get rid of gray background & minor gridlines; generate light blue major gridlines
eg_scatter + theme(panel.background = element_rect(fill = NA, colour = "black"), panel.grid.minor = element_blank(), panel.grid.major = element_line(colour = "lightblue"))

# adjust the color and size of the x-axis title and angle of the tick labels
eg_box + theme(axis.title.x = element_text(colour = "cornflowerblue", size = rel(2)), axis.text.x = element_text(angle = 45, size = 13, vjust = 0.5))

# alter the names of the levels on the plot
eg_box + scale_x_discrete(limits = c("Ungrazed", "Grazed"), labels = c("Control", "Grazed"))

# get rid of the box around the key
ggplot(compensation, aes(x = Root, y = Fruit, colour = Grazing)) + geom_point() + theme(legend.key = element_rect(fill = NA))

# get rid of the key
ggplot(compensation, aes(x = Root, y = Fruit, colour = Grazing)) + geom_point() + theme(legend.position = "none")

# ggthemes is a package with custom themes already created
library(ggthemes)
