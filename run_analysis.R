setwd("/Users/tianyuan/mooc_dstb/r/quiz")
library(reshape2)
# downloading the dataset
if(!file.exists("./assignment")) {dir.create("./assignment")}
fileurl <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,destfile="assignment.zip",method="curl")
unzip("./assignment.zip", exdir = "./assignment")
setwd("/Users/tianyuan/mooc_dstb/r/quiz/assignment/UCI HAR Dataset")
dir()
dir("./train")
dir("./test")

# read readme file to learn about the files
# prepare the data for analysis
# get the activity label and save as features

activitylabel <- read.table("activity_labels.txt",col.names=c("activity_id","activity_name"))
str(activitylabel) # data.frame, 6 obs 2 variables
features <- read.table("features.txt")
feature_names <-  features[,2] # 561
str(features) # data.frame, 561 obs 2 variable

# for complete training data, need subject table, activity label table, and training table
# change the column names of the training dataset
# change the column names of the subject and activity label
training <- read.table("./train/X_train.txt")
dim(training)# 7352  561
colnames(training) <- feature_names

traininglabel <- read.table("./train/Y_train.txt")
colnames(traininglabel)<-"activity_id"

trainingsubject <-read.table("./train/subject_train.txt")
colnames(trainingsubject) <- "subject_id"

# for complete test data, need subject table, activity label table, and test table
# change the column names of the test dataset
# change the column names of the subject and activity label
test <- read.table("./test/X_test.txt")
dim(test) # 2947  561
colnames(test) <- feature_names

testlabel <- read.table("./test/Y_test.txt")
colnames(testlabel)<-"activity_id"

testsubject <- read.table("./test/subject_test.txt")
colnames(testsubject) <- "subject_id"

# column binding the test tables
# column binding the training tables
testdata <- cbind(testsubject, testlabel , test)
trainingdata <-cbind(trainingsubject,traininglabel,training)

# merge the two dataset by row binding
alldata <- rbind(trainingdata,testdata)
dim(alldata) # 10299 563

# look for column names containing "mean"
# create a index vector and name vector
mean_col_idx <- grep("mean",names(alldata),ignore.case=TRUE)
mean_col_names <-names(alldata)[mean_col_idx]

# look for column names containing "std"
# create a index vector and name vector
std_col_idx <- grep("std",names(alldata),ignore.case=TRUE)
std_col_names <-names(alldata)[std_col_idx]

# create a new data frame that keeps mean and std related columns the alldata data frame 
mean_std_data <-alldata[,c("subject_id","activity_id",mean_col_names,std_col_names)]

# get the descriptive activity names
descrptivenames <-merge(activitylabel,mean_std_data, by.x = "activity_id",by.y = "activity_id",all=TRUE)

# melt the descriptive activity names
datamelt <- melt(descrptivenames,id=c("activity_id","activity_name","subject_id"))

# create a second, independent tidy data with the average of each variable for each activity and each subject
mean_data <- dcast(datamelt,activity_id + activity_name + subject_id ~ variable,mean)
write.table(mean_data,"./tidydata.txt")
