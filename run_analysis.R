#(requirement 1) pull each data set together from test/train folders, as well as their descriptors
    #data (the measurements from devices)
    X_test <- read.csv("test/X_test.txt", header = FALSE, sep = "")
    X_train <- read.csv("train/X_train.txt", header = FALSE, sep = "")
      data <- rbind(X_test, X_train)
      
    #(requirement 4) rename data column headers
    features <- read.csv("features.txt", header = FALSE, sep = "")
      colnames(data) <- features[,2]
    
    #(requirement 2) Extract only the measurements on the mean and standard deviation for each measurement
      data <- data[,grep("mean|std",names(data))]

    #labels (description of activity taking place)
    y_test <- read.csv("test/y_test.txt", header = FALSE, sep = "") 
    y_train <- read.csv("train/y_train.txt", header = FALSE, sep = "")
      labels <- rbind(y_test, y_train)
      
    #(requirement 3) translate label from integer to the actual activity  taking place 
    activity <- read.csv("activity_labels.txt", header = FALSE, sep ="")
      labels <- merge(labels,activity,sort = FALSE)

    #subjects (identifier of each person - integer 1:30)
    subject_test <- read.csv("test/subject_test.txt", header = FALSE, sep = "") 
    subject_train <- read.csv("train/subject_train.txt", header = FALSE, sep = "")
      subject <- rbind(subject_test, subject_train)
    
    #combine columns of all data sets, rename activity and subject columns
    data <- cbind(labels[,2],subject,data)
    colnames(data)[1:2] <- c("activity", "subject")
    
    #clean up un-needed objects
    rm(X_test,X_train,y_test,y_train,subject_test,subject_train, labels, subject,features,activity)
    
    #(requirement 5) create second data set with the average of each variable by activity and subject
    library(dplyr)
    summarydf <- group_by(data, activity, subject) %>% summarize_each(funs(mean))  %>% arrange(activity, subject)
    