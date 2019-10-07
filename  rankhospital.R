rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  careMeasure <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  dataCM <- as.data.frame(cbind(careMeasure[,2], #hospital
                                careMeasure[,7], #state
                                careMeasure[,11], #heart attack
                                careMeasure[,17], #heart failure
                                careMeasure[,23]), #pneumonia
                                stringsAsFactors = FALSE)
  
  colnames(dataCM) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")
  ## Check that state and outcome are valid
  if(!state %in% dataCM[,"state"]){
    stop('invalid state')
  } else if(!outcome %in% c("heart attack", "heart failure", "pneumonia")){
    stop('invalid outcome')
  }
  
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  
  whichState <- which(dataCM[,"state"] == state) ## Which gives us the number of the lines that are of the correct state
  stateCM <- dataCM[whichState,] ## State CM now only contain registers of the correct state
  
  whichOutcome <- which(stateCM[,outcome] != "Not Available") ## Find "Not Available" values
  outcomeCM <- stateCM[whichOutcome,] ## Remove "Not Available" values
  
  orderHospitals <- order(as.numeric(outcomeCM[,outcome]),outcomeCM[,"hospital"])
  rankedHospitals <- outcomeCM[orderHospitals,]
  
  if(num == "best") num <- 1
  
  if(num == "worst") num <- nrow(rankedHospitals)
  
  selectedHospital <- rankedHospitals[num, 1]
  selectedHospital
  
}
