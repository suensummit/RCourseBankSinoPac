grep("^R(Studio)?$", c("R","RStudio","Studio","R!", "abcR","RS","RStu","RStudioStudio"), value = TRUE)

## install packages
packages_w1 <- c("rvest","stringr","selectr","quantmod","devtools","rjson","jsonlite","rlist","magrittr","pipeR")
install.packages(packages_w1)
## load package
library(magrittr)
library(rvest)
library(httr)
library(devtools)
## load all
sapply(packages_w1,library,character.only=TRUE)

## View Data
head(iris)

tail(iris)

# View(iris)
summary(iris)

## explor object
attributes(iris)

str(iris)

class(iris)

## data shape
dim(iris)

ncol(iris)

nrow(iris)

# install.packages("quantmod")
library(quantmod)

# quantmod::getSymbols 
getSymbols("2330.TW")
## What's wrong? ##
View(2330.TW)
View(getSymbols("2330.TW"))
TW_2330 <- getSymbols("2330.TW")

# get("2330.TW")

head(TW_2330)
tail(TW_2330)
View(TW_2330)
summary(TW_2330)

dim(TW_2330)
ncol(TW_2330)
nrow(TW_2330)

a <- 1:4
assign("a[1]", 2)
a[1] == 2          # FALSE
get("a[1]") == 2   # TRUE

head(ls())

getwd()

# setwd("~/works/RCrawler/RCrawlerCrashCourse")

# quantmod::
# quantmod:::

source("install_packages.r")
packages_w2

RCourseDate <- c("2015-12-18","2016-01-04","2016-01-13","2016-01-29")
Today <- Sys.Date()
ifelse(Today %in% RCourseDate,"開薰學R語言","今日打東東")

NormalSampleData <- function(N,mu){rnorm(N)+ mu}
system.time(for(i in 1:1e5) NormalSampleData(100,0))

system.time(for(i in 1:1e5) do.call(NormalSampleData, list(100,0)))

## Syntax 1
httr::POST(URL, body= list(para1=paraVal1,para2=paraVal2))
## Syntax 2
httr::POST(URL, body= "para1=paraVal1_encode&para2=paraVal2_encode")
## Syntax 3
httr::POST(URL, body= "para1=paraVal1_encode&para2=paraVal2_encode", encode="form")

library(httr)
library(rvest)
library(stringr)

## Connector
Target_URL = "http://tw.stock.yahoo.com/d/s/major_2451.html"
res <- GET(Target_URL)
doc_str <- content(res, type = "text", encoding = "big5")

## Parser
data_table <- doc_str %>% read_html(encoding = "utf8") %>% html_nodes(xpath = "//table[1]//table[2]") %>% html_table(header=TRUE)

# View(data_table[[1]])

library(httr)
library(rvest)
## Connector
res <- POST("http://mops.twse.com.tw/mops/web/ajax_t51sb01",body = "encodeURIComponent=1&step=1&firstin=1&TYPEK=sii&code=")
doc_str <- content(res, "text", encoding = "utf8")
write(doc_str, file = "mops.html")
## Parser
data_table <- doc_str %>% read_html(encoding = "utf8") %>% html_nodes(xpath = "//table[2]") %>% html_table(header=TRUE)

# View(data_table)

library(rvest)
library(httr)
bankingUrl <- "http://www.banking.gov.tw/ch/home.jsp?id=192&parentpath=0,4&mcustomize=multimessage_view.jsp&dataserno=21207&aplistdn=ou=disclosure,ou=multisite,ou=chinese,ou=ap_root,o=fsc,c=tw&toolsflag=Y&dtable=Disclosure"

res <- GET(bankingUrl,set_cookies("cookiesession1=0F51E397POLJ4NQTC2CT7TGE8VBT033D; JSESSIONID=13A259B7048E0A96163333DA9D9BE428; fontsize=80%; _ga=GA1.3.807240144.1448956489; _gat=1"))
doc_str <- content(res, type = "text", encoding = "utf8")

