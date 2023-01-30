### Weekly Assignment 2


func <- function(mean1, sd1, mean2, sd2 ){
  
  Type <- rep(c("Control", "Treatment"), each = 25)
  Value <- c(rnorm(25, mean = 10, sd = 1.5), rnorm(25, mean = 45, sd = 2))
  dframe <- data.frame(Type = Type, Value = Value)
  return(dframe)
  
}
funcdata = func(mean1 = 10, sd1 = 1.5, mean2 = 45, sd2 = 2)

head(funcdata)

results <- aov(Value ~ Type, data = funcdata)
summary(results)


func2 <- function(data_frame){
  test <- aov(data_frame[,1] ~ data_frame[,2], data = data_frame)
  all_stats <- summary(all_stats)
  p_value <- all_stats[1,5]
  return(p_value)
}
