# GettingCleaningDataProject

The accompanying file run_analysis.R merges various data sets from the UCI HAR corpus and performs averaging over its 'mean' and 'std' variables.

Step 1: Reading activity labels and names from file 'activity_labels.txt', and providing a function to replace activity labels with their associated names

The train and test data contain an INT activity_label variable. At a later point we want to replace those integer labels with the actual activity name. To that end we define a function that, given an activity label, returns its name. This function is called 'label_to_name'.

Step 2: Reading feature names from file 'features.txt'

Once we're loading the train and test data we'd like to add descriptive column headers. They are listed in the given file. In addition, we want to add additional columns to our data, namely the activity and subject_id.

Step 3: Read the training data from file 'train/X_train.txt'

Step 4: Add activity and subject_id

Here we are using previously defined function 'label_to_name' to replace activity labels with their names. The activity labels are in file 'train/y_train.txt'. The subject IDs are in file 'train/subject_train.txt'.

Step 5: Repeat steps 3 and 4 for the 'test' data

Step 6: Combine test and train tables into a single table and add column headers

The newly created table is called 'dataset'

Step 7: Create a dataframe based on table 'dataset'

This step is required so that we can use 'dplyr' later to perform summarization of data

Step 8: Filter dataframe

Here we create a dataframe containing only 'activity', 'subject_id', as well as any column containing mean or standard deviation data. We first perform regular expression on column headers to identify wanted columns. Then we create the new dataframe based on that list of column names. The new dataframe is called 'df_sub'.

Step 9: Get the mean of each variable for each subject_id and activity pairing

Step 10: Save the results to file 'tidy_data_avrg.txt'

