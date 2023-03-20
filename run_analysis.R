#load libraries 
library(dplyr)

#Dowload the dataset
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
datafile <- "UCI HAR Dataset.zip"

if(!file.exists(datafile)){
        download.file(fileURL, datafile, method = "curl")
}

if(!file.exists("UCI HAR Dataset")){
        unzip(datafile)
}

#Read the data and assigning all dataframes

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("ID", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "ID")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "ID")

#Step 1 - merge the data

X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Total_Data <- cbind(Subject, X, Y)

#Step 2 - Extract only the measurements on the mean and standard deviation for each measurement. 

TidyData <- Total_Data %>% select(subject, ID, contains("mean"), contains("std"))

#Step 3 - Use descriptive activity names to name the activities in the data set

TidyData$ID <- activities[TidyData$ID, 2]

#Step 4 - Appropriately label the data set with descriptive variable names.

names(TidyData)[2] = "activity"
names(TidyData) <- gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData) <- gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData) <- gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData) <- gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData) <- gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData) <- gsub("Mag", "Magnitude", names(TidyData))
names(TidyData) <- gsub("^t", "Time", names(TidyData))
names(TidyData) <- gsub("^f", "Frequency", names(TidyData))
names(TidyData) <- gsub("tBody", "TimeBody", names(TidyData))
names(TidyData) <- gsub("angle", "Angle", names(TidyData))
names(TidyData) <- gsub("gravity", "Gravity", names(TidyData))
names(TidyData) <- gsub("BodyBody", "Body", names(TidyData))


#step 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

HumanActivityData <- TidyData %>% 
        group_by(subject, activity) %>%
        summarise_all(funs(mean))
#Output
write.table(HumanActivityData, "TidyData.txt", row.names = FALSE)


