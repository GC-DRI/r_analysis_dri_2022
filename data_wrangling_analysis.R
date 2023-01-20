##################################################
# DRI 2023 R Track
# data wrangling and analysis
# Github repo:
# https://github.com/GC-DRI/r_data_analysis_2021/blob/main/data-wrangling.md

library(tidyverse)

# 2 ways of input data

# input data from local 
# spotify <- read_csv('/kaggle/input/dri2023/data/spotify.csv')
# input data from online resource
spotify <- read_csv('https://raw.githubusercontent.com/YuxiaoLuo/r_analysis_dri_2022/main/data/spotify.csv')

# see top 10 rows of data
head(spotify)

# see summary of variables
glimpse(spotify)

# select() - extracts columns from data frame
# filter() - extracts rows from data frame

####################################
# select() function

# if you want to select the loudness variable
select(spotify, loudness)

# if you want to select more than one variable
# include the column names, separated by commas, as arguments to the function
select(spotify, loudness, instrumentalness, key)

## select helper

# - , remove the columns after it
# remove everything but the rank & track columns
select(spotify, -c(artist:time_signature))

# contains(), column names that contains a string
select(spotify, contains('time'))

# ends_with(), column names that ends with letter k
select(spotify, ends_with('k'))

###################################################
# filter() function
# extracts rows from dataframe and returns them as new dataframe
# filter(x,y)
# x: a data frame to extract rows from
# y: a logical test that returns TRUE or FALSE
glimpse(spotify)

# a == b : a equal to b?
filter(spotify, time_signature == 5)

# a > b : is x greater than y 
filter(spotify, time_signature > 3)

# is.na(a): is a missing value?
filter(spotify, is.na(time_signature))

#############################
# Exercise
# 1. filter all songs in the 'post_covid' covid_period
# 2. Filter all songs where tempo is less than or equal to 80
# 3. Stretch challenge: all songs that have more than 20 characters in title
#    Hint: use str_length() to calculate # of characters

# two common mistakes:  
# use single equal sign
# forget to use quotations for strings

## Boolean operators

# & : are both a and b true? 
filter(spotify, time_signature > 4 & mode == 'major')

# | : are one or both of a and b true?
filter(spotify, season == 'Summer' | season == 'Spring')

# ! : is a not true
filter(spotify, ! season == "Winter") 

# %in%: is a in the set?
filter(spotify, season %in% c('Summer', 'Spring'))

#########################################
# %>% Piping 
# f(x,y) --> x %>% f(y)

# remember | in command line? This does the same thing

# Think about this task:
# extract rows that are in 'pre_covid' and 
# select loudness & energy features from the data
select(filter(spotify, covid_period == "pre_covid"), loudness, energy)

spotify %>% filter(covid_period == 'pre_covid') %>% select(loudness, energy)

###########
# Exercise
## Filter spotify to the songs that are above .5 danceability
# select the tempo and energy columns


#######################################
# Summarizing data
# summarize: pass it a data frame and then one or more
# named arguments, it will turn each named argument into a column in the new data frame

spotify %>% 
  filter(season == "Spring") %>% 
  summarize(avg_energy = mean(energy))

spotify %>% 
  filter(season == "Winter") %>% 
  summarize(
    avg_energy = mean(energy),
    max_energy = max(energy),
    total_energy = sum(energy)
  )

################
# Exercise
# the average of loudness of songs in the fall (mean)
# the max danceability of any song in fall (max)
# the min energy of any song in fall (min)


########################
# Summarize by groups
# group_by() takes a data frame and returns a copy of the data frame 
# that has been grouped into sets of rows

spotify %>% 
  group_by(covid_period) %>% 
  summarize(min_loud = min(loudness))

###############
# exercise
# Calculate the average danceability of top 40 songs for each season

spotify %>% 
  filter(rank <= ****) %>% 
  group_by(****) %>% 
  summarize(mean_dance = mean(****))

#################################################
# Create, modify, and delete columns
# mutate()

# change variable type
class(spotify$rank)

spotify_rank <- spotify %>% 
  mutate(rank = as.ordered(rank))

class(spotify_rank$rank)
spotify_rank$rank

# create new rows from existing rows
# let's create a new composite metric: raw_power (energy, loudness)
# raw_power = energy x (loudness - min(loudness))

spotify_power <- spotify %>% 
  mutate(raw_power = energy*(loudness-min(loudness)))

# take a look at the new composite metric raw_power
spotify_power %>% select(energy, loudness, raw_power)

##############################
# Exercise 
# Create a new variable called boogie = danceability * tempo
# call the new data frame spotify_boogie

spotify_boogie <- spotify %>% 
  mutate(boogie = danceability*tempo)

spotify_boogie %>% select(danceability, tempo, boogie)

##########################################
# Investigate the mode in different tracks
select(spotify, track, mode, valence) %>% count(mode, wt = valence)

select(spotify, track, mode, valence, tempo, speechiness, energy, covid_period) %>% 
  group_by(mode) %>% 
  summarize(meanValence = mean(valence), 
            meanTempo = mean(tempo), 
            meanSpeechiness = mean(speechiness), 
            meanEnergy = mean(energy),
            Pre_Covid = sum(covid_period == "pre_covid"),
            Post_Covid = sum(covid_period == "post_covid"))

select(spotify, track, mode, valence, tempo, speechiness, energy, covid_period) %>% 
  group_by(mode) %>% 
  summarize(meanValence = mean(valence), 
            meanTempo = mean(tempo), 
            meanSpeechiness = mean(speechiness), 
            meanEnergy = mean(energy),
            Pre_Covid = sum(covid_period == "pre_covid")/sum(spotify$covid_period == "pre_covid"),
            Post_Covid = sum(covid_period == "post_covid")/sum(spotify$covid_period == "post_covid"))

#########################################
# Weekly summary stats

library(lubridate) # package for handling date-time data

spotify_sum <- spotify %>% 
  group_by(week) %>% 
  summarize(
    valence = median(valence),
    tempo = median(tempo),
    speechiness = median(speechiness),
    instrumentalness = median(instrumentalness),
    liveness = median(liveness),
    loudness = median(loudness),
    acousticness = median(acousticness),
    danceability = median(danceability),
    energy = median(energy),
    major = sum(mode == "major"),
    minor = sum(mode == "minor"),
    duration_ms = median(duration_ms),
    time_since_covid = median(time_since_covid),
    covid_period = max(covid_period)
  ) %>% 
  mutate(
    # get the proportion of minor songs for the week
    prop_minor = minor / (major + minor)
  ) %>% 
  # convert character to date format
  mutate(week = mdy(week)) %>% 
  # reorder the rows from early time to later time
  arrange(-desc(week))
