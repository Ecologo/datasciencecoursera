if(!dir.exists("./CourseProject/")) {
  dir.create("./CourseProject/")
}

if (!file.exists("./CourseProject/GalaxyAccel.zip")) {
  download.file(
    "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
    destfile = "./CourseProject/GalaxyAccel.zip"
  )
  
}

unzip("./CourseProject/GalaxyAccel.zip", overwrite = FALSE, exdir = "./CourseProject/")

varNames <- read_delim("./CourseProject/UCI HAR Dataset/features.txt"," ",col_names = FALSE)
varNames <- pull(varNames, 2)
varNames <- c("activity","activityLabel","subject",varNames)

activityLabels <- read.table("./CourseProject/UCI HAR Dataset/activity_labels.txt")
subject_train <- read.table("./CourseProject/UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./CourseProject/UCI HAR Dataset/test/subject_test.txt")

x_train <- read.table("./CourseProject/UCI HAR Dataset/train/X_train.txt")
x_train <- bind_cols(subject_train,x_train)

y_train <- read.table("./CourseProject/UCI HAR Dataset/train/y_train.txt")

jtrain <- bind_cols(y_train,x_train)
jtrain <- left_join(activityLabels,jtrain,"V1")
colnames(jtrain) <- varNames

x_test <- read.table("./CourseProject/UCI HAR Dataset/test/X_test.txt")
x_test <- bind_cols(subject_test,x_test)

y_test <- read.table("./CourseProject/UCI HAR Dataset/test/y_test.txt")

jtest <- bind_cols(y_test,x_test)
jtest <- left_join(activityLabels,jtest,"V1")
colnames(jtest) <- varNames

merged <- rbind(jtrain,jtest)

onlyMeanStd <- grep("mean|std", colnames(merged))

mergedMeanStd <- merged[,c(2:3,onlyMeanStd)]

groupedTable <- group_by(mergedMeanStd,activityLabel)

summarisedData <- summarise_at(groupedTable,c(3:80),mean)

