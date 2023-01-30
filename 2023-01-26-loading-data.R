

### Loading in Data

# READ DATA SET
## read.table.()
# read.table(file = "path/to/data.csv", header = TRUE, sep = ",")

## read.csv() # alternative option
# read.csv(file = "data.csv ", header = T )


# CREATE AND SAVE DATASET
# write.table(x = varName, file = "outputFileName.csv", header = TRUE, sep = "," )


# SAVE AND READ
# use RDS objects when only working in R
# saveRDS(my_data, file = "FileName.RDS")
# readRDS("FileName.RDS")
# p <- readRDS("FileName.RDS")

## Long VS Wide data formats
# wide format - contains values that do not repeat in the ID column
# long format - contains values that DO repeat in the ID column

library(tidyverse)
glimpse(billboard) # wide format

b1 <- billboard %>%
  pivot_longer(
    cols = starts_with("wk"), # specify which columns to make longer
    names_to = "Week",  # name of new column
    values_to = "Rank", # name of new column containing values
    values_drop_na = TRUE # removes any NA as value rows
  )
 view(b1)

## pivot_wider -- best for making occupancy matrix
glimpse(fish_encounters)

fish_encounters %>%
  pivot_wider(names_from = station, # which column to turn into multiple columns 
              values_from = seen,  # which column contains the values for the new column cells
              values_fill = 0) # filling NAs with 0s


### DRYAD
# resource that makes research data available to everyone

## read.table()
dryadData <- read.table(file = "Data/veysey-babbit_data_amph.csv", header = TRUE, sep = ",")
glimpse(dryadData)
head(dryadData)

table(dryadData$species) # showing how many of each species, allows you to see different groups of character column

summary(dryadData$mean.hydro) # shows grouping of continuous column


dryadData$species <- factor(dryadData$species, labels=c("Spotted Salamander", "Wood Frog")) # creating labels to use for plot

dryadData$treatment <- factor(dryadData$treatment, levels = c("Reference", "100m", "30m"))


p<- ggplot(data=dryadData, 
           aes(x=interaction(wetland, treatment), 
               y=count.total.adults, fill=factor(year))) + geom_bar(position="dodge", stat="identity", color="black") + 
  ylab("Number of breeding adults") + # labeling y
  xlab("") + # labeling x nothing
  scale_y_continuous(breaks = c(0,100,200,300,400,500)) + # y axis broken up by 100s
  scale_x_discrete(labels=c("30 (Ref)", "124 (Ref)", "141 (Ref)", "25 (100m)","39 (100m)","55 (100m)","129 (100m)", "7 (30m)","19 (30m)","20 (30m)","59 (30m)")) + # labels on the x axis
  facet_wrap(~species, nrow=2, strip.position="right") + # putting the panels together
  theme_few() + scale_fill_grey() + # theme of greyscale
  theme(panel.background = element_rect(fill = 'gray94', color = 'black'), # making the background color light grey
        legend.position="top",  legend.title= element_blank(), # changing legend position and taking away legend title
        axis.title.y = element_text(size=12, face="bold", colour = "black"), # look of the y asix title
        strip.text.y = element_text(size = 10, face="bold", colour = "black")) +  # look of the x axis title
  guides(fill=guide_legend(nrow=1,byrow=TRUE)) 

p
