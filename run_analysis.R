#
# Coursera course "Getting and Cleaning Data"
# April 2015, session getdata-013
# Part of Data Science Specialization
#
# Jeffrey Radick, student
#
#
# Code for course project
#
# As specified for the assignment, the requirements for this program
# are as follows:
# 1. Merges the training and the test data sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation
#    for each measurement
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriate labels the data set with descriptive variable names
# 5. From the data set in step 4, creates a second, independent
#    tidy data set with the average of each variable
#    for each activity and each subject
#
# The code is structured as follows:
# - There is a set of function definitions,
#   each of which performs a single well-defined step.
#   These form building blocks for what the script needs to do.
# - At the end, after all the building blocks are defined,
#   there is a series of calls to the proper functions in the
#   proper order in order to carry out the required action.
#   This set of operations is in a single funciton "run_analysis()".
# - At the very end, outside of any of the function definitions,
#   the function "run_analysis()" is called so that the required
#   operation is performed as the script is read in by R.
#

library(dplyr)

read_activities <- function(dir)
{
	fname <- paste(dir, "activity_labels.txt", sep = "/")
	df <- read.table(fname, sep = " ", stringsAsFactors = FALSE)
	names(df) <- c("levels", "labels")
	df
}

read_features <- function(dir)
{
	fname <- paste(dir, "features.txt", sep = "/")
	df <- read.table(fname, sep = " ", stringsAsFactors = FALSE)
	names(df) <- c("num", "names")
	df
}

#
# Read the data set files and glue them together into a single data set.
# This does NOT merge the training and test data sets.
# This JUST builds one or the other of the data sets from 3 component files.
#
# The files are called
#    subject_<flavor>.txt
#    y_<flavor>.txt
#    X_<flavor>.txt
# where
#    <flavor> is either "test" or "train" as specified by the "flavor"
#             argument
#
# Visual inspection of the files indicates that
# - the lines of the 3 files correspond in a direct 1-to-1 fashion
#   i.e. line 1 of subject_train.txt goes with
#        line 1 of y_train.txt and line 1 of X_train.txt
# - the file subject_<flavor>.txt has the numerical key of the
#   subject (person) for which the data was collected
# - the file y_<flavor>.txt has the numerical activity key
#   indicating the activity from which the data was collected
# - the file X_<flavor>.txt contains the 561 data points collected
#   for the corresponding activity by the corresponding subject.
#
# The aim of this function is
# - read the 3 files into data frames
# - combine them into a single data frame
# - return the combined data frame
#
# Arguments are:
# - dir      is the directory containing the all of the data
#            (both data sets)
# - flavor   is either "train" or "test" to indicate which data set to build
# - features is a character vector containing the feature names,
#            to be used as column names for the data points from the
#            X_<flavor>.txt part of the data set
#
# The return value is a data frame containing the combined data set.
#
read_data_set <- function(dir, flavor)
{
	#
	# put together dir and file names with "train" or "test" in the names
	#
	subdir <- paste(dir, flavor, sep = "/")

	subject_fname <- paste("subject_", flavor, ".txt", sep = "")
	subject_path <- paste(subdir, subject_fname, sep = "/")

	y_fname <- paste("y_", flavor, ".txt", sep = "")
	y_path <- paste(subdir, y_fname, sep = "/")

	X_fname <- paste("X_", flavor, ".txt", sep = "")
	X_path <- paste(subdir, X_fname, sep = "/")

	#
	# now read the files and label the column headings
	# except for the df.X columns, we'll fix those later
	#
	df.subjects <- read.table(subject_path)
	names(df.subjects) <- c("subject")

	df.y <- read.table(y_path)
	names(df.y) <- c("activity")

	df.X <- read.table(X_path)

	# now combine everything into a single data frame
	df.combined <- data.frame(df.subjects, df.y, df.X)

	# here's the result!
	df.combined
}

#
# Perform step 1 of the project requirement:
# read and merge the training and test sets into a single data set.
#
read_and_merge_data_sets <- function(dir)
{
	df.training <- read_data_set(dir, "train")
	df.test <- read_data_set(dir, "test")

	# df.training and df.test should have identical column names
	df.merged <- merge(df.training, df.test, all = TRUE)

	df.merged
}

