
library(httr)
library(httpuv)
library(jsonlite)
library(sqldf)
library(XML)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at
#    https://github.com/settings/developers. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url



#93f6121b72ea9130d29c20470b8c878fe6456730  Personal access tokens

userName <- "Ecologo"
theToken <- "93f6121b72ea9130d29c20470b8c878fe6456730" 
aRequest <- GET("https://api.github.com/users/jtleek/repos",authenticate(userName,theToken))
#
# code to parse out the datasharing content goes here
jsonReq <- fromJSON("https://api.github.com/users/jtleek/repos")
dfReq <- as.data.frame(cbind(jsonReq$name,jsonReq$created_at))

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile = "survey.csv")
acs <- read.csv("./survey.csv")
sqldf("select pwgtp1 from acs where AGEP < 50")
sqldf("select distinct AGEP from acs")

url <- "http://biostat.jhsph.edu/~jleek/contact.html"
charPerLine <- nchar(readLines(url))

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for", destfile = "noaaElNino.for")
noaaElNino <- read.fwf("./noaaElNino.for", header = FALSE,skip = 4 ,widths = c(28, 4))
