##Check permission of web  page  to be  scraped
library(robotstxt)

##Read the website
library(xml2)
##Extract  data from website
library(rvest)
library(magrittr)

#Data clearing
library(stringr)

#Specifying the urlfor desired website to be scraped
url<-'http://www.imdb.com/search/title?count=100&release_date=2016,2016&title_type=feature'

#Reading the HTML code from the website
webpage <-read_html(url)
webpage

#Using CSS selectors to scrape the rankings section
rank_data_html<-html_nodes(webpage,'.text-primary')
rank_data_html

#Converting the ranking data to text
rank_data<-html_text(rank_data_html)
rank_data

#Data-Preprocessing: Converting rankings to numerical
rank_data<-as.numeric(rank_data)
head(rank_data)
rank_data

#Using CSS selectors to scrape the title section
title_data_html<-html_nodes(webpage,'.lister-item-header a')
title_data_html

#Converting the title data to text
title_data<-html_text(title_data_html)
head(title_data)
title_data

#Using CSS selectors to scrape the description section
description_data_html<-html_nodes(webpage,'.ratings-bar+ .text-muted')
description_data_html
head(description_data_html)

#Converting the description data to text
description_data<-html_text(description_data_html)
head(description_data)

#Data-Preprocessing: removing '\n'
description_data<-gsub("\n","",description_data)
head(description_data)
description_data

#Using CSS selectors to scrape the Movie runtime section
runtime_data_html <- html_nodes(webpage,'.text-muted .runtime')
runtime_data_html

#Converting the runtime data to text
runtime_data <- html_text(runtime_data_html)
runtime_data

#Let's have a look at the runtime
head(runtime_data)

#Data-Preprocessing: removing mins and converting it to numerical
runtime_data<-gsub(" min","",runtime_data)
runtime_data<-as.numeric(runtime_data)



#Let's have another look at the runtime data
head(runtime_data)

#Using CSS selectors to scrape the Movie genre section
genre_data_html <- html_nodes(webpage,'.genre')

#Converting the genre data to text
genre_data <- html_text(genre_data_html)

#Let's have a look at the runtime
head(genre_data)
genre_data

#Data-Preprocessing: removing \n
genre_data<-gsub("\n","",genre_data)

#Data-Preprocessing: removing excess spaces
genre_data<-gsub(" ","",genre_data)

#taking only the first genre of each movie
genre_data<-gsub(",.*","",genre_data)

#Convering each genre from text to factor
genre_data<-as.factor(genre_data)

#Let's have another look at the genre data
head(genre_data)
genre_data


#Using CSS selectors to scrape the IMDB rating section
rating_data_html<-html_nodes(webpage,'.ratings-imdb-rating  strong')
rating_data_html

#Converting the rating data to text
rating_data <- html_text(rating_data_html)
rating_data

#Data-Preprocessing: converting ratings to numerical
rating_data <- as.numeric(rating_data)
rating_data
head(rating_data)

#Using CSS selectors to scrape the votes section
votes_data_html <- html_nodes(webpage, '.sort-num_votes-visible span:nth-child(2)')
votes_data_html

#convert the voting data to text
votes_data <- html_text(votes_data_html)
head(votes_data)

#Data-Preprocessing: removing commas
votes_data<-gsub(",","",votes_data)
head(votes_data)


#Data-Preprocessing: converting ratings to numerical
votes_data<- as.numeric(votes_data)
head(votes_data)

#Using CSS selectors to scrape the directors section
directors_data_html <- html_nodes(webpage, '.text-muted+ p a:nth-child(1)')
directors_data_html

#convert the Directors data to text
directors_data <- html_text(directors_data_html)
directors_data

#Data-Preprocessing: converting directors data into factors
directors_data <- as.factor(directors_data)
head(directors_data)


#Using CSS selectors to scrape the actors section
actors_data_html<-html_nodes(webpage, '.lister-item-content .ghost+ a')
actors_data_htm l

#Converting the gross actors data to text
actors_data <- html_text(actors_data_html)
head(actors_data)

#Data-Preprocessing: converting directors data into factors
actors_data <- as.factor(actors_data)
head(actors_data)

#Using CSS selectors to scrape the metascore section
metascore_data_html <- html_nodes(webpage, '.metascore')
metascore_data_html

#Converting the runtime data to text
metascore_data <- html_text(metascore_data_html)
head(metascore_data)

