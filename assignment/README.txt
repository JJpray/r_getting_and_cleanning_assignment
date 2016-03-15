Author: Tianyuan Liu
Version: 1.0
__________________________________________________________________
The repo contains the following files:
1) run_analysis.R script
2) README.txt file
3) tidydata.txt dataset
4) Codebook
__________________________________________________________________

The purpose of the project is to getting and clean the raw dataset from "Human Activity Recognition Using Smartphones Dataset Version 1.0”. The data in the "Human Activity Recognition Using Smartphones Dataset Version 1.0" have been taken from experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz data were captured. The experiments were video-recorded to label the data manually. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.
__________________________________________________________________
The tasks include:

1) Get the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2)Create one R script called run_analysis.R that does the following.

3) Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.

4)Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.

5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
__________________________________________________________________
A brief description of the script:
The run_analysis.R script merges data from a number of .txt files and produces a tidy data set which may be used for further analysis.

2)First it checks to see if the required "reshape2" has been installed and then loads the "reshape2" package.

2)It then reads all required .txt files and labels the datasets

3)Consquently the appropriate "activity_id"'s and "subject_id"'s are appended to the "test" and the "training" data, which are then combined into one single data frame

4)Using the "grep" function, all the columns with mean() and std() values are extracted and then a new data frame, including only the "activity_id", the "subject_id" and the mean() and std() columns, is created

5)Using the "merge" function, descriptive activity names are merged with the mean/std values dataset, to get one dataset with descriptive activity names

6)Lastly, with the help of the "melt" and "dcast" functions of the "reshape2" package, the data is converted into a table containing mean values of all the included features, ordered by the activity name and the subject id, and the data is written to the "tidy_movement_data.txt" file.

A description of the "tidy_movement_data.txt" file may be found in the "CodeBook.md" file.

