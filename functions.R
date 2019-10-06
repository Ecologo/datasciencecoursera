pollutantmean <- function(directory, pollutant, id = 1:332){
  allFiles <- list.files(path = "./specdata", full.names = TRUE)
  selectedData <- data.frame()
  for (i in id) {
    selectedData <- rbind(read.csv(allFiles[i]))
  }
  if(pollutant == "sulfate"){
    mean(selectData$sulfate, na.rm = TRUE)
  } else if(pollutant == "nitrate"){
    mean(selectData$nitrate, na.rm = TRUE)
  }
}

complete <- function(directory, id = 1:332) {

}