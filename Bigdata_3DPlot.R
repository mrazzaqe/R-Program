library(rgl)
#install.packages("rgl")
head(iris)
x <-iris$Sepal.Length
y<-iris$Petal.Length
z<-iris$Sepal.Width
data<- data.frame(x,y,z)
plot(x,y,z)

plot(x,y)

rgl.open()
rgl.points(x,y,z, color="red")

head(iris)
table(iris$Species)

######
rgl.open()
rgl.points(x,y,z, color=as.integer(iris$Species))
table(as.integer(iris$Species))

###########
######
rgl.open()
rgl.bg(color = "white")
rgl.points(x,y,z, color="blue", size =5)

#########

rgl.open()
rgl.bg(color = "grey")
rgl.points(x,y,z,r=15, color="blue")
rgl.snapshot(filename = "plot1.png") ## Save file

getwd() ##Check directory

#######Spheres
rgl.open()
rgl.bg(color = "white")
###rgl.points(x,y,z,r=15, color="blue")
rgl.spheres(x,y,z,r=.2, color="blue")

####3D Plot moving ###
library(magick)

rgl.open()
rgl.bg(color = "white")
rgl.points(x,y,z,r=1, color="blue")

rgl.bbox(color = "#333377")
aspect3d(1,1,1)
movie3d(spin3d(axis = c(0,0,1)), duration =10, 
        dir = getwd())

