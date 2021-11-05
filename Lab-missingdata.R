data <-c(0.2,3.3,4.5,NA, 6.1,2.4)
class(data)
is.na(data) ##missing value identification                   
id1<-which(is.na(data) == TRUE) ##missing value id identification                    
id1


mean(data)
mean(data, na.rm=TRUE) #without remove missing value

#############dataFrame###########

id<-c(1,2,3,4,5)
gender<-c("m","f",NA,"f","m")
measure<-c(0.2,3.3,4.5,NA,6.1)


data1<-data.frame(id,gender,measure)
data1

na.fail(data1)
na.omit(data1) #delete missing value
complete.data<-data1[complete.cases(data1),]
complete.data


?na.omit
?complete.cases

na.fail(complete.data)
is.na(complete.data)


id2 <- unique(unlist(lapply(data1, function (x) which (is.na(x)))))
id2

###is.na used for vector
###unique used for data frame or matrix

?unique
?unlist

m<-matrix(1:6,2,3)
m
apply(m,2, mean)

which(is.na(data1))

data1

?na.action

model1 <- lm(id~measure,data=data1, na.action = na.omit)
model1
model2 <- lm(id~measure,data = data1,na.action = na.exclude)
model2

model1$coefficients
model2$coefficients

resid(model1)
resid(model2)

summary(model1)
summary(model2)

data1

#########packages####
#install.packages("gam", dependencies = T)
library(foreach)
library(gam)
new.data <- na.gam.replace(data1)

new.data
data1
mean(data1$measure,na.rm = TRUE)
na.fail(new.data)

ndata<-data1[,-2]
na.gam.replace(ndata)
#install.packages("tree")
library(tree)
new.data
mean(data1$measure)
mean(data1$measure,na.rm = TRUE)##Used for big data
mean(data1$measure[-4])
