---
title: "Intro to Regression Analysis"
author: "Yuxiao Luo"
output:
  html_document:
    keep_md: yes
---



## Welcome

In this workshop, We will explore the basic regression analysis in R. The datasets consist of the `spotify_lyrics` data modified from [the kaggle dataset](https://www.kaggle.com/zaheenhamidani/ultimate-spotify-tracks-db) and the `spotify` data comprised of the musical attributes of weekly [Billboard Hot 100](https://www.billboard.com/charts/billboard-200/) songs from February 2019 to February 2021. Both of the datasets were mined using the [spotifyr](https://www.rcharlie.com/spotifyr/) interface to the [Spotify Web API](https://developer.spotify.com/documentation/web-api/)*. We will have to load the following packages in this workshop: `tidyverse`,`GGally`,`leaps`. 

Learning objectives: 

- Exploratory data analysis

- Fit regression models with the `lm` function 

- Automatic model selection (package `leaps`)

- Prediction

- Interaction terms 

Along the way, you will master the core functions for running linear regression in R and be able to interpret the regression result generated in R: 

- `pairs()` and `ggpairs()`, which let you explore the relationships among variables 

- `glimpse` and `summary()`, which let you understand the structure of the dataset and descriptive statistics of the variables 

- `%>%`, which organizes your code into reader-friendly "pipes" 

- `step`, which helps with automatic model selection 

First, let's load the `tidyverse` suite of packages and the `here` package. The `here` package simplifies the way of reproducing file paths. 


```r
library(tidyverse)
library(here)
library(GGally)
library(leaps)
```

### Spotify data
We'll first analyze a Spotify dataset and the variables are:

- energy: Energy is a measure from 0.0 to 1.0 and represents a perceptual measure of intensity and activity. Typically, energetic tracks feel fast, loud, and noisy

- loudness: The overall loudness of a track in decibels (dB). Loudness values are averaged across the entire track and are useful for comparing relative loudness of tracks

- tempo: The overall estimated tempo of a track in beats per minute (BPM)

- danceability: Danceability describes how suitable a track is for dancing based on a combination of musical elements including tempo, rhythm stability, beat strength, and overall regularity

- lyrics: lyrics in the song                                       

More details about the variables can be found at [here](https://github.com/YuxiaoLuo/r_analysis_dri_2022/blob/main/data/meta_spotify.md). In our case, the dependent/response variable will be **energy**. 

Let's read the dataset first. You can load it either online or locally. 


```r
# if you haven't downloaded the dataset, load it online
spo <- read_csv("https://raw.githubusercontent.com/YuxiaoLuo/r_analysis_dri_2022/main/data/spotify_lyrics.csv")

# if you have the dataset locally, load it in the data folder
spo <- read_csv(here("data", "spotify_lyrics.csv"))

glimpse(spo)
```

```
## Rows: 26,000
## Columns: 6
## $ genre        <chr> "Alternative", "Alternative", "Alternative", "Alternative~
## $ energy       <dbl> 0.647, 0.735, 0.917, 0.606, 0.641, 0.973, 0.919, 0.889, 0~
## $ loudness     <dbl> -8.509, -4.749, -6.086, -5.060, -5.104, -3.642, -5.938, -~
## $ tempo        <dbl> 79.810, 163.132, 140.639, 93.060, 142.043, 125.691, 108.0~
## $ danceability <dbl> 0.709, 0.436, 0.544, 0.603, 0.487, 0.524, 0.657, 0.611, 0~
## $ lyrics       <chr> "into into into of him by economic without by his is with~
```

### Exploratory data analysis
The function `pairs` creates a scatterplot matrix for **numeric** variables:


```r
spo_plot <- spo %>% select(-genre, -lyrics)
pairs(spo_plot)
```

![](regression_analysis_files/figure-html/scatterplot-1.png)<!-- -->

The dataset **spo_plot** excludes the variables **genre** and **lyrics**. We can get quick and dirty summaries of the variables with summary. An advantage is that it's able to handle categorical variables, such as **genre**: 


```r
summary(spo)
```

```
##     genre               energy            loudness           tempo       
##  Length:26000       Min.   :0.000216   Min.   :-47.599   Min.   : 31.03  
##  Class :character   1st Qu.:0.379000   1st Qu.:-11.778   1st Qu.: 93.17  
##  Mode  :character   Median :0.601000   Median : -7.790   Median :116.02  
##                     Mean   :0.568407   Mean   : -9.554   Mean   :117.95  
##                     3rd Qu.:0.786000   3rd Qu.: -5.508   3rd Qu.:139.34  
##                     Max.   :0.999000   Max.   :  3.744   Max.   :220.28  
##   danceability       lyrics         
##  Min.   :0.0592   Length:26000      
##  1st Qu.:0.4340   Class :character  
##  Median :0.5720   Mode  :character  
##  Mean   :0.5554                     
##  3rd Qu.:0.6940                     
##  Max.   :0.9810
```

The function `ggpairs` in `library(GGally)` produces the equivalent plot, but with `ggplot2`: 


```r
ggpairs(spo_plot)
```

![](regression_analysis_files/figure-html/unnamed-chunk-2-1.png)<!-- -->

### Fitting regression models with the lm function
Fitting regression models with R is easy as R was developed originally as a statistical/mathematical computing language. For example, we can fit a model where the response variable is **energy** and the predictors are **tempo** and **loudness**. 



```r
lm_spo <- lm(energy ~ tempo + loudness, spo)

lm_spo
```

```
## 
## Call:
## lm(formula = energy ~ tempo + loudness, data = spo)
## 
## Coefficients:
## (Intercept)        tempo     loudness  
##   0.8630598    0.0004041    0.0358292
```

If we call the object `lm_spo`, it will return us coefficients. If we want details about p-values, R-squared, and more, we can get them with `summary()`.


```r
summary(lm_spo)
```

```
## 
## Call:
## lm(formula = energy ~ tempo + loudness, data = spo)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -0.63414 -0.10755  0.00001  0.10976  0.78925 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)    
## (Intercept) 8.631e-01  4.426e-03  195.01   <2e-16 ***
## tempo       4.041e-04  3.139e-05   12.87   <2e-16 ***
## loudness    3.583e-02  1.625e-04  220.54   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.1521 on 25997 degrees of freedom
## Multiple R-squared:  0.6697,	Adjusted R-squared:  0.6697 
## F-statistic: 2.636e+04 on 2 and 25997 DF,  p-value: < 2.2e-16
```

We can get diagnostic plots by plotting the model. That will give us 4 diagnostic plots. We can arrange them in a figure with x rows and y columns with `par(mfrow=c(x,y))`.


```r
par(mfrow=c(2,2))
plot(lm_spo)
```

![](regression_analysis_files/figure-html/plotting1-1.png)<!-- -->

If we want them in 1 row and 4 columns: 


```r
par(mfrow=c(1,4))
plot(lm_spo)
```

![](regression_analysis_files/figure-html/plotting2-1.png)<!-- -->

The `par(mfrow=c(x,y))` function can arrange figures with multiple rows and columns of plots in `library(graphics)`. But it doesn't work with `ggplot2`, in which `grid.arrange` is used to do the same thing. 

We can extract diagnostics from the regression model. For example, if we are interested in Cook's distances, which is useful for identifying influential data points and outliers in the X values, we can extract Cook's distances and plot them against observation number. 

A general rule of thumb is that any point with a Cook's distance over 4/n (where n is the number of observations) is considered to be an outlier. Please note that just because a data point is influential doesn't mean it should necessarily be deleted. You can find more the interpretation of it [here](https://www.statology.org/how-to-identify-influential-data-points-using-cooks-distance/).


```r
cookd <- cooks.distance(lm_spo)
plot(cookd)
abline(h = 4/nrow(spo), lty = 2, col = "steelblue") # add cutoff line
```

![](regression_analysis_files/figure-html/cookdistance-1.png)<!-- -->

Other useful functions are `hatvalues` (for leverages), `residuals` (for residuals), and `rstandard` (for standardized residuals). 

Leverage is used to identify outliers with respect to the independent variables and high-leverage points have the potential to cause large changes in the parameter estimates when they are deleted. More details about leverage click [here](https://handwiki.org/wiki/Leverage_(statistics)).

Another important assumption check is the multicollinearity of the independent variables. We can use `vif()` in `library(car)` to test it. 


```r
car::vif(lm_spo)
```

```
##    tempo loudness 
## 1.052857 1.052857
```

The rule of thumb is that VIFs exceeding 4 warrant further investigation, while VIFs exceeding 10 are signs of serious multicollinearity. More statistical details can be found [here](https://online.stat.psu.edu/stat462/node/180/).

### Practice of fitting a regression model

Here, we have a NYC restaurant dataset for you to practice what we have just learned. You'll analyze a dataset in Sheather (2009) that has information about 150 Italian restaurants in Manhattan that were open in 2001 (some of them are closed now). The variables are:

- Case: case-indexing variable 

- Restaurant: name of the restaurant 

- Price: average price of meal and a drink 

- Food: average Zagat rating of the quality of the food (from 0 to 25)

- Decor: same as above, but with quality of the decor

- Service: same as above, but with quality of service

- East: it is equal to East if the restaurant is on the East Side (i.e. east of Fifth Ave) and West otherwise.

In the practice problem, the response variable will be **Price** and the predictors are **Food**, **Decor**, **Service**, **East**. You will have to:

1. Load the dataset in R. 
  - Using the link: `read_csv('https://raw.githubusercontent.com/YuxiaoLuo/r_analysis_dri_2022/main/data/nyc.csv')`
  - Or load it locally: `read_csv(here('data', 'nyc.csv'))` 

2. Explore the relationship between variables

3. Run a linear regression model and generate the regression result

### Solution to the Practice Problem 

Load the dataset into R and take a look at the variables. 


```r
nyc <- read_csv('https://raw.githubusercontent.com/YuxiaoLuo/r_analysis_dri_2022/main/data/nyc.csv')
glimpse(nyc)
```

```
## Rows: 150
## Columns: 7
## $ Case       <dbl> 148, 2, 144, 131, 26, 29, 160, 83, 105, 126, 140, 80, 7, 5,~
## $ Restaurant <chr> "Vago Ristorante", "Tello's Ristorante", "Giovanni", "Torre~
## $ Price      <dbl> 45, 32, 45, 47, 37, 49, 31, 38, 51, 47, 42, 48, 34, 54, 53,~
## $ Food       <dbl> 22, 20, 22, 19, 19, 22, 20, 23, 24, 18, 18, 21, 22, 24, 22,~
## $ Decor      <dbl> 21, 19, 19, 21, 17, 19, 17, 19, 21, 18, 21, 18, 16, 19, 24,~
## $ Service    <dbl> 23, 19, 21, 17, 19, 20, 19, 24, 21, 17, 17, 19, 21, 21, 21,~
## $ East       <chr> "West", "West", "West", "West", "East", "East", "West", "Ea~
```

Further explore the data with `summary` and `ggpairs`.


```r
summary(nyc)
```

```
##       Case         Restaurant            Price            Food      
##  Min.   :  2.00   Length:150         Min.   :19.00   Min.   :16.00  
##  1st Qu.: 41.50   Class :character   1st Qu.:35.25   1st Qu.:19.00  
##  Median : 83.50   Mode  :character   Median :42.00   Median :21.00  
##  Mean   : 84.17                      Mean   :42.62   Mean   :20.61  
##  3rd Qu.:124.75                      3rd Qu.:49.75   3rd Qu.:22.00  
##  Max.   :168.00                      Max.   :65.00   Max.   :25.00  
##      Decor          Service          East          
##  Min.   : 6.00   Min.   :14.00   Length:150        
##  1st Qu.:16.00   1st Qu.:18.00   Class :character  
##  Median :18.00   Median :20.00   Mode  :character  
##  Mean   :17.69   Mean   :19.39                     
##  3rd Qu.:19.00   3rd Qu.:21.00                     
##  Max.   :25.00   Max.   :24.00
```

Create a dataset nycplot excludes the variables Case, Restaurant, and East. 


```r
nycplot <- nyc %>% select(-Case, -Restaurant, -East)
ggpairs(nycplot)
```

![](regression_analysis_files/figure-html/problem-matrix-1.png)<!-- -->

Do you see any interesting patterns in the matrix? Now, let's run the regression based on the proposed model, where **Price** is the dependent variable and the predictors are **Food**, **Decor**, **Service**, and **East**. 


```r
lm_nyc <- lm(Price ~ Food + Decor + Service + East, data = nyc)
summary(lm_nyc)
```

```
## 
## Call:
## lm(formula = Price ~ Food + Decor + Service + East, data = nyc)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -13.7995  -3.8323   0.0997   3.3449  16.8484 
## 
## Coefficients:
##               Estimate Std. Error t value Pr(>|t|)    
## (Intercept) -23.644163   5.079278  -4.655 7.25e-06 ***
## Food          1.634869   0.384961   4.247 3.86e-05 ***
## Decor         1.865549   0.221396   8.426 3.22e-14 ***
## Service       0.007626   0.432210   0.018    0.986    
## EastWest     -1.613350   1.000385  -1.613    0.109    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 5.692 on 145 degrees of freedom
## Multiple R-squared:  0.6466,	Adjusted R-squared:  0.6369 
## F-statistic: 66.34 on 4 and 145 DF,  p-value: < 2.2e-16
```

Run the diagnostic graphs and VIF checks.


```r
par(mfrow=c(2,2))
plot(lm_nyc)
```

![](regression_analysis_files/figure-html/problem-check-1.png)<!-- -->


```r
car::vif(lm_nyc)
```

```
##     Food    Decor  Service     East 
## 2.760715 1.781993 3.710626 1.075941
```

Read the regression result, what conclusions can you draw from it? 



