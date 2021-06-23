
The attatched file "run_analysis.R" prepares and downloads the data contained in the UCI HAR Dataset and then performs the five steps the assignment requires.
 1. Download Data: Download data from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" and unzip data from "getdata_projectfiles_UCI HAR Dataset.zip"
 
 2. Assign data to variables:
features <- features.txt 
activities <- activity_labels.txt 
subject_test <- test/subject_test.txt 
x_test <- test/X_test.txt 
y_test <- test/y_test.txt 
subject_train <- test/subject_train.txt 
x_train <- test/X_train.txt 
y_train <- test/y_train.txt 

 3. Merge datasets test and train:
rbind() xtest and xtrain to create Xset
rbind() ytest and ytrain to create Yset
rbind() subjecttest and subjecttrain to create Subject
cbind() Subject, Yset, and Xset to create MergedData
 
 4. Extract onlt mean and standard deviation
subset MergedData, using columns 'subject', 'code', 'mean', and 'std'
 
 5. Enter names from 'activitylabels' in TidyData to replace numbers in 'code' column
 
 6. Fix all messy labels:
 
Acc in column’s name replaced with Accelerometer
Gyro in column’s name replaced with Gyroscope
BodyBody in column’s name replaced with Body
Mag in column’s name replaced with Magnitude
All that start with character f in column’s name replaced with Frequency
All that start with character t in column’s name replaced with Time

 7. Create new tidy dataset:
FinalDataset and "FinalDataset.txt" are created by taking the means of every variable grouped activity and subject
 
 


