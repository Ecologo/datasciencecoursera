rankall <- function(outcome, num = "best") {
  ## Read outcome data
  careMeasure <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  dataCM <- as.data.frame(cbind(careMeasure[,2], #hospital
                                careMeasure[,7], #state
                                careMeasure[,11], #heart attack
                                careMeasure[,17], #heart failure
                                careMeasure[,23]), #pneumonia
                                stringsAsFactors = FALSE)
  
  colnames(dataCM) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")
  
  states <- unique(dataCM[,2])
  states <- states[order(states)]
  
  hospitals <- vector(mode = "character")
  
  ## Check that state and outcome are valid
  if(!outcome %in% c("heart attack", "heart failure", "pneumonia")){
    stop('invalid outcome')
  }
  
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  
  if(num == "best") num <- 1

  
  for(i in seq_along(states)) {
    rank <- num
    stateWhich <- which(dataCM[,"state"] == states[i])
    stateCM <- dataCM[stateWhich,]
    orderHospitals <- order(as.numeric(stateCM[,outcome]), stateCM[,"hospital"])
    rankedHospitals <- stateCM[orderHospitals,]
    
    whichOutcome <- which(stateCM[,outcome] != "Not Available") ## Find "Not Available" values
    outcomeCM <- stateCM[whichOutcome,] ## Remove "Not Available" values
    
    
    if(num == "worst") rank <- nrow(outcomeCM)  
    
    hospitals[i] <- rankedHospitals[rank, 1]
  }
  
  data.frame(hospitals,states,row.names = states)
  
}
