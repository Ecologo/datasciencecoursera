complete <- function(directory = "./specdata/", id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  allFiles <- list.files(path = directory, pattern = ".csv", full.names = TRUE)
  nobs <- numeric()
  data <- data.frame()
  for (i in id) {
    data <- read.csv(allFiles[i])
    nobs <- c(nobs, sum(complete.cases(data)))
  }
  data.frame(id, nobs)
}