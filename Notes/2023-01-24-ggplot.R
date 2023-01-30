

## ggplot

library(ggplot2)
library(ggthemes)
library(patchwork)


### Template for ggplot code

# p1 <- ggplot(data = data_set, mapping = aes(x = xvariable, y = yvariable)) + <GEOM FUNCTION>
# geom functions: geom_boxplot()
# print(p1)

d <- mpg # loading built in data set
str(mpg)

library(dplyr)
glimpse(d)

### qplot: quick plotting
qplot(x = d$hwy)

qplot(x = d$hwy, fill = I("darkblue"), color = I("black"))

## scatterplot
qplot(x = d$displ, y = d$hwy, geom = c("smooth", "point"), method = "lm")
# geom adds the line
# method = lm makes the line a linear model

## boxplot
qplot(x = d$fl, y = d$cty, geom ="boxplot", fill = I("forestgreen"))


## barplot
qplot(x = d$fl, geom = "bar", fill = I("forestgreen"))


### Create some data (specified counts)
x_trt <- c("Control", "Low", "High")
y_resp <- c(12, 2.5, 22.9)
qplot(x = x_trt, y = y_resp, geom = "col", fill=I(c("forestgreen", "slategrey", "goldenrod")))


#### ggplot : uses dataframes instead of vectors
# can run the code w/o argument names

p1 <- ggplot(data = d, mapping = aes(x = displ, y = cty, color = cyl)) + 
  geom_point()
p1

# change the background of the figure -- lines, etc
p1 + theme_base()
p1 + theme_bw()
p1 + theme_classic()
p1 + theme_linedraw()
p1 + theme_dark()
p1 + theme_minimal()

p1 + theme_bw(base_size = 20, base_family = "serif")

p2 <- ggplot(data = d, aes(x =fl, fill = fl)) +
  geom_bar()

p2 + coord_flip() + theme_classic(base_size = 10)


# Theme modifications

p3 <- ggplot(data = d, aes(x=displ, y=cty)) +
  geom_point(size = 3, shape = 21, color = "magenta", fill = "black") + 
  xlab("Count") + # changing x and y axis names
  ylab("Fuel") +
  labs(title = "My title here", subtitle = "my subtitle")

p3 + xlim(1, 10) + ylim(0, 35)

library(viridis)

cols <- viridis(7, option = "magma")
ggplot(data=d, aes(x=class, y=hwy, fill = class)) +
  geom_boxplot() +
  scale_fill_manual(values = cols)


# multipanel

library(patchwork)
p1 + p2 + p3
