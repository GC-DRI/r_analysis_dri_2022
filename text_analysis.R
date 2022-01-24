####################################
# Intro to Text Analysis


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

# load data online
lyrics <- read_csv("https://raw.githubusercontent.com/YuxiaoLuo/r_analysis_dri_2022/main/data/genius.csv")

# load data locally
lyrics <- read_csv(here("data", "genius.csv"))

glimpse(lyrics)

# split lyrics into words 
tidy_lyrics <- lyrics %>% 
  unnest_tokens(word, 
                line,
                token = "words") 

# words for wordcloud
words_wordcloud <- tidy_lyrics %>% count(word, sort = TRUE)
words_wordcloud

# remove stopwords 
words_no_stop <- words_wordcloud %>% 
  anti_join(stop_words, by = "word")

# max.words: Maximum number of words to be plotted
# min.freq: words with frequency below min.freq will not be plotted
# rot.per: proportion words with 90 degree rotation 
# random.color: plot words in random order. 
# If false, they will be plotted in decreasing frequency

wordcloud(words = words_no_stop$word, freq = words_no_stop$n,
          min.freq = 1, max.words =150, random.order = FALSE,
          rot.per = 0.35, colors = brewer.pal(8,"Dark2"))

# wordcloud2, more advanced wordcloud
library(wordcloud2)
wordcloud2(data=words_no_stop, size=.8, color='random-dark')






