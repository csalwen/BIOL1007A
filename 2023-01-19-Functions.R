
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















































