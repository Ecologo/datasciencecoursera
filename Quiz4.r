if(!file.exists("./Quiz4/microdata.csv")){
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", 
                destfile = "./Quiz4/microdata.csv")}

md2006 <- read.csv("./Quiz4/microdata.csv")

question1 <- strsplit(names(md2006),"wgtp")

if(!file.exists("./Quiz4/gdp.csv")){
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", 
                destfile = "./Quiz4/gdp.csv")}

gdpRank <- read_csv("./Quiz4/gdp.csv",skip = 5,col_names = FALSE)

gdpRank <- rename(gdpRank, CountryCode = X1,ranking = X2, skip = X3, CountryName = X4,gdp_usd = X5)
gdpRank <- select(gdpRank,CountryCode, ranking, CountryName, gdp_usd)
gdpRank <- mutate(gdpRank, ranking = as.numeric(ranking), gdp_usd = as.numeric(gsub(",","",gdpRank$gdp_usd)))
gdpRank <- filter(gdpRank, !is.na(ranking))

question2 <- mean(gdpRank["gdp_usd"])

question3 <- grep("^United",gdpRank$CountryName)

if(!file.exists("./Quiz4/edStats.csv")){
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", 
                destfile = "./Quiz4/edStats.csv")}

edStats <- read_csv("./Quiz4/edStats.csv")

join <- inner_join(gdpRank,edStats,"CountryCode")

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
index2012 <- length(grep("2012",year(sampleTimes)))
wday2012 <- wday(sampleTimes[index2012],label = TRUE)
mon2012 <- grep("Mon",wday2012)
question4 <- length(mon2012)




