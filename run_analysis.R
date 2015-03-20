#Read features
traindata=read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt", sep="")
cNames<-traindata[,2]
#Read Test Dataset
testdata=read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", sep="", col.names=cNames)
testactivity<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt", sep="\n")

#combined features and acitvity
testdata<-cbind(testdata, testactivity)

#Read training dataset 

traindata=read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", sep="", col.names=cNames)
trainactivity<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt", sep="\n")

#combining features and activity label
traindata<-cbind(traindata, trainactivity)


#Merge Data
mergeData<-rbind(traindata, testdata)

#Extracts only the measurements on the mean
pattern<-c("mean")
IndexMean<-grep(pattern, cNames)

#Extracts only the measurements on the standard deviation
pattern<-c("std")
IndexSTD<-grep(pattern, cNames)

##New dataframe
newdata<-data.frame(mergeData[, IndexMean[1]])
colnames(newdata)[1]<-as.character(cNames[IndexMean[1]])

## Construct for new columns with mean measurements only
for(i in 2: length(IndexMean))
  {
     newdata<-cbind(newdata, mergeData[, IndexMean[i]])
     colnames(newdata)[i]<-as.character(cNames[IndexMean[i]])
  } 


##Add columns for Standard deviation measurements only
for(i in 1: length(IndexSTD))
  {
     newdata<-cbind(newdata, mergeData[, IndexSTD[i]])
     colnames(newdata)[ncol(newdata)]<-as.character(cNames[IndexSTD[i]])
  } 

## Add activity column 
 newdata<-cbind(newdata, as.character(mergeData[, ncol(mergeData)]))
 colnames(newdata)[ncol(newdata)]<-"Activity"



##step 3: Add Labels to activity
 newdata$Activity<-as.character(newdata$Activity)


newdata$Activity[newdata$Activity=="1"]<-"WALKING"
newdata$Activity[newdata$Activity=="2"]<-"WALKING_UPSTAIRS"
newdata$Activity[newdata$Activity=="3"]<-"WALKING_DOWNSTAIRS"
newdata$Activity[newdata$Activity=="4"]<-"SITTING"
newdata$Activity[newdata$Activity=="5"]<-"STANDING"
newdata$Activity[newdata$Activity=="6"]<-"LAYING"

#Step 5: create tidy data
tidydata<-data.frame(newdata[1,])

##all rows of walking
walkingsubset<-subset(newdata, newdata$Activity=="WALKING")


for(k in 1:(ncol(newdata)-1))
{
   walking<-walkingsubset[,k]
   meanvalue<-mean(walking)
   tidydata[1, k]<-meanvalue;
}
tidydata[1, k+1]<-"WALKING";

##all rows of WALKING_UPSTAIRS
walkingsubset<-subset(newdata, newdata$Activity=="WALKING_UPSTAIRS")

#temporary dataframe
tempframe<-data.frame(newdata[1,])


for(k in 1:(ncol(newdata)-1))
{
   walking<-walkingsubset[,k]
   meanvalue<-mean(walking)
   tempframe[1, k]<-meanvalue;
}
tempframe[1, k+1]<-"WALKING_UPSTAIRS";

#append the data to tidyday
 tidydata<-rbind(tempframe, tidydata)


##all rows of WALKING_DOWNSTAIRS
walkingsubset<-subset(newdata, newdata$Activity=="WALKING_DOWNSTAIRS")
tempframe<-data.frame(newdata[1,])

for(k in 1:(ncol(newdata)-1))
{
  walking<-walkingsubset[,k]
  meanvalue<-mean(walking)
  tempframe[1, k]<-meanvalue;
}

tempframe[1, k+1]<-"WALKING_DOWNSTAIRS";

tidydata<-rbind(tempframe, tidydata)

##all rows of SITTING
sittingsubset<-subset(newdata, newdata$Activity=="SITTING")
tempframe<-data.frame(newdata[1,])

for(k in 1:(ncol(newdata)-1))
{
	sitting<-sittingsubset[,k]
	meanvalue<-mean(sitting)
      tempframe[1, k]<-meanvalue;
}

tempframe[1, k+1]<-"SITTING";
tidydata<-rbind(tempframe, tidydata)

##all rows of STANDING
standingsubset<-subset(newdata, newdata$Activity=="STANDING")
tempframe<-data.frame(newdata[1,])

for(k in 1:(ncol(newdata)-1))
{
  standing<-standingsubset[,k]
  meanvalue<-mean(standing)
  tempframe[1, k]<-meanvalue
}
tempframe[1, k+1]<-"STANDING";
tidydata<-rbind(tempframe, tidydata)

##all rows of LAYING
layingsubset<-subset(newdata, newdata$Activity=="LAYING")
tempframe<-data.frame(newdata[1,])

for(k in 1:(ncol(newdata)-1))
{
  laying<-layingsubset[,k]
  meanvalue<-mean(laying)
  tempframe[1, k]<-meanvalue
}
tempframe[1, k+1]<-"LAYING";
tidydata<-rbind(tempframe, tidydata)

#Write the data in a txt file
write.table(tidydata, "project.txt", row.name=FALSE)
