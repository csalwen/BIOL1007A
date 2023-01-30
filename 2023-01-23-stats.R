
### Simple Data Analysis and More Complex Control Structures


# load in data
dryadData <- read.table(file = "Data/veysey-babbit_data_amph.csv", header = TRUE, sep = ",")

# set up libraries
library(tidyverse)
library(ggthemes)

# ANALYSES
# Experimental designs
# independent (x axis) and dependent (y axis) variable
# continuous (range of numbers) vs discrete/catagorical (groups/catagories)


# continuous (x) + continuous (y) = linear regression
  # scatterplot visualization
# is there a relationship between the mean pool hydroperiod and the number of breeding frogs caught?
# y ~ x
reg_model <- lm(count.total.adults ~ mean.hydro, data = dryadData)
print(reg_model)
summary(reg_model)
hist(reg_model$residuals)
summary(reg_model)$"r.squared" # or summary(reg_model)[["r.squared"]]

regPlot <- ggplot(data = dryadData, aes(x = mean.hydro, y = count.total.adults)) +
  geom_point() +
  stat_smooth(method = lm, se = 0.99)
regPlot + theme_few()

# continuous + categorical = logistic regression
  # logistic curve plot
xVar <- sort(rgamma(n=200, shape=5, scale = 5))
yVar <- sample(rep(c(1,0), each=100), prob = seq_len(200))
logRegData <- data.frame(xVar, yVar)

logRegModel <- glm(yVar ~ xVar, 
                   data = logRegData, 
                   family = binomial(link=logit))
summary(logRegModel)

logRegplot <- ggplot(data = logRegData, aes(x = xVar, y = yVar)) +
  geom_point() +
  stat_smooth(method = "glm", method.args = list(family=binomial))
logRegplot

# categorical + continuous = t test (2 groups), ANOVA (2+ groups)
  # box plot visualization
  # or bar graph
# Basic ANOVA
# was there a statistically significant difference in the number of adults among years?
ANOmodel <- aov(count.total.adults ~ factor(wetland), data = dryadData) # use factor to make sure R is treating variable as catag
summary(ANOmodel)

dryadData %>%
  group_by(factor(wetland)) %>%
  summarize(avgHydro = mean(count.total.adults, na.rm = T), N = n())

dryadData$wetland <- factor(dryadData$wetland)
ANOplot <- ggplot(data = dryadData, mapping = aes(x = wetland, y = count.total.adults, fill = species)) + # fill breaks up boxplot by column given
  geom_boxplot()
ANOplot
# ggsave(file = "SpeciesBoxplots.pdf", plot = ANOplot2, device = "pdf") # to save a file or can export from popup window


# categorical + categorical = chi-squared (count)
  # table, mosaic plot
# are there differences in counts of males and femals between species?
countData <- dryadData %>%
  group_by(species) %>%
  summarize(Males = sum(No.males, na.rm = T), Females = sum(No.females, na.rm =T)) %>%
  select(-species) %>%
  as.matrix()
countData

row.names(countData) = c("SS", "WF")
countData

# chi-squared
chisq.test(countData)$residuals

# mosaic plot (base R)
mosaicplot(x = countData, col = c("lightblue", "midnightblue"), shade = FALSE)

# barplot
countDataLong <- countData %>%
  as_tibble() %>%
  mutate(Species = c(rownames(countData)))
  pivot_longer(cols = Males:Females, names_to = "Sex", values_to = "Count")
  
ggplot(data = countDataLong, mapping = aes(x = Species, y = Count, fill = Sex)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_fill_manual(values = c("darkslategrey", "midnightblue"))


######################################################################

# Control Structures

# if and ifelse statements

### if (condition) {expression 1}

### if (condition) {expression 1} else {expression 2}

### if (condition1) {expression 1} else if condition 2 {expression 2} else {expression 3}

# else must appear on the same line as the expression
# used for single values

z <- signif(runif(1), digits = 2)

if (z > 0.8) {cat(z, "is a large number", "\n")} else 
  if (z < 0.2) {cat(z, "is a small number", "\n")} else
  {cat(z, "is typical", "\n")
      cat("z^2 = ", z^2, "\n")}


# ifelse : fill vectors
# ifelse (condition, yes, no)

# insect population wehre females lay 10.2 eggs on average, follows Poisson distribution (discrete probability distribution showing the likely number of times an event will occur). 35% chance of parasitism where no eggs are laid. 
tester <- runif(1000)
eggs <- ifelse(tester > 0.35, rpois(n = 1000, lambda = 10.2), 0)
hist(eggs)


# vector of p values from simulation and create a vector to highlight the signif ones for plotting
pVals <- runif(1000)
z <- ifelse(pVals <= 0.025, "lower tail", "not signif")
z[pVals >= 0.975] <- "uppertail"
table(z)

# for loops
### controversial in R bc not often necessary, slow, and there's a family of apply functions

# for (variable in sequence) { body of for loop}
# var is a counter variable that holds the current value of the loop (i, j, k)
# sequence is an integer vector that defines the start and end points of the loop

for(i in 1:5) {
  cat("stuck in a loop", i, "\n")
  cat(3+2, "\n")
  cat(3+i, "\n")
}
print(i)

# use counter variable that maps to the position of each element
my_dogs <- c("chow", "akita", "malamute", "husky", "samoyed")
for (i in 1:length(my_dogs)) {
  cat("i = ", i, "my_dogs[i]", my_dogs[i], "\n")
}

# use double for loops

m <- matrix(round(runif(20), digits = 2), nrow=5)

# loop over rows
for (i in 1:nrow(m)) {
  m[i, ] <- m[i,] + i
}
# loop over columns
for (j in 1:ncol(m)) {
  m[,j] <- m[,j] + j
}

# loop over both
for (i in 1:nrow(m)) {
  for (j in 1:ncol(m)){
    m[i,j] <- m[i,j] + i + j
  }
}
