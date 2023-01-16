#import libraries
library(tidyverse)
library(ggplot2)
library(stringr)

#set up data frames
colors <- read.csv('C:/Users/Mnandrews24/Documents/Data_Viz_Projects/BobRoss_Challenge/BobRossColors/Bob_Ross_Paintings/data/bob_ross_paintings.csv')
elements <- read.csv('C:/Users/Mnandrews24/Documents/Data_Viz_Projects/BobRoss_Challenge/BobRossColors/data/bob-ross/elements-by-episode.csv')

#MY QUESTIONS
# Average colors per painting? (10.60546)
mean(colors$num_colors)

# Most common colors used? (#1 Titanium White)
### remove columns - only color columns left
colors1 <- colors %>% select(- (X:color_hex))

### Pivot table and summarize by color name
colorsLong <- colors1 %>% pivot_longer(cols = colnames(colors1), names_to = "color", values_to = "count")%>% 
  group_by(color) %>% summarize(count = sum(count))

# Get hex codes out of list and into colorsLong
### remove columns - only list of names and list of hex left
hex_codes <- colors %>% select (-(X:youtube_src), -(Black_Gesso:Alizarin_Crimson))

### Remove starting & ending brackets
hex_codes$colors <- str_sub(hex_codes$colors, 2, -2)
hex_codes$color_hex <- str_sub(hex_codes$color_hex, 2, -2)

### Phthalto Green has extra characters \r\n - remove?


### Fake character list to real list
hex_codes$colors <- as.list(strsplit(hex_codes$colors, "', '"))
hex_codes$color_hex <- as.list(strsplit(hex_codes$color_hex, "', '"))

### List elements to row, keeping color name and hex paired



#TESTING CHARTS
ggplot(data = colorsLong, aes(x = color, y = count)) +
  geom_bar(stat="identity", fill="steelblue")


