# samsung-tidy-data

This script first loads the data from the Samsung UCI HAR Dataset file, keeping the original file names as variable names. There are 3 dataframes for Train, 3 for Test, and a dataframe of Features (the names of the variables). 

I then name the variables by applying the Features to the column names of the Train and Test data (X_train and X_test are the original files respectively). I also added the names "Activity" for the activities column and "Subject" for the subject column to each respective data set; I left the other variable names as is, since they are already sufficiently descriptive.

I then created a function to label the activities (activitylabel) according to the numeric code and applied this function to both test and train (my variables are ytest and ytrain). 

Next up I selected only the variables with "mean" or "std" in the name using the grepl() command and created a new dataframe with just those variables. I bound the columns together of Subject, Activity, and the mean/std variables for both the train and test data. I then combined those two dataframes, putting train on top of test. Finally I grouped the data by both Subject and Activity using the group_by command from dplyr, and then found the means for each of the groups with summarize_each.
