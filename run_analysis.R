#run_analysis.R
library(data.table)
library(dplyr)
#This will set your working directory
setwd("C:/Users/Ritvik/Documents/Coursera/three")

#This will download UCI data files from the web, unzip them, and specify time/date settings
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destFile <- "CourseDataset.zip"
if (!file.exists(destFile)){
  download.file(URL, destfile = destFile, mode='wb')
}
if (!file.exists("./UCI_HAR_Dataset")){
  unzip(destFile)
}
dateDownloaded <- date()

# This is to set up start reading files
setwd("./UCI HAR Dataset")

#This is for reading Activity files
ActivityTest <- read.table("./test/y_test.txt", header = F)
ActivityTrain <- read.table("./train/y_train.txt", header = F)

#This is to read features files
FeaturesTest <- read.table("./test/X_test.txt", header = F)
FeaturesTrain <- read.table("./train/X_train.txt", header = F)

#This is to read subject files
SubjectTest <- read.table("./test/subject_test.txt", header = F)
SubjectTrain <- read.table("./train/subject_train.txt", header = F)

#This is to read Activity Labels
ActivityLabels <- read.table("./activity_labels.txt", header = F)

#This is to read Feature Names
FeaturesNames <- read.table("./features.txt", header = F)

#This is for merging dataframes: Features Test&Train,Activity Test&Train, Subject Test&Train
FeaturesData <- rbind(FeaturesTest, FeaturesTrain)
SubjectData <- rbind(SubjectTest, SubjectTrain)
ActivityData <- rbind(ActivityTest, ActivityTrain)

#This is for renaming colums in ActivityData & ActivityLabels dataframes
names(ActivityData) <- "ActivityN"
names(ActivityLabels) <- c("ActivityN", "Activity")

#This gets factor of Activity names
Activity <- left_join(ActivityData, ActivityLabels, "ActivityN")[, 2]

#This renames SubjectData columns
names(SubjectData) <- "Subject"
#Rename FeaturesData columns using columns from FeaturesNames
names(FeaturesData) <- FeaturesNames$V2

#This Create one large Dataset with only these variables: SubjectData,  Activity,  FeaturesData
DataSet <- cbind(SubjectData, Activity)
DataSet <- cbind(DataSet, FeaturesData)

#This create New datasets by extracting only the measurements on the mean and standard deviation for each measurement
subFeaturesNames <- FeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", FeaturesNames$V2)]
DataNames <- c("Subject", "Activity", as.character(subFeaturesNames))
DataSet <- subset(DataSet, select=DataNames)

#This rename the columns of the large dataset using more descriptive activity names
names(DataSet)<-gsub("^t", "time", names(DataSet))
names(DataSet)<-gsub("^f", "frequency", names(DataSet))
names(DataSet)<-gsub("Acc", "Accelerometer", names(DataSet))
names(DataSet)<-gsub("Gyro", "Gyroscope", names(DataSet))
names(DataSet)<-gsub("Mag", "Magnitude", names(DataSet))
names(DataSet)<-gsub("BodyBody", "Body", names(DataSet))

# This create a second, independent tidy data set with the average of each variable for each activity and each subject
SecondDataSet<-aggregate(. ~Subject + Activity, DataSet, mean)
SecondDataSet<-SecondDataSet[order(SecondDataSet$Subject,SecondDataSet$Activity),]

#This save this tidy dataset to local file
write.table(SecondDataSet, file = "tidydata.txt",row.name=FALSE)