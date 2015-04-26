Getting and Cleaning Data Course Project
========================================

Overview and Contents
---------------------
Student name: Jeffrey Radick
Date: April 26, 2015

This repo contains my submission for
the project assignment for the course
Coursera course "Getting and Cleaning Data"
given during April 2015 (course session id getdata-013)
as part of the Data Science Specialization.

Contents of this repo are:
   README.md        this file
   run_analysis.R   the script for producing the analysis
   tidy.data.txt    the "tidy data" produced by the script
   CodeBook.md      the Code Book for the data


General Remarks
---------------
As of when I'm writing this (1:44pm PDT / 8:44pm UTC on the due date),
I haven't been able to get the summary to come out so my results
are incomplete, and I don't have an actual tidy data file
to upload.  My script does all the other stuff, though,
and I believe it to be correct although I think probably
there has to be a simpler way to do some of it.

I'm having trouble getting the formatting correct for the Code Book.
I have a couple of tables that look fine in plain text but get
completely messed up by MarkDown and I don't know how to fix it.
I don't see anything about table formatting in the MarkDown
documentation.  As it is, the table as rendedred by the web server
on github looks unreadable.  It looks fine if you download the
text and look at it as a plain ASCII file.

The comments in the code (run_analysis.R) are extensive
and I hope clear as to what I was trying to do and how
I was trying to do it.

Input Data
----------
A specified for the assignment, the data set processed
by the script is extracted from the zip file downloaded
from the URL
   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The script assumes that this file is extracted in
a subdirectory "data" relative to where the script is run.
That is, the directory containing the run_analysis.R script
has a subdirectory "data", and the result of extracting the zip
file there is a subdirectory "UCI HAR Dataset" which in turn
contains all of the data files.

The following files are included:
* `README.txt`            Explanation of the data set
* `activity_labels.txt`   List of codes for 6 activity labels used in the data
* `features.txt`          List of codes for 561 feature labels used
* `features_info.txt`     Description of the features and labelling
* `test/X_test.txt`       Test data values for the 561 feature variables
* `test/subject_test.txt` Test data subject codes for each line of X_test.txt
* `test/y_test.txt`       Test data activity codes for each line of X_test.txt
* `train/X_train.txt`     Training data values for the 561 feature variables
* `train/subject_train.txt` Training data subject codes for each line
* `train/y_train.txt`     Training data activity codes for each line

In addition, the `test` and `train` subdirectories each contain
a further subdirectory `Inertial Signals` containing files
which are not used.

Output Data
-----------
The output data is described in the CodeBook.md file.
