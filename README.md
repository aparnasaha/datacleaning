# datacleaning Project: A guide for the run_analysis.R 

The code starts with reading the data from two different folders. 
1. Read features from "UCI" folder.
2 . Test dat from "UCI/Test/" folder.
3. Training dataset from "UCI/train/" folder. program assumes this folder and corresponding subfolders (and files) are in the same location where R file is located.


After reading test data, program combibnes testdata with the corresponding activites.. the combines data is stored in a variable called

"testdata"

similarly training data is a combination of features and activities and it is stored in a variable "traindata".

"mergeData" is a combination of test and training data sets.


The mergeData is cleaned to select the features for mean standard deviation.  to do that, I used the following approach in R program does the following.

i) search for all columns that include the word "mean". "grep" function is to used to do this search. "cNames" is a variable that contains all column names.
these columns are stored in a vector "IndexMean".
ii) search for columns that include the word "std" i.e. standard deviation. "IndexSTD" is used to store all columns for standard deviation.

"newdata" is built with mean and standard deviation based measurements.  the activity column is replaced with activity labels.

"tidydata" is a furhter cleaning of new data. Only the mean of each activity is stored in this dataframe.

To calculate mean for each measurement, a subset of newdata is taken for each activity and then a mean is calculated.
"tempframe" is created to store the mean of activity and then then it is append (using rbind) to tidydata.

Finally, tidydata is written in a text file using write.table.
