#loading library required 
library(dplyr)

#
#Step 1: Merging data files to make a single data set 
#
features <- read.table("./UCI HAR Dataset/features.txt",header=FALSE)
#Select the feature names 
features <- features[2]
#transform column to row 
features <- t(features)
colnames(features)=features[1,]
#getting the required column names 
cols <- features[1,c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,345:350,424:429,503:504,516:517,529:530,542:543)] 

#appending the training data sets - X, y for activity and subject 
train <- read.table("./UCI HAR Dataset/train/X_train.txt")
train <- cbind(train,read.table("./UCI HAR Dataset/train/y_train.txt"))
train <- cbind(train,read.table("./UCI HAR Dataset/train/subject_train.txt"))

#appending the test data sets - X, y for activity and subject 
test <- read.table("./UCI HAR Dataset/test/X_test.txt")
test <- cbind(test,read.table("./UCI HAR Dataset/test/y_test.txt"))
test <- cbind(test,read.table("./UCI HAR Dataset/test/subject_test.txt"))

#append test and train data sets 
train_test <- rbind(train,test)

#
#Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
train_test_extract <- train_test[,c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,345:350,424:429,503:504,516:517,529:530,542:543,562:563)]

#set the column names 
colnames(train_test_extract) = c(cols,"activity","subject")

#
#Step 3:- read activity descriptions and 
# set descriptive activity names to name the activities in the data set
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
train_test_extract$activity <- activity[train_test_extract$activity,2]    

#
# Step 4: Appropriately labels the data set with descriptive variable names. 
# remove characters that could cause confusion in name such as '-', "()" etc
colnames(train_test_extract) <- gsub("-m","M",colnames(train_test_extract))
colnames(train_test_extract) <- gsub("-s","S",colnames(train_test_extract))
colnames(train_test_extract) <- gsub("\\(\\)","",colnames(train_test_extract))
colnames(train_test_extract) <- gsub("-","",colnames(train_test_extract))
colnames(train_test_extract) <- gsub("BodyBody","Body",colnames(train_test_extract))

#
#Step 5: creates a second, independent tidy data set with the average of each variable 
#for each activity and each subject.
grouped <- group_by(train_test_extract,activity,subject)
output <- summarise_each(grouped,funs(mean))

# Write output data 
write.table(output,file="output.txt",row.name=FALSE)
