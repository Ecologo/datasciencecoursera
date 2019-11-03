if(!file.exists("Quiz3")) {
  dir.create("Quiz3")
}

if (!file.exists("./Quiz3/2006microdata.csv")) {
  download.file(
    "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
    destfile = "./Quiz3/2006microdata.csv"
  )
}

# Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of
# agriculture products. Assign that logical vector to the variable agricultureLogical. Apply the which() function like
# this to identify the rows of the data frame where the logical vector is TRUE.
#
# which(agricultureLogical)

housing <- read_csv("./Quiz3/2006microdata.csv", col_names = TRUE)
agricultureLogical <- c(housing$ACR == 3 & housing$AGS == 6)
quiz1 <- which(agricultureLogical) %>%
  print

library(jpeg)

if (!file.exists("./Quiz3/jeff")) {
  download.file(
    "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg",
    destfile = "./Quiz3/jeff",
    mode = "wb"
  )
}

jpg <- readJPEG("./Quiz3/jeff", native = TRUE)
quiz2 <- quantile(jpg, probs = c(0.3, 0.8))

if (!file.exists("./Quiz3/gdpRank.csv")) {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
                destfile = "./Quiz3/gdpRank.csv")
}

if (!file.exists("./Quiz3/edStats.csv")) {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",
                destfile = "./Quiz3/edStats.csv")
}

gdpRank <- read_csv("./Quiz3/gdpRank.csv",skip = 5,col_names = FALSE)
edStats <- read_csv("./Quiz3/edStats.csv")

gdpRank <- rename(gdpRank, CountryCode = X1,ranking = X2, skip = X3, "Long Name" = X4,gdp_usd = X5)
gdpRank <- select(gdpRank,CountryCode, ranking, "Long Name", gdp_usd)
gdpRank <- mutate(gdpRank, ranking = as.numeric(ranking), gdp_usd = as.numeric(gsub(",","",gdpRank$gdp_usd)))
join <- inner_join(gdpRank,edStats,"CountryCode")
join <- arrange(join, desc(as.integer(join$ranking)))
quiz3 <- join[13,4]
joinIncomeGroup <- group_by(join,join$`Income Group`)
quiz4 <- summarise(joinIncomeGroup, mean(gdp_usd, na.rm = TRUE))

join <- mutate(join, quantile = ntile(join$ranking,5))
table(join$quantile,join$`Income Group`)

joinQgroup <- group_by(join,quantile)
summarise(joinQgroup,n())
