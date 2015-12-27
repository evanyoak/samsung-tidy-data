##load data
traindata <- read.table("./UCI HAR Dataset/train/X_train.txt")
subjecttrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
testdata <- read.table("./UCI HAR Dataset/test/X_test.txt")
subjecttest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

##name variables
testdata <- `colnames<-`(testdata, features$V2)
traindata <- `colnames<-`(traindata, features$V2)
names(ytrain)[names(ytrain) == "V1"] <- "Activity"
names(subjecttrain)[names(subjecttrain) == "V1"] <- "Subject"
names(ytest)[names(ytest) == "V1"] <- "Activity"
names(subjecttest)[names(subjecttest) == "V1"] <- "Subject"

##label activities with function
activitylabel <- function(x){
    x[x == 1] <- "Walking"
    x
    x[x == 2] <- "Walking Up Stairs"
    x
    x[x == 3] <- "Walking Down Stairs"
    x
    x[x == 4] <- "Sitting"
    x
    x[x == 5] <- "Standing"
    x
    x[x == 6] <- "Laying"
    x
}

ytest[] <- lapply(ytest, activitylabel)
ytrain[] <- lapply(ytrain, activitylabel)

##select only mean and standard deviation variables
varnames <- colnames(traindata)
varnames <- make.names(varnames)
meanstd <- grepl(".mean|.std", varnames)
colselect <- traindata[, which(meanstd == T)]
varnames2 <- colnames(testdata)
varnames2 <- make.names(varnames2)
meanstd2 <- grepl(".mean|.std", varnames2)
colselect2 <- testdata[, which(meanstd2 == T)]

##combine subject and activity columns to datasets
train_tidy <- cbind(subjecttrain, ytrain, colselect)
test_tidy <- cbind(subjecttest, ytest, colselect2)

##combine train and test datasets
train_test <- rbind(train_tidy, test_tidy)

##group the data by subject and activity and find the mean of each variable for each group
grouped_data <- group_by(train_test, Subject, Activity)
summaryMeans <- summarise_each(grouped_data, funs(mean), -Activity, -Subject)
