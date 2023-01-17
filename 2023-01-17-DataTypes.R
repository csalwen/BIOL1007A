### Vectors, Matrices, Data Frames, and Lists
# 17 January 2023

# MORE ON VECTORS
'
## Coercion
# all atomic vecotrs are of the SAME data type
# using c() to assemble different types, R *coerces* them
    ## meaning logical -> integer -> double -> character
    ## will covert everything to the lowest of the existing data types
'
a <- c(2, 2.2) # makes the 2 -> 2.0 so that everything is double

b <- c("purple", "green") # both stay character

d <- c(a,b) # merging doubles and characters -- everthing turns to characters

# comparison operators yeild a logical result

e <- runif(10)
print(e)
## 

e > 0.5 # conditional statement yields a logicl result
## [1] FALSE FALSE FALSE FALSE  TRUE  TRUE FALSE  TRUE FALSE  TRUE

sum(a > 0.5) # how many elements in vector are > 0.5
mean(a > 0.5) # what proportion of vector are > 0.5

"
Vectorization
- add a constant to a vector
"
z <- c(10, 20, 30)
z + 1 # adds 1 to each element in vector

# vectors added together?
y <- c(1, 2, 3)
z + y # matches each element --> 10 + 1, 20 + 2, etc based on indices

# Recycling -- if vector lengths are not equal?
x <- c(1, 2)
z + x # shorter vector recycled until calc applied to all items in longer vector

"
Simulating data : runif and rnorm()
"
set.seed(123) # if set seed before each time, does same random numbers, can be any number
runif(n=100, min=5, max=10) # set sample size and min and max

r <- runif(n=3) # variable contains diff sets of numbers each time

# rnrom: random normal values with mean around 0 and stdev 1
randomNormalNumbers <- rnorm(100)
mean(randomNormalNumbers)

# hist() creates histogram of set of numbers, distribution
hist(rnorm(n=100, mean=100, sd=30))


## MATRICES
'
- 2 dimentional, rows and columnns
- homogeneous data type
- an atomic vector organized into rows and columns
'
my_vec <- 1:12

m <- matrix(data = my_vec, nrow = 4) # set number of rows
#           [,1] [,2] [,3]
#      [1,]    1    5    9
#      [2,]    2    6   10
#      [3,]    3    7   11
#      [4,]    4    8   12

m <- matrix(data = my_vec, ncol = 3) # set number of columns

m <- matrix(data = my_vec, ncol=3, byrow=TRUE) # default is filling down columns so this fills by row


## LISTS
'like atomic vectors, but each element can hold different data types (and diff sizes)'

my_list <- list(1:10, matrix(1:8, nrow = 4, byrow = TRUE), letters[1:3], pi)
str(my_list) # gives info abt list NOT STRING
# elements retain their data type

"SUBSETTING lists
- using [] gives you a single item but not the elements
"
my_list[4] # gives you the item, but can't work with it

# to grab oject itself, use [[]]
my_list[[4]] - 3 # able to be manipulated

# takes it out of it's compartment -- can't work with a list, only with the elements inside
my_list[[2]][4,1] # taking out matrix [matrix index], then taking out specific item in matrix [row,column]

my_list[c(1,2)] # to obtain multiple compartments of list

c(my_list[[1]], my_list[[2]]) # to obtain multiple elements within list

'NAME list items when they are created'
my_list2 <- list(Tester = FALSE, littleM = matrix(1:9, nrow=3))

my_list2$Tester # returns element in box, not compartment

# $ accesses named elements

my_list2$littleM[2,3] # returns single item from matrix (second row, third column)
my_list2$littleM[2,] # leave blank to get all items in column (can also do for whole row (,2))
my_list2$littleM[2] # just gives that number from matrix

'UNLIST to string everything back to vector'
unRolled <- unlist(my_list2)
# names each item, everything coerced to same data type, one dimensional


data(iris)
head(iris) # see first six rows
plot(Sepal.Length ~ Petal.Length, data = iris) # gives basic plot of the two variables' relationship
  # first item goes on y, second on x
model <-  lm(Sepal.Length ~ Petal.Length, data = iris)
results <- summary(model) # gives stats -- P value is PR, estimate is predicted slope, don't care about intercept row

str(results)
results$coefficients

results$coefficients[2, 4] # extract petal.length p value
results$coefficients["Petal.Length", "Pr(>|t|)"] # alternate way

unlist(results)$coefficients8 # p value will always be coeff 8 in every linear regression


## DATA FRAMES
'(list of) equal length vectors, each of which is a column

HAVE TO BE EQUAL LENGTHS'

varA <- 1:12
varB <- rep(c("Con", "LowN", "HighN"), each = 4)
varC <- runif(12)

dFrame <- data.frame(varA, varB, varC, stringsAsFactors = FALSE)
# makes into table of three columns with titles of the variables, 12 rows

# add another row
newData <- list(varA = 13, varB = "HighN", varC = 0.668)
# use rbind() 
dFrame <- rbind(dFrame, newData) # adds newData to end, each item in appropriate column

# no c?
newData2 <- c(14, "HighN", 0.668) # everything gets coerced to characters bc it's a vector
# dFrame <- rbind(dFrame, newData2) # makes this get coerced to characters, turned into matrix
# test that by looking at str()

# adding a column
newVar <- runif(13)
# use dim() to check how many rows and columns you already have
# use cbind() to add column
dFrame <- cbind(dFrame, newVar)
head(dFrame)



## DATA FRAMES VS MATRICES

zMat <- matrix(data = 1:30, ncol = 3, byrow = TRUE) 
zDFrame <- as.data.frame(zMat) # as. converts into other data structure

# matrix with brackets around column and row labels, frame without

zMat[3,3] # gives element from 3rd row and 3rd column
zDFrame[3,3] # same
zDFrame[3, "V3"] # same

zMat[,3] # gives whole column
zDFrame[,3] # same
zDFrame$V3 # same

zMat[3] # gives third item down
zDFrame[3] # gives whole third column

# Eliminating NAs
### complete.cases() function
zD <- c(NA, rnorm(10), NA, rnorm(3))

complete.cases(zD) # returns logical vector, FALSE for any NAs

# clean out NAs automatically
zD[complete.cases(zD)]

which(!complete.cases(zD)) # which items are NAs, gives indices in vector
which(is.na(zD)) # same thing

# use with matrix
m <- matrix(1:20, nrow = 5)
m[1,1] <- NA
m[5,4] <- NA

# complete.cases gives if each ROW contains NA (FALSE if NA is present in row)
m[complete.cases(m), ] # gives rows without any NAs

# get complete cases for only certain rows
m[complete.cases(m[,c(1:2)]),]


