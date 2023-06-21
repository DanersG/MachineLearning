# Module 2: Using Tidyverse

library(tidyverse)

# Tidy data is data that is stored in such a way so that each row represents
# one observation and columns represent a variable associated with that 
# observation.  Here are some examples.

co2                            # Built in data set

# Data is not in tidy format.  However it is in time-series format.

str(ChickWeight)

# Data is tidy.  Each observation is a weight.  The variables associated
# with the weight are the time, the chick#, and the diet used.

# Both mtcars in the base package and murders in dslabs are tidy.

# Useful functions for working with tidy data

####################################################
# mutate function in the tidyverse package
####################################################

library(dslabs)

# On the last assignment, we created a variable called rate that
# we added to the murders data frame.  The "mutate" function in the 
# tidyverse package is a better way to accomplish this.

M <- murders         # rename murders for manipulation

M <- mutate(murders, rate = total/population*100000)

# Note that the first argument is the data frame you wish to add
# a variable (mutate). Then you give the variable a name and use 
# existing variables to create the new variable.

head(murders)                   # Look at first 6 rows


##########################################################
# filter
#########################################################

# We can use the filter function from tidyverse to look at certain rows from
# the data frame we are analyzing.  Here are some examples

filter(M, rate <= 0.71)         # Only 5 states with rate this low
filter(M, rate >= 5)           # 4 states including DC
filter(M, region == "South")

# So the function filter accepts a data frame then a logical.  You
# can combine logicals.

filter(M, rate > 5 & region == "South")
# find all rows with rate > 5 and region identical to south.

filter(M, rate > 5 | region == "South")
# find all rows with rate > 5 OR region identical to south

###########################################################
# Select
##########################################################

# The function select allows you to look at only the variables you 
# are interested in.  Suppose we only want names, regions, and rate

new_table <- select(M,state,region,rate)
head(new_table)
# We have a new table formed from the murders data that only includes the
# state names, the region, and the rate.

filter(new_table, rate <= 0.7)
# Same as earlier but with only the variables we want.


#######################################################################

# Selecting and filtering with the pipe operator " %>% "

# Suppose I only want state names, region, population, and
# the murder rate.  Then, only rates that are less than 1.  Here is
# one line of code that accomplishes this.

M %>% select(state, region, rate, population) %>% filter(rate < 1)

# The pipe works when the object on the left is a data frame and the 
# object on the right works on data frames.  M is a data frame which is piped 
# into the first argument of select.  The select function creates a data frame
# which is the first argument of filter.

# Consider the following problem.  Suppose you are starting fresh with 
# the murders data set
data(murders)                # reload the data set from dslabs package
str(murders)

# You are asked to find all states in the southern region with murder 
# rate < 3.  The only problem is there is no murder rate variable.  You 
# can do this with one line of code as follows.

murders %>% mutate(rate = total/population*100000) %>% 
  select(state,region,rate) %>% filter(region == "South" & rate <=3)


# Using " summarize " and "group_by" in the tidyverse package.

library(dslabs)
data(heights)               # Load the heights data
head(heights)

# We want to see the mean and standard deviation of the heights data.

heights %>% summarize(avg = mean(height),st_dev=sd(height))

# We can also look at other summary statistics.

heights %>% summarize(minimum=min(height),median = median(height),
                      maximum=max(height))
heights %>% summarize(number = n())  # summarize the number of rows
# Of course, it makes more sense to analyze based on gender.  So we do 
# the following.

heights %>% group_by(sex) %>% 
  summarize(number = n(),Mean_Height=mean(height),
            stand_dev=sd(height))

# so the functions used applied separately to Female and Male.

# Examples with the murders data frame

data(murders)

# Next we use the summarize command to look at the rates in each region.
murders %>% group_by(region) %>% 
  summarize(reg_rate = sum(total)/sum(population)*100000)
# Or, we could use mutate as follows:

# Sorting with frames

# In tidyverse, the function "arrange" works on data frames.  For example

murders %>% arrange(population) %>% head()
# This is a nice way to see the bottom 6.  Here is the top 6 by population.

murders %>% arrange(desc(population)) %>% head()

# Nested sorting
# We can sort by more than one variable.

murders_temp <- murders %>% arrange(region,total) 

# If you look at the whole data frame, you will see it arranged by region
# and by total gun murders

murders_temp

# Using top_n

# As a final example, let's compute the murder rate column and look at the 
# top 10 states from high to low.

murders <- mutate(murders, rate = total/population*100000)
head(murders)

murders %>% top_n(10,rate)
# These aren't sorted, only filtered.  We can add that:

murders %>% top_n(10,rate) %>% arrange(desc(rate))
