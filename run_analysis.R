library(dplyr)

# Read activity labels 1-6 with their desription from activity_labels.txt
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt",header=FALSE,stringsAsFactors=FALSE)

# Define function to replace activity labels with their name
label_to_name <- function(x) {
  return(activity_labels[x,2])
}

# Read feature names from file features.txt
features <- read.table("UCI HAR Dataset/features.txt",header=FALSE,stringsAsFactors=FALSE)

# Add more feature names
features <- rbind(features, c(562,"activity"))
features <- rbind(features, c(563,"subject_id"))

# Read train file
x_train <- read.table("UCI HAR Dataset/train/X_train.txt",header=FALSE)

# Read activity label and add to table
y_train <- read.table("UCI HAR Dataset/train/y_train.txt",header=FALSE)
x_train[,562] <- lapply(y_train,label_to_name)

# Read subject IDs and add to table
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt",header=FALSE)
x_train[,563] <- subject_train

# Repeat all of the above steps for test data
x_test <- read.table("UCI HAR Dataset/test/X_test.txt",header=FALSE)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt",header=FALSE)
x_test[,562] <- lapply(y_test, label_to_name)
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt",header=FALSE)
x_test[,563] <- subject_test

# Combine the two data sets
dataset <- rbind(x_train,x_test)

# Set header for train data
colnames(dataset) <- features[,2]

# Translate table into a dataframe
df <- as.data.frame(dataset)

# Find all column headers with 'mean' or 'std' in them
headers_sub <- grep(".*(?:mean|std|activity|subject).*", names(dataset), value=TRUE, perl=TRUE)

# Delete all columns that do not contain measurements of mean and std
df_sub <- df[,(colnames(df) %in% headers_sub)]

# Apply dplyr to get the mean of each variable for each subject_id and activity pairing
t <- df_sub %>% group_by(activity,subject_id) %>% summarise_each(funs(mean))

# Create file
write.table(t, file="tidy_data_avrg.txt",row.name=FALSE)







