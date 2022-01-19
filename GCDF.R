
# load packages 
library(readr)
library(GGally)
library(tidyverse)

####################################
# introduce Titanic dataset
# why we do regression model
# different variable types: discrete, binary, categorical, continuous 
# dependent vs. independent 
# Hypothesis testing 
# Distribution type 
# Correlation 

# read dataset
tita <- read_csv("C:/Users/Yuxiao Luo/Documents/R/RUG/titanic_train.csv", col_names = T)

# exploratory analysis
head(tita)

summary(tita)

GGally::ggpairs(tita, axisLabels = "show")

# Dependent variable 
# Independent variable 
# Y: Survival rate 
# X: Pclass, Age, Sex 

# fit logistic regression 
glimpse(tita)
logistic <- glm(Survived ~ Pclass + Age + Sex, family = "binomial", data = tita)

# help 
?glm

# check the result of regression
summary(logistic)

# Model Performance: R^2 or AIC 

# vip: variable importance score
library(vip)
vip::vip(logistic)

# Question 1 for the demo: 

# Question 2 for the demo: 

###########################################
#### Practice problem 1: cars dataset

library(caret)
library(ggplot2)
data(cars)
summary(cars)

# load ggpair matrix --> too large
ggpairs(cars)

# explore them separately 

linMod <- lm(Price ~ Mileage + Cylinder + Doors + Cruise, data = cars)

# Y^ - Y(actual value): residuals 

summary(linMod)

# R^2 -> performance of the model
# the larger the R^2, the better the model can explain the change of the dependent var

# save.image("GCDF.Rdata")
# load("GCDF.Rdata")

###########################################
#### Practice problem 2: Spotify dataset

spo <- read.csv("https://raw.githubusercontent.com/GC-DRI/R_data_analysis/master/data/spotify.csv")

glimpse(spo)

spo <- spo %>% select(energy, loudness, tempo) 

summary(spo)

GGally::ggpairs(spo)

lm_spo <- lm(energy ~ tempo + loudness, spo)

summary(lm_spo)

# check for multicollinearity 
car::vif(lm_spo)

##################################
# Mediation Analysis

# Introduction to Mediation Analysis
# https://data.library.virginia.edu/introduction-to-mediation-analysis/








































