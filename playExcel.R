setwd("~/Downloads/")

library(gdata)
try <- read.xls("~/Downloads/10001信用卡發卡機構重要業務及財務資訊-揭露.xls", sheet = 1)
head(try)
head(try$信用卡重要業務及財務資訊.資訊揭露.)
str(try)

try2 <- read.xls("~/Downloads/10401信用卡重要資訊揭露.xlsx", sheet = 1)
head(try2$信用卡重要業務及財務資訊.資訊揭露.)

# install.packages("XLConnect")
library(XLConnect)
try4 <- loadWorkbook("~/Downloads/10401信用卡重要資訊揭露.xlsx")
head(try4)
str(try4)
try4_2 <- readWorksheet(try4, sheet = 1, header = TRUE)
head(try4_2)
str(try4_2)
try4_3 <- as.data.table(try4_2)
try4_3$Col3

pkgs <- c("irlba", "LiblineaR", "SparseM", "xgboost")
pkgs <- c("pipeR", "rlist")
# install.packages(pkgs)
devtools::install_github("renkun-ken/formattable")

library(data.table)
library(irlba)
library(LiblineaR)
library(SparseM)
library(xgboost)

library(pipeR)
library(rlist)
library(formattable)

df <- data.frame(
  id = 1:10,
  name = c("Bob", "Ashley", "James", "David", "Jenny", 
           "Hans", "Leo", "John", "Emily", "Lee"), 
  age = c(28, 27, 30, 28, 29, 29, 27, 27, 31, 30),
  grade = c("C", "A", "A", "C", "B", "B", "B", "A", "C", "C"),
  test1_score = c(8.9, 9.5, 9.6, 8.9, 9.1, 9.3, 9.3, 9.9, 8.5, 8.6),
  test2_score = c(9.1, 9.1, 9.2, 9.1, 8.9, 8.5, 9.2, 9.3, 9.1, 8.8),
  final_score = c(9, 9.3, 9.4, 9, 9, 8.9, 9.25, 9.6, 8.8, 8.7),
  registered = c(TRUE, FALSE, TRUE, FALSE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE),
  stringsAsFactors = FALSE)

formattable(df, list(
  age = color_tile("white", "orange"),
  grade = formatter("span",
                    style = x ~ ifelse(x == "A", style(color = "green", font.weight = "bold"), NA)),
  test1_score = color_bar("pink", 0.2),
  test2_score = color_bar("pink", 0.2),
  final_score = formatter("span",
                          style = x ~ style(color = ifelse(rank(-x) <= 3, "green", "gray")),
                          x ~ sprintf("%.2f (rank: %02d)", x, rank(-x))),
  registered = formatter("span", 
                         style = x ~ style(color = ifelse(x, "green", "red")),
                         x ~ icontext(ifelse(x, "ok", "remove"), ifelse(x, "Yes", "No")))
))

library(rlist)
devs <- 
  list(
    p1=list(name="Ken",age=24,
            interest=c("reading","music","movies"),
            lang=list(r=2,csharp=4)),
    p2=list(name="James",age=25,
            interest=c("sports","music"),
            lang=list(r=3,java=2,cpp=5)),
    p3=list(name="Penny",age=24,
            interest=c("movies","reading"),
            lang=list(r=1,cpp=4,python=2)))

str( list.filter(devs, "music" %in% interest & lang$r >= 3) )

str( list.select(devs, name, age) )

str( list.map(devs, length(interest)) )

nums <- list(a=c(1,2,3),b=c(2,3,4),c=c(3,4,5))
list.map(nums, c(min=min(.),max=max(.)))
list.filter(nums, x ~ mean(x)>=3)
list.map(nums, f(x,i) ~ sum(x,i))

library(pipeR)
devs %>>% 
  list.filter("music" %in% interest & "r" %in% names(lang)) %>>%
  list.select(name,age) %>>%
  list.stack

# install.packages("xlsx")
library(xlsx)
try3 <- read.xlsx2("~/Downloads/10001信用卡發卡機構重要業務及財務資訊-揭露.xls", sheetIndex = 1)
head(try3)
try3$信用卡重要業務及財務資訊.資訊揭露.

library(stringr)
library(rvest)
?data.table::fread

# install.packages("readxl")
library(readxl)
try6 <- read_excel("~/Downloads/10401信用卡重要資訊揭露.xlsx")
head(try6)
str(try6)
try6_1 <- as.data.frame(try6)

try6_2 <- as.data.table(try6)
try6_2[[3]]


library("rvest")
url <- "http://en.wikipedia.org/wiki/List_of_U.S._states_and_territories_by_population"
population <- url %>%
  html() %>%
  html_nodes(xpath='//*[@id="mw-content-text"]/table[1]') %>%
  html_table()
population <- population[[1]]

head(population)
