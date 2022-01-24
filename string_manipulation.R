#######################################
# string manipulation using stringr
#

library(stringr)

####################################
# Individual vectors and white space 


# str_length


# str_sub


# dupilcate individuals 
# str_dup


# joins two or more vector element-wise into a single character vector 
# like paste()
# str_c


# pad a string to a fixed length by adding extra white space 
# str_pad

# remove leading and trailing white space
# str_trim


#######################################
# Pattern matching 

strings <- c(
  "apple", 
  "219 733 8965", 
  "329-293-8753", 
  "Work: 579-499-7527; Home: 543.355.3679"
)

# define pattern 
phone <- "([2-9][0-9]{2})[- .]([0-9]{3})[- .]([0-9]{4})"

# detects the presence or absence of a pattern and returns a logical vector 
# str_detect

str_detect(strings, phone)

# returns the elements of a character vector that matches a regular expression 
# str_subset

# counts number of matches in each string
# str_count

# locates the first position of a pattern and retrns a numeric matrix 
# with columns start and end 
# str_locate 
str_locate(strings, phone)

# locates all matches, returning a list of numeric matrices 
# str_locate_all
str_locate_all(strings, phone)


# extracts text corresponding to the first match, 
# returning a character vector
# str_extract

# extract all matches and returns a list of character vector 
# str_extract_all

# replace the first matched pattern and returns a character vector
# str_replace

# replace all matches
# str_replace_all


# splits a string into a variable number of pieces and 
# returns a list of character vectors
# str_split


# simplifies a list and produce a vector which contains all atomic components
# unlist()


# remove matched patterns 
# str_remove
str_remove(strings, phone)










