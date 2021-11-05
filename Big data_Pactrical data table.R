library(data.table)
?as.data.table

data <- as.data.table(iris)
data

dim(data)
data$Sepal.Length
iris
head(iris)
data
is.data.table(data)

data[Sepal.Length>=4,mean(Sepal.Width),by=Species]

####large file with DT library

library(DT)

?DT
datatable(iris)
datatable(head(iris),class = "cell-border strip")

datatable(head(iris),editable = "cell")

#####
datatable(head(iris), editable = list(target='row',disable= list(colSums = c(1, 3, 4))))

          
 ###Catagorical data analysis
 
library(janitor)

library(ggplot2)
?geom_density()
?theme_minimal()

#install.packages("quanteda")
library("quanteda")
##################short example
m<-matrix(letters[1:4],2,2)
tokens(m)
toks<-tokens(c("This is a sentence.", "This is a second sentence."))
tokens_tolower(toks)
tokens_toupper(toks)

tokens_select(toks, c("is", "a", "this"), selection = "keep", padding = FALSE)
tokens_remove(toks, "is", window = c(0, 1))

##############making corpus
data<-data_char_ukimmig2010
write.table(data,"data.txt")
corp_uk<-corpus(data) # build a new corpus from the texts
ss<-summary(corp_uk)
dfm(corp_uk)
docvars(corp_uk, "Party") <-names(data_char_ukimmig2010)
docvars(corp_uk, "Year") <-2010
summary(corp_uk)
