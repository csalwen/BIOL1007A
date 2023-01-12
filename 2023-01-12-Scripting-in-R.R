#### Programming in R
#### 12 January 2023
#### CS

# Advantages of R
## interactive use
## graphics, statistics
## very active community of contributors
## works on multiple platforms

# Disadvantages
## lazy evaluation
## some packages are poorly documented
## some functions hard to learn
## some unreliable packages
## problems with big data -- multiple GBs


# Basics

## Assignment operator: used to assign new value to variable

x <- 3 # assigns the variable
print(x) # shows what is in x in console

y = 4 # legal but not used except in function arguments
print(y)
y = y + 1.1
y <- y + 1.1
print(y)


## Variables: used to store information

z <- 3 # single letter variables
plantHeight <- 10 # camel case format
plant_height <- 7 # snake case format # preferred method
plant.height <- 4 # avoid this method
. <- 5.5 # reserved for a temporary variable, doesn't show in environment when run code


## Functions: blocks of code that perform a task; use short command over again instead of writing it out

square <- function(x = NULL){
  x <- x^2
  print(x)
}

square(x = 3) # x is the argument

## built in functions
sum(100, 43)
## look at package info using ?sum or going to help panel


### Atomic Vectors
# one dimensional (a single row)
# fundamental data structure in R programming

## Types
# character strings (ex. "dog")
# integers (ex. 3)
# double (float)
# logical (Boolean, TRUE or FALSE)
# factor (categorizes, groups variable)

# c function (combine)
z <- c(3.2, 5, 5, 6)
print(z)
class(z) # numeric 
typeof(z) # double (type of variable)
is.numeric(z) # is it numeric? TRUE/FALSE

## c() always flattens to a vector
## main purpose is creating vectors
z <- c(c(3,4), c(5,6)) # don't do this though

c(3,4,"dog", TRUE, 4.5) # converts them all to strings bc they all need to be the same type

# character vectors
z <- c("perch", "bass", "trout")
print(z)
z <- c("this is only one character string", "a second", "third")
print(z)
typeof(z)
class(z)
is.character(z)

# Boolean
z <- c(T, F, T, F) # as. functions coerces data type
z <- as.character(z) # making logical into character
print(z)

# Length
length(z)
dim(z) # checks dimensions, NULL if 1D

# Names
z <- runif(5)
print(z)
names(z)

# add names
names(z) <- c("chow", "pug", "beagle", "greyhound", "akita")
names(z) # shows names

names(z) <- NULL # reset names to no names

## NA: missing data
z <- c(3.2, 3.5, NA)
typeof(z)
mean(z) # won't work with an NA

# check for NAs
anyNA(z) # boolean response
is.na(z) # True on where the NA is
which(is.na(z)) # gives specific index of the NA


## Subsetting: filtering for certain criteria
# Vectors are indexed
z <- c(3.1, 9.2, 1.3, 0.4, 7.5)
z[4] # indexing one value
z[c(4,5)] # use c to index multiple values
z[-c(2,3)] # using - gives everything but what you said
z[z == 7.5] # returns the item that meets the condition
z[z == 3.2] # returns numeric(0) if none in vector meets condition
# can also use > or < for same thing, just different condition
# use logical statements in [] to subset by condition

# creating logical vector
z < 7.5

# subsetting characters (named elements)
names(z) <- c("a", "b", "c", "d", "e")
z[c("a", "d")]


# subset function
subset(x=z, subset = z>1.5)

# randomly sample from a vector
story_vec <- c("A", "Frog", "Jumped", "Here")
sample(story_vec) # shuffles vector order
sample(story_vec, size = 3) # saying how many to sample

sotry_vec <- c(story_vec[1], "Green", story_vec[2:4]) # placing a new item in vector where you want it

story_vec[2] <- "Blue" # replacing item

# vector function
vec <- vector(mode = "numeric", length = 5) # create vector, then populate

# rep and seq functions
z <- rep(x=0, times=100)
z <- rep(x = 1:4, each = 3) # 1:4 is range

z <- seq(from = 2, to = 4, by = 0.5) # basically range, by gives interval

seq(from=1, to=length(z)) # good if length is changing
