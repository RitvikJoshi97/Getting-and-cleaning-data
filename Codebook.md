Libraries Required:
  reshape2, dplyr, and data.table

CodeBook Description:
  Source data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  
  Description of the dataset from the source website: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
  
The dataset includes the following files:
  'README.txt'

  'features_info.txt': Shows information about the variables used on the feature vector.
  
  'features.txt': List of all features.
  
  'activity_labels.txt': Links the class labels with their activity name.
  
  'train/X_train.txt': Training set.
  
  'train/y_train.txt': Training labels.
  
  'test/X_test.txt': Test set.
  
  'test/y_test.txt': Test labels.  

The code does:
  Merges the training and the test sets to create one data set. Source code "run_analysis.R" loads both test and train data, processes them, and merges the results into one dataset.

  Extracts only the measurements on the mean and standard deviation for each measurement. Source code "run_analysis.R" extracts the mean and standard deviation data into one dataset with appropriate column names.

  Uses descriptive activity names to name the activities in the data set. Source code "run_analysis.R" loads the descriptive feature and activity labels.

  Appropriately labels the data set with descriptive variable names Source code "run_analysis.R" adds appropriately descriptive variable names to the large dataset columns (variables).

  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject Source code "run_analysis.R" calculates the average for all measurement columns grouped by variables Activity and Subject and then writes the output to a local text file named "tidydata.txt""
  
  