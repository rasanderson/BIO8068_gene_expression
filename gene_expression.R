# Gene expression analysis of Brauer data

# Read and examine the raw data ####
library(readr)
original_data <- read_delim("data/Brauer2008_DataSet1.tds", delim="\t")
original_data
dim(original_data)
View(original_data)

# First entries of NAME
original_data$NAME[1:3]
























#
#
#
#
#
# Load essential libraries
library(dplyr)
library(tidyr)

# Tidy up the data ####

# Separate NAME,
cleaned_data <- original_data %>%
  separate(NAME, c("name", "BP", "MF", "systematic_name", "number"), sep = "\\|\\|")




























#
#
#
#
# Separate NAME, cleanup whitespace
cleaned_data <- original_data %>%
  separate(NAME, c("name", "BP", "MF", "systematic_name", "number"), sep = "\\|\\|") %>%
  mutate_at(vars(name, BP, systematic_name, MF), funs(trimws(.)))

























#
#
#
#
#
# Separate NAME, cleanup whitespace and drop columns
cleaned_data <- original_data %>%
  separate(NAME, c("name", "BP", "MF", "systematic_name", "number"), sep = "\\|\\|") %>%
  mutate_at(vars(name, BP, systematic_name, MF), funs(trimws(.))) %>% 
  select(-number, -GID, -YORF, -GWEIGHT)


























#
#
#
#
# Separate NAME, cleanup whitespace, drop columns and gather
cleaned_data <- original_data %>%
  separate(NAME, c("name", "BP", "MF", "systematic_name", "number"), sep = "\\|\\|") %>%
  mutate_at(vars(name, BP, systematic_name, MF), funs(trimws(.))) %>% 
  select(-number, -GID, -YORF, -GWEIGHT) %>%
  gather(sample, expression, G0.05:U0.3)






























#
#
#
#
#
library(stringr)

# Separate NAME, cleanup whitespace, drop columns, gather and separate nutrient from rate
cleaned_data <- original_data %>%
  separate(NAME, c("name", "BP", "MF", "systematic_name", "number"), sep = "\\|\\|") %>%
  mutate_at(vars(name, BP, systematic_name, MF), funs(trimws(.))) %>% 
  select(-number, -GID, -YORF, -GWEIGHT) %>%
  gather(sample, expression, G0.05:U0.3) %>%
  separate(sample, c("nutrient", "rate"), sep = 1, convert = TRUE)



























#
#
#
#
#
#
# At last! Data now tidy; start to explore ####
library(ggplot2)

# ggplot of leucine
cleaned_data %>%
  filter(name == "LEU1") %>%
  ggplot(aes(rate, expression, color = nutrient)) +
  geom_line()






























#
#
#
#
# All the leucine BP
cleaned_data %>%
  filter(BP == "leucine biosynthesis") %>%
  ggplot(aes(rate, expression, color = nutrient)) +
  geom_line() +
  facet_wrap(~name)





























#
#
#
#
#
# All the leucine BP plus linear model
cleaned_data %>%
  filter(BP == "leucine biosynthesis") %>%
  ggplot(aes(rate, expression, color = nutrient)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  facet_wrap(~name)





























#
#
#
#
#
#
# Ditto for Sulphur metabolism
# Sulphur metabolism
cleaned_data %>%
  filter(BP == "sulfur metabolism") %>%   # Yankee spelling!!!!!
  ggplot(aes(rate, expression, color = nutrient)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  facet_wrap(~name + systematic_name, scales = "free_y")






























#
#
#
#
#
#
# Take home message: not much code needed ####
# # Core code
# library(dplyr)
# library(tidyr)
# library(ggplot2)
# 
# cleaned_data <- original_data %>%
#   separate(NAME, c("name", "BP", "MF", "systematic_name", "number"), sep = "\\|\\|") %>%
#   mutate_at(vars(name, BP, systematic_name, MF), funs(trimws(.))) %>% 
#   select(-number, -GID, -YORF, -GWEIGHT) %>%
#   gather(sample, expression, G0.05:U0.3) %>%
#   separate(sample, c("nutrient", "rate"), sep = 1, convert = TRUE)
# 
# cleaned_data %>%
#   filter(BP == "leucine biosynthesis") %>%
#   ggplot(aes(rate, expression, color = nutrient)) +
#   geom_point() +
#   geom_smooth(method = "lm", se = FALSE) +
#   facet_wrap(~name)
#
#
