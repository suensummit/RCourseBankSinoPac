library(data.table)
DF = data.frame(x=c("b","b","b","a","a"),v=rnorm(5))
DT = data.table(x=c("b","b","b","a","a"),v=rnorm(5))
CARS = data.table(cars)
head(CARS)
tables()
sapply(DT,class)
DT[2,]
DT[x=="b",]
cat(try(DT["b",],silent=TRUE))
setkey(DT,x)
DT
tables()
haskey(DT)
DT["b",]
DT["b"]
DT["b",mult="first"]
DT["b",mult="last"]
DT["b",mult="all"]
grpsize = ceiling(1e7/26^2)
tt=system.time( DF <- data.frame(
  x=rep(LETTERS,each=26*grpsize),
  y=rep(letters,each=grpsize),
  v=runif(grpsize*26^2),
  stringsAsFactors=FALSE)
  )
tt
head(DF,3)
tail(DF,3)
dim(DF)
tt=system.time(ans1 <- DF[DF$x=="R" & DF$y=="h",])
tt
head(ans1,3)
dim(ans1)
DT = as.data.table(DF)
system.time(setkey(DT,x,y))
ss=system.time(ans2 <- DT[list("R","h")])
ss
head(ans2,3)
dim(ans2)
identical(ans1$v, ans2$v)
system.time(ans1 <- DT[x=="R" & y=="h",]) # works but is using data.table badly
system.time(ans2 <- DF[DF$x=="R" & DF$y=="h",])
mapply(identical,ans1,ans2)
identical( DT[list("R","h"),], DT[.("R","h"),])
DT[,sum(v)]
DT[,sum(v),by=x]
ttt=system.time(tt <- tapply(DT$v,DT$x,sum)); ttt
sss=system.time(ss <- DT[,sum(v),by=x]); sss
head(tt)
head(ss)
identical(as.vector(tt), ss$V1)
ttt=system.time(tt <- tapply(DT$v,list(DT$x,DT$y),sum)); ttt
sss=system.time(ss <- DT[,sum(v),by="x,y"]); sss
tt[1:5,1:5]
head(ss)
identical(as.vector(t(tt)), ss$V1)
example(data.table)
