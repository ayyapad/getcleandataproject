# getcleandataproject
Course Project of Getting and Cleaning Data

This project works on Human Activity Recognition Using Smartphones Dataset
Full description of the site where data was obtained:- http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Reference to the data set:- https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This project combines the data from the above data set, extracts only the mean and standard deviation values from the combined data set and calculates averages for each activity and subject. 

Script run_analysis.R 
Assmption:- script runs in a parent directory that contains "UCI HAR Dataset" directory. 

Script does the following
1. extracts the column names from features.txt 
2. Combines the data in train directory: X_train.txt, y_train.txt and subject_train.txt
3. Combines the data in teet directory: X_test.txt, y_test.txt and subject_test.txt
4. Combines the data from steps 2 and 3
5. Extracts only columns that have mean and standard deviation variables 
6. Describes the activity names as mentioned in activity_labels.txt
7. Cleans up the column names by removing '-', '()', duplicated names
8. Groups the data from 7 by Activity and Subject. Calculates averages for all the variables grouped by Activity and Subject. 
9. Generates output extract from step 8. 

Repository includes output from Step 9 and a codebook that describes the output. 


