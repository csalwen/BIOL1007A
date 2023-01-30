

### The TIDYVERSE

# collection of packages


# OPERATORS
# - symbols that tell R to perform different operations (between variables, etc)
# - Arithmetic Operators : + - * ^ etc
# - Assignment Operator: <-
# - Logical Operators: ! &(and) |(or)
# - Relational Operators: == != < > <= >=
# - Miscellaneous Operators: %>% (forward pipe), %in%

# PACKAGES
# - only need to be installed once

library(tidyverse) # to load in packages

# dplyr: new packages provides set of tools for manipulating data sets
# written to be fast
# individual functions that correspond to common operations


### The core verbs
# filter()
# arrange()
# select()
# group_by() and summarize()
# mutate()


data(starwars)
class(starwars)

# Tibble: modern take on data frames

glimpse(starwars) # little snapshot of a tibble

### NAs
anyNA(starwars)

starwars_clean <- starwars[complete.cases(starwars[,10]),]

anyNA(starwars_clean[,1:10])

### filter() : picks/subsets observations (ROWS) by their values

filter(starwars_clean, gender == "masculine" & height < 180) # , means &

filter(starwars_clean, gender == "masculine", height < 180, height > 100 ) # multiple conditions for the same variable

### %in% operator : similar to == but can compare vectors of different lengths
a <- LETTERS[1:10] 
length(a) # length of vector

b <- LETTERS[4:10]
length(b)

# output of operator depends on first vector
a %in% b # shows if b is in a
b %in% a # shows if a is in b

# use %in% to subset
eyes <- filter(starwars, eye_color %in% c("blue", "green"))
view(eyes)


### arrange() : reorders rows
arrange(starwars_clean, by = height)
# default is ascending order (low to high)
# can use helper function desc() to reverse
arrange(starwars_clean, by = desc(height))

sw <- arrange(starwars, height, desc(mass)) # second variable used to break ties
tail(sw) # missing values are at the end


### select() : chooses variables (COLUMNS) by their names
select(starwars_clean, 1:10)
select(starwars_clean, name:species) # only show these range of columns
select(starwars_clean, -(films:starships)) # everything except range of columns

starwars_clean[,1:11] # same thing in base R

# rearrange columns
select(starwars_clean, name, gender, species, everything()) # everything() selects everything else and puts it at the end

# contains() helper function
select(starwars_clean, contains("color")) # subsets column names containing the word given
# others include: ends_with(), starts_with(), num_range()

# select can also rename columns
select(starwars_clean, haircolor = hair_color) # new name = old name, only keeps renamed column
rename(starwars_clean, haircolor = hair_color) # renames and keeps everything


### mutate() : creates new variables using functions of existing variables
# create new column that is height/mass
mutate(starwars_clean, ratio = height/mass) # places new column at the end

starwars_lbs <- mutate(starwars_clean, mass_lbs = mass*2.2)
view(starwars_lbs)
starwars_lbs <- select(starwars_lbs, 1:3, mass_lbs, everything())
glimpse(starwars_lbs)

### transmute ()
transmute(starwars_clean, mass_lbs = mass*2.2) # only returns mutated columns
transmute(starwars_clean, mass, mass_lbs = mass*2.2, height) # can return other specified columns


### group_by() and summarize()
summarize(starwars_clean, mean_height = mean(height)) # throws NA if NAs in column
summarize(starwars_clean, mean_height = mean(height), total_number = n()) # how many rows is it measuring

# use group_by for max usefulness
# find stats within groups of same data frame
starwars_genders <- group_by(starwars, gender)
head(starwars_genders)
summarize(starwars_genders, mean_height = mean(height, na.rm = TRUE), total_number = n())



### Piping ( %>% )
# used to emphasize a sequence of actions
# allows you to pass an intermediate results onto the next function (uses output of one function as input of the next function)
# avoid if you need to manipulate more than one object at a time or if variable will be used in future

# formatting: should always have a space before %>% followed by new line

starwars_clean %>%
  group_by(gender) %>%
  summarize(mean_height = mean(height, na.rm = TRUE), total_number = n())
# much cleaner/faster way

## case_when() is useful for multiple if/else statements
starwars_clean %>%
  mutate(sp = case_when(species == "Human" ~ "Human", TRUE ~ "Non-Human")) # confusing
# uses condition, puts "Human" if false in sp column, puts "Non-Human" in column if false







