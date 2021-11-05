library(quanteda)

####2X2 matrix

m<-matrix(letters[1:4], 2,2)
m

?tokens

tokens(m)

toks<-tokens(c("This is a sentance", "This is a second sentance"))
toks

tokens_tolower(toks)
tokens_toupper(toks)

?tokens_select
tokens_select(toks,c("is","a"))

tokens_remove(toks,"is")

#####Text Data
data<-data_char_ukimmig2010

?corpus

corp<-corpus(data)# divide into documents
corp

summary(corp)

?dfm
##documents feature matrix
dfm(corp)

?docvars

##docvars

docvars(corp, "Year") <- 2021
summary(corp)