#Data-Preprocessing: removing extra space in metascore
metascore_data <- gsub(" ","", metascore_data)
head(metascore_data)

#Lets check the length of metascore data
length(metascore_data)

##Step-8
#The length of the metascore data is 96 while we are scraping the data for 100 movies. 
#The reason this happened is that there are 4 movies that don't have the corresponding Metascore
#fields.


##Step 9:
#It is a practical situation which can arise while scraping any website. Unfortunately, 
#if we simply add NA's to last 4 entries, it will map NA as Metascore for movies 96 to 100 
#while in reality, the data is missing for some other movies. After a visual inspection, 
#I found that the Metascore is missing for movies 39, 73, 80 and 89. I have written the following
#function to get around this problem.

for (i in c(13,29,40,43)){
  
  a<-metascore_data[1:(i-1)]
  
  b<-metascore_data[i:length(metascore_data)]
  
  metascore_data<-append(a,list("NA"))
  
  metascore_data<-append(metascore_data,b)
  
}

#Data-Preprocessing: converting metascore to numerical
metascore_data<-as.numeric(metascore_data)

#Let's have another look at length of the metascore data
length(metascore_data)

#Let's look at summary statistics
summary(metascore_data)


#Step 10:
#The same thing happens with the Gross variable which represents gross earnings of that movie
#in millions. I have use the same solution to work my way around:

#Using CSS selectors to scrape the gross revenue section
gross_data_html<-html_nodes(webpage, '.ghost~ .text-muted+ span')

#Converting the gross revenue data to text
gross_data <- html_text(gross_data_html)
head(gross_data)

#Data-Preprocessing: removing '$' and 'M' signs

# Option 1 - this is the original code from tutorial
gross_data<-gsub("M","",gross_data)
gross_data<-substring(gross_data,2,6)

# Option 2 - this line of code accomplishes Option 1 in one line. Provided by classmate Steve Duky.
#gross_data<-gsub("[^0-9.]*","",gross_data) 

#Let's check the length of gross data
length(gross_data)

#Filling missing entries with NA
for (i in c(29,33,40,41,43,72,74,75,76, 100)){
  
  a<-gross_data[1:(i-1)]
  
  b<-gross_data[i:length(gross_data)]
  
  gross_data<-append(a,list("NA"))
  
  gross_data<-append(gross_data,b)
  
}

length(gross_data)

#Data-Preprocessing: converting gross to numerical

# 2 lines of addt'l code provided by Prof - a workaround for gross_data having 2 extra liines when NA is added to empty cells
unlist(gross_data) 

gross_data <- gross_data[-c(101,102)] 

gross_data<-as.numeric(gross_data)
#Let's have another look at the length of gross data
length(gross_data)
summary(gross_data)

##Step 11:
#Now we have successfully scraped all the 11 features for the 100 most popular feature films 
#released in 2016. Let's combine them to create a dataframe and inspect its structure.

#Combining all the lists to form a data frame
movies_df<-data.frame(Rank = rank_data, Title = title_data,
                      
                      Description = description_data, Runtime = runtime_data,
                      
                      Genre = genre_data, Rating = rating_data,
                      
                      Metascore = metascore_data, Votes = votes_data,                 
                      
                      Gross_Earning_in_Mil = gross_data,
                      
                      Director = directors_data, Actor = actors_data)


#Structure of the data frame

str(movies_df)

head(movies_df)

##6. Analyzing scraped data from the web
library(ggplot2)
qplot(data = movies_df, Runtime, fill= Genre, bins = 30)

#Question 1: Based on the above data, which movie from which Genre had the longest runtime?

library(tidyverse)

longest <- movies_df %>%  
  arrange(desc(Runtime))
head(longest)

ggplot(movies_df, aes(x=Runtime, y=Rating)) +
  geom_point(aes(size=Votes, col = Genre))

#Question 2: Based on the above data, in the Runtime of 130-160 mins, which genre has the highest votes?
# List the highest votes per genre
highest_votes <- movies_df %>% 
  filter(Runtime >= 130 & Runtime <= 160) %>% 
  group_by(Genre) %>% 
  summarize(total_votes = sum(Votes)) %>% 
  arrange(desc(total_votes))
highest_votes

ggplot(movies_df, aes(x=Runtime, y=Gross_Earning_in_Mil))+
  geom_point(aes(size=Rating, col= Genre))
  