#
# Step 2 of the project requirement:
# extract the mean and standard deviation measurements
# from the full data set, resulting in a new smaller data set.
#
# This is tricky because we just want certain columns,
# there are a *lot* of columns to choose from,
# and at this point the columns we want have names like V161.
# I don't know of an easy way to automatically extract
# the right feature variables other than by looking,
# so here's what I did.
# After reading features_info.txt for explanations
# and studying features.txt, I realized I could do
#    egrep '(mean|std)\(\)' features.txt
# to find all the lines with feature names containing either
#      ...mean()...
# or
#      ...std()...
# This amounts to 66 feature variables, which
# can be grouped into 2 sets:
# - one set of X, Y, Z coordinate values, and
# - one set that is not broken down into coordinates
#
# The items are as follows.
# Entries in the table are the
# column names in the full merged data set.
#
# Coordinate group, 6 * 8 == 48 variables
#
# feature             mean()         std()
# variable         X     Y    Z     X     Y   Z
# --------       ---- ---- ----   ---- ---- ----
# tBodyAcc         V1   V2   V3     V4   V5   V6
# tGravityAcc     V41  V42  V43    V44  V45  V46
# tBodyAccJerk    V81  V82  V83    V84  V85  V86
# tBodyGyro      V121 V122 V123   V124 V125 V126
# tBodyGyroJerk  V161 V162 V163   V164 V165 V166
# fBodyAcc       V266 V267 V268   V269 V270 V271
# fBodyAccJerk   V345 V346 V347   V348 V349 V350
# fBodyGyro      V424 V425 V426   V427 V428 V429
#
# Non-coordinate group, 2 * 9 == 18 variables
#
# feature              mean()     std()
# -------            --------    ------
# tBodyAccMag          V201       V202
# tGravityAccMag       V214       V215
# tBodyAccJerkMag      V227       V228
# tBodyGyroMag         V240       V241
# tBodyGyroJerkMag     V253       V254
# fBodyAccMag          V503       V504
# fBodyAccJerkMag      V516       V517
# fBodyGyroMag         V529       V530
# fBodyGyroJerkMag     V542       V543
#
# Because I can't think of an automatic way to extract this mapping
# from the features.txt file and construct usable variable names
# from them in the output data frame (at least, not something I
# could code up in a weekend), I'm doing it by hand.
# That is, I constructed the table in the comments above by hand,
# and created the corresponding code by hand.
# The way I coded it is to create 2 mapping tables.
# Thus to extract the values I want,
# I just cycle through the tables.
# There ought to be a better way.
#
extract_subset <- function(df.full)
{
	df.subset <- select(df.full,
		  subject, activity,

		  V1:V6,
		  V41:V46,
		  V81:V86,
		  V121:V126,
		  V161:V166,
		  V266:V271,
		  V345:V350,
		  V424:V429,

		  V201:V202,
		  V214:V215,
		  V227:V228,
		  V240:V241,
		  V253:V254,
		  V503:V504,
		  V516:V517,
		  V529:V530,
		  V542:V543)

	df.subset
}

#
# Step 3: apply descriptive activity names
# What this does is to change the "activity" column to a factor variable,
# using the level names from the activity_labels.txt file.
#
# While we're at it, make the subject variable into a factor also.
# Not explicitly part of what's required in this step,
# but useful later when summarizing.
#
descriptive_activities <- function(df.in)
{
	df.activities <- read_activities(dir)
	df.out <- df.in
	df.out$activity <- factor(df.out$activity,
				levels = df.activities$levels,
			   	labels = df.activities$labels)

	df.out$subject <- factor(df.out$subject)

	df.out
}