# parser with URL
doc <- htmlParse(doc_str)
library(rvest)
html <- read_html(doc_str)
monthsUrl <- html_nodes(html,"table[summary='信用卡重要業務及財務資訊揭露'] a[href]")
# get value 
html_text(monthsUrl)
html_attr(monthsUrl, name = "href")
# pipe to url
monthsUrlList <- content(res, type = "text", encoding = "utf8") %>% read_html %>% html_nodes("table[summary='信用卡重要業務及財務資訊揭露'] a") %>% html_attr("href")
monthsUrlList <- ifelse(substr(monthsUrlList,1,1)=='/',paste0("http://www.fsc.gov.tw",monthsUrlList),monthsUrlList)

# library(stringr)
dataDir <- "~/Documents/BankSinoPac/data/bankingCreditCard/"
fileName <- paste0(dataDir,fileName <- sub("&flag=doc$","",sub(".*file=/", "", monthsUrlList)))
# download.file(monthsUrlList, destfile = paste0("/home/gg/data/bankingCreditCard/",fileName <- sub("&flag=doc$","",sub(".*file=/", "", monthsUrlList[1:2]))), mode="wb")
system.time(
  for (i in 1:length(fileName)){
    print(monthsUrlList[i])
    try(download.file(url = monthsUrlList[i], destfile = fileName[i], mode = "w"), silent = TRUE)
  }
)
sum((fileName %>% file.info)$size)

# downUrl <- "http://www.fsc.gov.tw/fckdowndoc?file=/10401%E4%BF%A1%E7%94%A8%E5%8D%A1%E9%87%8D%E8%A6%81%E8%B3%87%E8%A8%8A%E6%8F%AD%E9%9C%B2.xlsx&amp;flag=doc"
# res <- GET(downUrl, set_cookies("cookiesession1=0F51E398BEEWSI59SDWDYRPYSQEYAAD7;Path=/;HttpOnly"))
# resp <- content(res, as = "parsed", encoding = "utf8")


# URLdecode("")
# URLdecode(myUrl)

res <- POST("http://mops.twse.com.tw/mops/web/ajax_t51sb01",body = "encodeURIComponent=1&step=1&firstin=1&TYPEK=sii&code=")
doc_str <- content(res, "text", encoding = "utf8")
data_table <- doc_str %>% 
  read_html() %>% 
  html_nodes(xpath = "//table[2]") %>% 
  html_table(header=FALSE)

head(try3)
try3dt <- as.data.table(try3)
try3dt[]


library(httr)
library(jsonlite)

FM_TW_STORE <- data.frame()
addr_tw <- c("基隆市")#,"台北市","新北市","桃園市","新竹市","新竹縣","苗栗縣","台中市","彰化縣","南投縣","雲林縣","嘉義市","嘉義縣","台南市","高雄市","屏東縣","宜蘭縣","花蓮縣","台東縣","澎湖縣","金門縣")
for(a in 1:length(addr_tw))
{
  addr <- addr_tw[a]#URLencode(addr_tw[a])
  FM_URL = paste0("http://api.map.com.tw/net/familyShop.aspx?searchType=ShopList&type=&city=",addr,"&area=&road=&fun=showStoreList&key=6F30E8BF706D653965BDE302661D1241F8BE9EBC", collapse = "")
  
  FM_store <- GET(FM_URL, config = set_cookies('ServerName'='www%2Efamily%2Ecom%2Etw;',
                                               "ASPSESSIONIDSQDBRTSD"="PLBKNCAGIGAKILIPJALCPKK;",
                                               "ASP.NET_SessionId"="nnhplttz2ofmvfypfbsuyo0f"),
                  add_headers("Referer" = "http://www.family.com.tw/marketing/inquiry.aspx"))
  
  FM_store_list <- content(FM_store, type="text", encoding = "utf8")
  jsonDataString = sub("[^\\]]*$","",sub("^[^\\[]*","",FM_store_list))
  jsonData = fromJSON(jsonDataString)
  jsonData$city = addr_tw[a]
  FM_TW_STORE <- rbind(FM_TW_STORE, jsonData)
  #t <- runif(1, 1.1, 5.5)
  #Sys.sleep(t)
}

# print(Sys.time()-strt)
