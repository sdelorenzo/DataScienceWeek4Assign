# Overview
run_analysis.R is an R script that combines the test and train data sets in the UCI HAR Dataset folder.  It is assumed the UCI HAR Dataset folder is downloaded and saved, and is set as R's working directory.  The data sets are able to be merged together based on the original order of each observation, so binding and merging is done with care to keep the same order in each data frame.

The assignment's requirements are done out of order for ease of column name labeling.  All data frames are read into R using read.csv with header = FALSE and separator = "".

# Method
1. First the main data sets are read in to R and binded together into a dataframe called "data". The column names are applied from the second column of the "features" data set. The data object is then subsetted to keep only those columns who's names contain "mean" or "std" as required by the assignment.  This is done using the grep function which returns the column positions of each result.
2. Next the labels are read into R and binded together, these are integer values representing each activity a person might be doing.  The integer label values are translated into more descriptive values (i.e. walking, sitting, etc.) through the "activity_labels" data set.  labels and activity are merged together with sort set to FALSE in order to preserve the original ordering of the labels data.
3. Next the subject data is read into R and binded together.  This contains an identifier for each person doing the activities measured (an integer of 1 through 30).
4. Then each data frame is cbinded together and the remaining column names are added to make the final "data" data frame.
5. The RM function is then called to remove redundant data that has since been combined into the "data" data frame.
6. Finally, using the dplyr package, a "summarydf" dataframe is created which contains the averages for each column grouped by activity and subject.
