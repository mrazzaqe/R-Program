##Check permission of web  page  to be  scraped
library(robotstxt)
#read the website
library(xml2)
#Extract data from website

library(rvest)
library(magrittr)

#data cleaning 
library(stringr)


#Specifying the urlfor desired website to be scraped
url <- 'https://dataquestio.github.io/web-scraping-pages/simple.html'

#Reading the HTML code from the website
p<- read_html(url)

paragraphs <- read_html(url) %>% html_nodes("p") %>% html_text()
paragraphs


#What about tables ?
tables <- read_html(url) %>% html_nodes("table") 
tables

