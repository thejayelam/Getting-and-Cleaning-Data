The run_analysis.R script prepare and download the data and then follows the steps as described

1. Dataset is Downloaded and extracted under the folder called UCI HAR Dataset

2. Assigns each data to variables 
        features <- features.txt (from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and            tGyro-XYZ.)
        activities <- activity_labels.txt (List of activities performed when the corresponding measurements         were taken and its labels)
        subject_test <- test/subject_test.txt (test data of 9/30 volunteer test subjects)
        x_test <- test/X_test.txt (features test data)
        y_test <- test/y_test.txt (test data of activities'ID labels)
        subject_train <- test/subject_train (train data of 21/30 volunteer subjects)
        x_train <- test/X_train.txt (features train data)
        y_train <- test/y_train.txt (train data of activities’ID labels)

3. Merges the traing and test sets using rbind() and cbind() to create one dataset

4. From the new dataset extracts only the mean and standard devaition for each measurement 

5. Descriptive activity names to name the activities in dataset and Replace the labels with descriptive names and correct the typos

6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject 
        TidyData is created 

