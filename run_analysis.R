library(dplyr)


features <- read.table("./UCI HAR Dataset/features.txt",header=FALSE)
features <- features[2]
features <- t(features)
colnames(features)=features[1,]
cols <- features[1,c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,345:350,424:429,503:504,516:517,529:530,542:543)] 

train <- read.table("./UCI HAR Dataset/train/X_train.txt")
train <- cbind(train,read.table("./UCI HAR Dataset/train/y_train.txt"))
train <- cbind(train,read.table("./UCI HAR Dataset/train/subject_train.txt"))

test <- read.table("./UCI HAR Dataset/test/X_test.txt")
test <- cbind(test,read.table("./UCI HAR Dataset/test/y_test.txt"))
test <- cbind(test,read.table("./UCI HAR Dataset/test/subject_test.txt"))

train_test <- rbind(train,test)

train_test_extract <- train_test[,c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,345:350,424:429,503:504,516:517,529:530,542:543,562:563)]

colnames(train_test_extract) = c(cols,"activity","subject")

activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
train_test_extract$activity <- activity[train_test_extract$activity,2]    


colnames(train_test_extract) <- gsub("-m","M",colnames(train_test_extract))
colnames(train_test_extract) <- gsub("-s","S",colnames(train_test_extract))
colnames(train_test_extract) <- gsub("\\(\\)","",colnames(train_test_extract))
colnames(train_test_extract) <- gsub("-","",colnames(train_test_extract))
colnames(train_test_extract) <- gsub("BodyBody","Body",colnames(train_test_extract))

grouped <- group_by(train_test_extract,activity,subject)
output <- summarise_each(grouped,funs(mean))
write.table(output,file="output.txt")