#
# Step 4: apply descriptive labels
# As in step 2, this ought to be automated in some nice way
# but the mapping is a manual renaming of the 66 feature variables
# from the names from the original data frame (Vnnn)
# to a more descriptive name.
# The descriptive name is derived from the name in features.txt
# but is not the same, so as to avoid syntax issues
# relating to minus signs and parentheses in the original names.
#
descriptive_labeling <- function(df.in)
{
	df.out <- rename(df.in,
	       tBodyAcc_mean_X = V1,
	       tBodyAcc_mean_Y = V2,
	       tBodyAcc_mean_Z = V3,

	       tBodyAcc_std_X = V4,
	       tBodyAcc_std_Y = V5,
	       tBodyAcc_std_Z = V6,

	       tGravityAcc_mean_X = V41,
	       tGravityAcc_mean_Y = V42,
	       tGravityAcc_mean_Z = V43,

	       tGravityAcc_std_X = V44,
	       tGravityAcc_std_Y = V45,
	       tGravityAcc_std_Z = V46,

	       tBodyAccJerk_mean_X = V81,
	       tBodyAccJerk_mean_Y = V82,
	       tBodyAccJerk_mean_Z = V83,

	       tBodyAccJerk_std_X = V84,
	       tBodyAccJerk_std_Y = V85,
	       tBodyAccJerk_std_Z = V86,

	       tBodyGyro_mean_X = V121,
	       tBodyGyro_mean_Y = V122,
	       tBodyGyro_mean_Z = V123,

	       tBodyGyro_std_X = V124,
	       tBodyGyro_std_Y = V125,
	       tBodyGyro_std_Z = V126,

	       tBodyGyroJerk_mean_X = V161,
	       tBodyGyroJerk_mean_Y = V162,
	       tBodyGyroJerk_mean_Z = V163,

	       tBodyGyroJerk_std_X = V164,
	       tBodyGyroJerk_std_Y = V165,
	       tBodyGyroJerk_std_Z = V166,

	       fBodyAcc_mean_X = V266,
	       fBodyAcc_mean_Y = V267,
	       fBodyAcc_mean_Z = V268,

	       fBodyAcc_std_X = V269,
	       fBodyAcc_std_Y = V270,
	       fBodyAcc_std_Z = V271,

	       fBodyAccJerk_mean_X = V345,
	       fBodyAccJerk_mean_Y = V346,
	       fBodyAccJerk_mean_Z = V347,

	       fBodyAccJerk_std_X = V348,
	       fBodyAccJerk_std_Y = V349,
	       fBodyAccJerk_std_Z = V350,

	       fBodyGyro_mean_X = V424,
	       fBodyGyro_mean_Y = V425,
	       fBodyGyro_mean_Z = V426,

	       fBodyGyro_std_X = V427,
	       fBodyGyro_std_Y = V428,
	       fBodyGyro_std_Z = V429,

	       tBodyAccMag_mean = V201,
	       tBodyAccMag_std = V202,

	       tGravityAccMag_mean = V214,
	       tGravityAccMag_std = V215,

	       tBodyAccJerkMag_mean = V227,
	       tBodyAccJerkMag_std = V228,

	       tBodyGyroMag_mean = V240,
	       tBodyGyroMag_std = V241,

	       tBodyGyroJerkMag_mean = V253,
	       tBodyGyroJerkMag_std = V254,

	       fBodyAccMag_mean = V503,
	       fBodyAccMag_std = V504,

	       fBodyAccJerkMag_mean = V516,
	       fBodyAccJerkMag_std = V517,

	       fBodyGyroMag_mean = V529,
	       fBodyGyroMag_std = V530,

	       fBodyGyroJerkMag_mean = V542,
	       fBodyGyroJerkMag_std = V543)

	df.out
}

#
# Step 5: reduce the data to a nice tidy summary
#
make_tidy <- function(df.in)
{
	df.split <- split()
	df.out = ftable(xt)

	df.out
}

#
# The principal driver function,
# organized into steps explicitly associated
# with the stated requirements
#
run_analysis <- function(dir)
{
	#
	# step 0: read activity and feature names
	# this is useful for later in steps 1, 3, and 4
	#
	df.features <- read_features(dir)

	#
	# step 1: read and merge the training and test data sets
	#
	df.merged <- read_and_merge_data_sets(dir)

	# step 2: extract mean and std. dev. measurements
	df.extract <- extract_subset(df.merged)

	# step 3: apply descriptive names for the activities
	df.descriptive1 <- descriptive_activities(df.extract)

	# step 4: apply descriptive labels to the data set variables
	df.descriptive2 <- descriptive_labeling(df.descriptive1)

	# step 5: create new tidy data w/ averages for each activity, subject
	df.tidy <- make_tidy(df.descriptive2)

	# finally, write the tidy data to a file
	write.table(df.tidy, "tidy.data.txt", row.names = FALSE)
}

#
# Kick everything off as the script is read in
#
dir <- "./data/UCI HAR Dataset"
#run_analysis(dir)
