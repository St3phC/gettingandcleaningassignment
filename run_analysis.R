## prep data first, download, label, format
# load appropriate package
library(dplyr)
filename <- "getdata_projectfiles_UCI HAR Dataset.zip"


if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

# check for the folder
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

feature <- read.table("UCI HAR Dataset/features.txt", col.names = c("n", "functions"))
activitylabel <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subjecttest <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
xtest <- read.table("UCI HAR Dataset/test/x_test.txt", col.names = feature$functions)
ytest <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subjecttrain <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
xtrain <- read.table("UCI HAR Dataset/train/x_train.txt", col.names = feature$functions)
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

## 1. merge test and train, then do analysis

Xset <- rbind(xtrain, xtest)
Yset <- rbind(ytrain, ytest)
Subject <- rbind(subjecttrain, subjecttest)
MergedData <- cbind(Subject, Yset, Xset)

##2. extract mean and standard deviation

TidyData <- MergedData %>% select(subject, code, contains("mean"), contains ("std"))

TidyData$code <- activitylabel[TidyData$code, 2]

names(TidyData)[2] = "activity"

## list out names
names(TidyData) 

##3/4. give better names

names(TidyData) <- gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData) <- gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData) <- gsub("BodyBody", "Body", names(TidyData))
names(TidyData) <- gsub("Mag", "Magnitude", names(TidyData))
names(TidyData) <- gsub("^t", "Time", names(TidyData))
names(TidyData) <- gsub("^f", "Frequency", names(TidyData))
names(TidyData) <- gsub("tBody", "TimeBody", names(TidyData))
names(TidyData) <- gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData) <- gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData) <- gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData) <- gsub("angle", "Angle", names(TidyData))
names(TidyData) <- gsub("gravity", "Gravity", names(TidyData))

## 5. new file for the tidy version of data

FinalDataset <- TidyData %>%
  group_by(subject, activity) %>%
  summarise_all(list(mean))
write.table(FinalDataset, "FinalDataset.txt", row.names = FALSE)

##check

str(FinalDataset)
