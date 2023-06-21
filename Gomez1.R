# Andres Gomez

library(tidyverse)
library(dslabs)

#a) What is the structure of iris? 
str(iris)
levels(iris$Species)
  #The levels are "setosa" "versicolor," and "virginica"

#b) What do the first 6 lines look like?
head(iris)

#c) How can we get information about the variables?
help("iris")

# Make box plots using ggplot from the tidyverse package for 
# each numerical variable in the iris data set separated by the species variable. Make the plots as 
# professional as possible. Record any interesting observations.
species <- iris %>% ggplot()
species + geom_boxplot(aes(Sepal.Width, Sepal.Length,  fill = Species)) +
  labs(title = "Numerical Variables",
       subtitle = "The sepal of the Virginica is the largest,
while the widest is the sepal of the setosa.") +
  scale_fill_manual(values=c("#FFEF99", "#F5C500", "#FA9041"))

species + geom_boxplot(aes(Petal.Width, Petal.Length,  fill = Species)) +
  labs(title = "Numerical Variables",
       subtitle = "The petal of the Virginica is the largest
and the widest") +
  scale_fill_manual(values=c("#FFEF99", "#F5C500", "#FA9041"))


# Examine the data set *heights* that is included in the dslabs package. Make a density plot 
# showing how male and female heights are distributed. Make sure the plot has appropriate labels 
# and is titled. Read online about how to change the color scheme and choose colors that you think 
# fits the data. Don’t use the default colors.
head(heights)
help("heights")

sHeight <- heights %>% ggplot()
sHeight + geom_density(aes(height, fill = as.factor(sex)), alpha = .5) +
  scale_fill_manual(values=c("aquamarine", "aquamarine4")) +
  labs(title = "Self-Reported Heights",
       subtitle = "There is a wider range of women between heights 
ranging from 60-65 inches.")

# Experiment with the four numerical variables in the iris data set until you find two that 
# produce the best scatter plot, colored by species. By “best”, we mean that the plot has the affect 
# of forcing species “clusters”. Explain why you think it is the best plot.

species + geom_point(aes(Petal.Length,Petal.Width,col = as.factor(Species)),size = 3) +
  labs(title = "Species Agrupations by Petal Length and Width",
       subtitle = "This graph is the best at showing the different species in clusters
by utilizing the data from the Petals.")

# Describe the structure of the murders data frame that is included in the dslabs package. Assign 
# the murders data frame the new name M. Execute the following code and then reexamine the 
# structure. 

str(murders)
M <- as.data.frame(murders)

M$rate <- (M$total/M$population)*100000
M$popMillions <- M$population/1000000

str(M)
# What did you learn?
#   I learned how to insert new data into a data frame and how to examine the new data
#   inserted in the created data frame.

# This problem uses the result of 4. If you weren’t able to get 4, make sure you get help on 
# number 4 before doing this problem.
# Make a scatter plot of the two new variables colored by region. Describe any interesting 
# observations.

mrate_vs_pop <- M %>% ggplot()
mrate_vs_pop + geom_point(aes(popMillions, rate ,col = as.factor(region)), size = 4)

# After you get the previous graph, try adding the code
mrate_vs_pop + geom_point(aes(popMillions, rate ,col = as.factor(region)), size = 4) +
  scale_x_log10()

# What does this do?
#   It widens the spacing between the dots through the scatter plot.
# How does that help the appearance of your plot? 
#   It helps the user when reading the data.
# Can you determine which state has the highest gun murder rate?
#   The South region has the highest murder rate, I would say Delaware is the state
#   with the highest murder rate.