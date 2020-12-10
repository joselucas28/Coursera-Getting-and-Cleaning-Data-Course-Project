X_test <- read.table("C:\\Users\\Jose Lucas\\Documents\\Coursera\\Getting and Cleaning data\\project\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\X_test.txt")
Y_test <- read.table("C:\\Users\\Jose Lucas\\Documents\\Coursera\\Getting and Cleaning data\\project\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\Y_test.txt")
X_train <- read.table("C:\\Users\\Jose Lucas\\Documents\\Coursera\\Getting and Cleaning data\\project\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\X_train.txt")
Y_train <- read.table("C:\\Users\\Jose Lucas\\Documents\\Coursera\\Getting and Cleaning data\\project\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\Y_train.txt")
head(X_train)
dataset1 <- data.frame(X_test)
dataset2 <- data.frame(Y_test)
dataset3 <- data.frame(X_train)
dataset4 <- data.frame(Y_train)
#merging datasets
dataX <- rbind(dataset1, dataset3)
dataY <- rbind(dataset2, dataset4)
#calculating mean of datasets
meanX <- sapply(dataX, mean)
meanY <- sapply(dataY, mean)
print(meanX)
print(meanY)
#calculating sd of datasets
sdX <- sapply(dataX, sd)
sdY <- sapply(dataY, sd)
print(sdX)
print(sdY)
#add labels
labels <- read.table("C:\\Users\\Jose Lucas\\Documents\\Coursera\\Getting and Cleaning data\\project\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\features.txt")
labelsdf <- labels$V2
install.packages('dplyr')
library(dplyr)
# feature info
feature <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/features.txt"))

# activity labels
a_label <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/activity_labels.txt"))
a_label[,2] <- as.character(a_label[,2])

# extract feature cols & names named 'mean, std'
selectedCols <- grep("-(mean|std).*", as.character(feature[,2]))
selectedColNames <- feature[selectedCols, 2]
selectedColNames <- gsub("-mean", "Mean", selectedColNames)
selectedColNames <- gsub("-std", "Std", selectedColNames)
selectedColNames <- gsub("[-()]", "", selectedColNames)


#4. extract data by cols & using descriptive name
x_data <- x_data[selectedCols]
allData <- cbind(s_data, y_data, x_data)
colnames(allData) <- c("Subject", "Activity", selectedColNames)

allData$Activity <- factor(allData$Activity, levels = a_label[,1], labels = a_label[,2])
allData$Subject <- as.factor(allData$Subject)


#5. generate tidy data set
meltedData <- melt(allData, id = c("Subject", "Activity"))
tidyData <- dcast(meltedData, Subject + Activity ~ variable, mean)

write.table(tidyData, "./tidy_dataset.txt", row.names = FALSE, quote = FALSE)

