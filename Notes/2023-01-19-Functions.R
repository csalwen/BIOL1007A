
# MATRICIES AND DATA FRAMES

m <- matrix(data = 1:12, nrow = 3)

# subsetting by elements
m[1:2, ]
m[, 3:4]

# subset with logical conditional statements
## select all columns for which total is >15
m[, colSums(m)>15]
## select rows that add exactly 22
m[rowSums(m) == 22, ]
## everything exept 22
m[rowSums(m) != 22,]

### Logical operators: == != > <

# subsetting to a vector changes the data type
z <- m[1,]
# z is vector

z2 <- m[1, , drop = FALSE] # keeps it as a matrix instead of changing to vector


# simulate new matrix
m2 <- matrix(data = runif(9), nrow = 3)

# use assignment operator to substitute values
m2[m2 > 0.6] <- NA # assigns something else to values that match the conditional


data <- iris
head(data)

data[3,2] # numbered indicies

dataSub <- data[, c("Species", "Petal.Length")]

#### sort a data frame by values
ordered_iris <- iris[order(iris$Petal.Length), ]
head(ordered_iris)




# FUNCTIONS

# everything in R is a function
sum(3, 4)

# to see code of function
sd

# User Defined Functions

# function_name <- function(argX = defaultX, argY = defaultY){ CODE }
# {} starts the body of the function -- lines of R, comments, local variables
# end with return(what you want to return)


my_func <- function(a = 3, b = 4){
  z <- a + b
  return(z)
}
my_func() # runs defaults
my_func(a = 100, b = 2.3)


#my_func_bad <- function(a = 3){
#  z <- a + b
#  return(z)
# }

# Multiple Return Statements

###################################
# FUNCTION: HardyWeinberg
# Input: all allele frequency p (0,1)
# Output: p and the frequencies of 3 genotypes AA AB BB
#-------------------------------
HardyWeinberg <- function(p = runif(1)){
  if(p > 1.0 | p < 0.0){
    return("Function failure: p must be between 0 and 1")
  }
  q <- 1-p
  fAA <- p^2
  fAB <- 2*p*q
  fBB <- q^2
  vec_out <- signif(c(p=p, AA = fAA, AB = fAB, BB = fBB), digits = 3)
  return(vec_out)
}
##################################

HardyWeinberg()

freqs <- HardyWeinberg() # save the output

HardyWeinberg(p=3)


# Create a Complex Default Value

###############################
# FUNCTION: fit_linear2
# fits simple regression line
# input: numeric list (p) of predictor x and response y
# output: slope, p value

fit_linear2 <- function(p = NULL){
  if(is.null(p)){
    p <-list(x = runif(20), y = runif(20)) 
  }
  my_mod <- lm(p$x~p$y)
  my_out <- c(slope = summary(my_mod)$coefficients[2,1],
              pvalue = summary(my_mod)$coefficients[2,4])
  plot(x = p$x, y = p$y) # wuick plot to chekc output
  return(my_out)
}
##########################
fit_linear2()






