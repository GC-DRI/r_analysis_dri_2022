####################################
# Intro to Text Analysis
# 01/25/2022

# for data manipulation and plotting
library(tidyverse)
# for working with text data
library(tidytext)
# for obtaining the sentiment analysis lexicons
library(textdata)
# for file path management
library(here)
# for word cloud
library(wordcloud)
library(wordcloud2)
# for color palattes
library(RColorBrewer)

# load data online
lyrics <- read_csv("https://raw.githubusercontent.com/YuxiaoLuo/r_analysis_dri_2022/main/data/genius.csv")

# load data locally
lyrics <- read_csv(here("data", "genius.csv"))

glimpse(lyrics)

# dataset -> one-token-per-row format 
# unnest_tokens(output column, input column, type of token)
# type of token: words, characters, ngrams, sentences, lines, 
# paragraphs, regex 

# split lyrics into words 
tidy_lyrics <- lyrics %>% 
  unnest_tokens(word, 
                line,
                token = "words") 

# count function
# count(data, Var Name, sort = TRUE/FALSE)

lyrics %>% 
  group_by(artist_name) %>% 
  count(song_name, sort = TRUE) %>% 
  View()

####################################
# Wordcloud

# Why you use Word Clouds
# 1. descriptive tool, present text data in a simple and clear format 
# 2. communication tool, handy and capture conversation on 
#    social media or customer reviews
# 3. basic qualitative insights, flexibility in interpretation 

## Generate wordcloud
set.seed(2022) # for reproducibility 

# count(dataset, column name, sort = TRUE/FALSE)
# count words
words_wordcloud <- tidy_lyrics %>% count(word, sort = TRUE)
words_wordcloud

glimpse(tidy_lyrics)
tidy_lyrics %>% count(word, sort = TRUE) 

# max.words: Maximum number of words to be plotted
# min.freq: words with frequency below min.freq will not be plotted
# rot.per: proportion words with 90 degree rotation 
# random.color: plot words in random order. 
# If false, they will be plotted in decreasing frequency

library(wordcloud)
library(RColorBrewer) # color template 
wordcloud(words = words_wordcloud$word, freq = words_wordcloud$n,
          min.freq = 5, max.words =200, random.order = FALSE,
          rot.per = 0.35, colors = brewer.pal(8,"Dark2"))

help(brewer.pal)

# a common mistake: show too many words that have little frequency
# adjust min frequency

# wordcloud2, more advanced wordcloud
library(wordcloud2)

wordcloud2(data=words_wordcloud, size=1, color='random-dark')

help(wordcloud2)

# shape = "cardiod", apple or heart shape curve
wordcloud2(data = words_wordcloud, size = .8, shape = "cardiod")

# other shape: diamond, star, pentagon, triangle, triangle-forward
wordcloud2(data = words_wordcloud, size = .8, shape = "pentagon")

# color: random-dark, random-light
wordcloud2(data=words_wordcloud, size=.8, color='random-light')


# Stopwords: words that are not useful for an analysis, 
# typically extremely common words such as "the", "of", "to"

# anti_join(x, y, by = "...")
# filter rows from x based on the presence or 
# absence of matches in y

# tidytext package has built-in stopwords
stop_words
anti_join(words_wordcloud, stop_words, by = "word")

# look beyond the rows of dictionary after "after"
stop_words %>% View()

# remove stopwords 
words_no_stop <- words_wordcloud %>% 
  anti_join(stop_words, by = "word")

# compare with or without stopwords
glimpse(words_wordcloud)
glimpse(words_no_stop)

wordcloud(words = words_no_stop$word, freq = words_no_stop$n,
          min.freq = 1, max.words =150, random.order = FALSE,
          rot.per = 0.35, colors = brewer.pal(8,"Dark2"))

wordcloud2(data=words_no_stop, size= .8, color='random-dark')

# change size -> include different # of words in the plot
help(wordcloud2)

#############################
# Explore the lyrics dataset

lyrics_no_stop <- tidy_lyrics %>% anti_join(stop_words, by = "word")

lyrics_no_stop %>% count(word, sort = TRUE)

lyrics_no_stop %>% filter(artist_name == "Buck Meek") %>% 
  count(word, sort = TRUE)

# Visualization
lyrics_no_stop %>% 
  filter(artist_name == "Buck Meek") %>% 
  count(word,sort = TRUE) %>% 
  filter(n > 3) %>% 
  mutate(word = reorder(word,n)) %>% 
  ggplot(aes(n,word)) + 
  geom_col() + 
  labs(y = NULL,
       title = "Words Frequency in Buck Meek's Songs")
          
#############
# Exercise 

# Find out Full of Hell's most common words

lyrics_no_stop %>% 
  filter(artist_name == "Full of Hell") %>% 
  count(word,sort = TRUE) %>% 
  filter(n > 3) %>% 
  mutate(word = reorder(word,n)) %>% 
  ggplot(aes(n,word)) + 
  geom_col() + 
  labs(y = NULL,
       title = "Words Frequency in Buck Meek's Songs")


###################################
# Challenge: explore another dataset
# Data: Spotify

# Make a wordcloud (remove the stopwords ) of 
# the lyrics in Spotify dataset

spotify <- read_csv("https://raw.githubusercontent.com/GC-DRI/r_analysis_dri_2022/main/data/spotify_lyrics.csv")

glimpse(spotify)

# ?unnest_tokens
spotify_lyrics <- spotify %>% unnest_tokens(word, lyrics, token = "words")

spotify_wordcloud <- spotify_lyrics %>% count(word, sort = TRUE)

spotify_wordcloud

spotify_no_stop <- spotify_wordcloud %>% 
  anti_join(stop_words, by = "word")

spotify_no_stop

wordcloud2(data=spotify_no_stop, size=.2,
           color='random-light')

# wordcloud without removing stop words
wordcloud2(data = spotify_wordcloud, size = .8, color = 'random-light')

###########################################################################














