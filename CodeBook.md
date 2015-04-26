= Code Book for Course Project Tidy Data

The original data includes 543 feature variables.
Of these, most are not of interest for the assignment.

== Original Data Code Book
This section is simply the incorporated text
from the supplied data set.

=== Feature Selection 

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'


== Output Summary Data Code Book

The result reduces to 66 feature variables, which
can be grouped into 2 sets:
- one set of X, Y, Z coordinate values, and
- one set that is not broken down into coordinates

The items are as follows.
Entries in the table are the
column names in the full merged data set.

Coordinate group, 6 * 8 == 48 variables

feature             mean()         std()
variable         X     Y    Z     X     Y   Z
--------       ---- ---- ----   ---- ---- ----
tBodyAcc         V1   V2   V3     V4   V5   V6
tGravityAcc     V41  V42  V43    V44  V45  V46
tBodyAccJerk    V81  V82  V83    V84  V85  V86
tBodyGyro      V121 V122 V123   V124 V125 V126
tBodyGyroJerk  V161 V162 V163   V164 V165 V166
fBodyAcc       V266 V267 V268   V269 V270 V271
fBodyAccJerk   V345 V346 V347   V348 V349 V350
fBodyGyro      V424 V425 V426   V427 V428 V429

Non-coordinate group, 2 * 9 == 18 variables

feature              mean()     std()
-------            --------    ------
tBodyAccMag          V201       V202
tGravityAccMag       V214       V215
tBodyAccJerkMag      V227       V228
tBodyGyroMag         V240       V241
tBodyGyroJerkMag     V253       V254
fBodyAccMag          V503       V504
fBodyAccJerkMag      V516       V517
fBodyGyroMag         V529       V530
fBodyGyroJerkMag     V542       V543
