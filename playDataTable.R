library(data.table)

DT <- data.table(A = c(1:6), B = c('a', 'b', 'c'), C = TRUE, D = dnorm(1))
head(DT)

DT[A > 2, sum(D), B]

DT_Iris <- data.table(iris)
head(DT_Iris)

iris[1:3]
iris[1:3,]
DT_Iris[1:3]
