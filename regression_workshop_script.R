

library(tidyverse)
library(GGally)
library(here)

# install.packages("GGally", dependencies = TRUE)

spo <- read_csv("https://raw.githubusercontent.com/YuxiaoLuo/r_analysis_dri_2022/main/data/spotify_lyrics.csv")

# dataset name: spotify_lyrics.csv
spo <- read_csv(here("data","spotify_lyrics.csv"))

# overview of the vars.
glimpse(spo)

# summary of the statistics of vars.
summary(spo)

spo <- spo %>% select(energy, loudness, tempo, danceability)

library(GGally)
ggpairs(spo)

# think about how to construct the model 

# reponse var: energy
# predictors: temp and loundess 

lm_spo <- lm(energy ~ tempo + loudness, data = spo)
lm_spo

# get details about the performance of the model 
# significance 
summary(lm_spo)

# https://www.calculator.net/scientific-notation-calculator.html?cvtnum=2e-16&ctype=1&submit1=Convert

# 4 plots 
par(mfrow = c(2,2))
plot(lm_spo)

par(mfrow=c(1,4))
plot(lm_spo)

# vif()
# check if independent variables are 
# hightly correlated with each other
library(car)
# install.packages("car")
car::vif(lm_spo)

# rule of thumb: 
# < 2: perfect, no multicollinearity 
# < 4: you are ok
# > 4: worth investigation 
# > 10: serious multicollinearity 

# vip()
# variable importance score/plots  
install.packages("vip")
library(vip)

# vi: variable importance
vi(lm_spo)

# variable importance plot
vip(lm_spo)

# scatterplot matrix 
# relationship between different independent variables 
pairs(spo)

## practice 1 

##################################
# Mediation Analysis

# Introduction to Mediation Analysis
# https://data.library.virginia.edu/introduction-to-mediation-analysis/





