## run_analysis.R
##
## 1. Merges the training and test sets to create one data set.  These
##      data sets should be in folders called "train" and "test",
##      respectively.  There should also be a file called
##      "activity_labels.txt" in the top level directory.
## 2. Extracts only the measurements on the mean and standard deviation
##      for each measurement.
## 3. Uses descriptive activity names to name the activites in the data
##      set.
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of
##      each variable for each activity and subject.

library(data.table)

## mergeDataSets merges the training
mergeDataSets <- function(dir_name = ".") {
  train_dir <- paste(dir_name,"train",sep="/")
  test_dir <- paste(dir_name,"test",sep="/")
  
  # Read data
  X_train_dataset <- read.table(paste(train_dir,"X_train.txt",sep="/"))
  X_test_dataset <- read.table(paste(test_dir,"X_test.txt",sep="/"))
  
  # Read subject data
  subject_train_dataset <- read.table(paste(train_dir,
                                            "subject_train.txt",sep="/"))
  subject_test_dataset <- read.table(paste(test_dir,
                                           "subject_test.txt",sep="/"))
  
  # Read activity labels
  y_train_dataset <- read.table(paste(train_dir,"y_train.txt",sep="/"))
  y_test_dataset <- read.table(paste(test_dir,"y_test.txt",sep="/"))
  
  # Get actual names of the features and apply to datasets
  features <- read.table(paste(dir_name,"features.txt",sep="/"))
  names(X_train_dataset) <- features$V2
  names(X_test_dataset) <- features$V2
  
  # Give column names to "subject" and "y" datasets
  names(y_train_dataset) <- "Activity-ID"
  names(y_test_dataset) <- "Activity-ID"
  names(subject_train_dataset) <- "Subject-ID"
  names(subject_test_dataset) <- "Subject-ID"
  
  # We just want the "mean" and "std" columns
  X_train_dataset <- X_train_dataset[,grep("-mean\\(\\)|-std\\(\\)",
                                           features$V2)]
  X_test_dataset <- X_test_dataset[,grep("-mean\\(\\)|-std\\(\\)",
                                           features$V2)]
  
  # First get full data for both train and test
  full_train_data <- cbind(X_train_dataset, y_train_dataset,
                           subject_train_dataset)
  full_test_data <- cbind(X_test_dataset, y_test_dataset,
                           subject_test_dataset)
  
  # Get human-readable activity names and add to the datasets
  activity_names <- read.table(paste(dir_name,"activity_labels.txt",sep="/"))
  names(activity_names) <- c("Activity-ID","Activity-Name")
  full_train_data <- merge(full_train_data, activity_names)
  full_test_data <- merge(full_test_data, activity_names)
  
  # Combine the data into one giant dataset
  full_data <- rbind(full_train_data, full_test_data)
  # Drop "Activity-ID" column as it is redundant with "Activity-Name"
  full_data[,!"Activity-ID"]
}


writeDataSetWithAverages <- function(dir_name = ".") {
  data <- mergeDataSets(dir_name)
  data.t <- data.table(data)
  
  tidy.data.t <- data.t[,lapply(.SD,mean), by="Activity-Name,Subject-ID"]
  write.table(tidy.data.t,paste(dir_name,"tidy_data.txt",sep="/"))
}