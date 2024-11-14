#Loading required packages
install.packages('tidyverse')
install.packages('ggplot2')
install.packages('caret')
install.packages('caretEnsemble')
install.packages('psych')
install.packages('Amelia')
install.packages('mice')
install.packages('GGally')
install.packages('rpart')
install.packages('randomForest')
install.packages("klaR")
install.packages("haven")

library(tidyverse) #data science library
library(ggplot2) #plotting library
library(caret) #Short for "Classification and Regression Training" used for Bayes
library(caretEnsemble) #makes ensembles of caret models
library(psych) #used by social scientists 
library(Amelia) #used to replace missing data
library(mice) #used to replace missing data
library(GGally) #extension for ggplot2
library(rpart) #used to split the data recursively
library(randomForest) #random forest algorithm for classification and regression
library(klaR) #Evaluates the performance of a classification method


#Reading data into R
data<- read.csv("/Users/ianjones/Desktop/cs462/lab6/Stress.csv")

#Setting outcome variables as categorical - identifies the outcome variable from the dataset
data$Outcome <- factor(data$label, levels = c(0,1), labels = c("False", "True"))

#Studying the structure of the data
str(data)
head(data)
describe(data)

#Data Cleaning
#Convert '0' values into NA
data[, 2:7][data[, 2:7] == 0] <- NA

#visualize the missing data
#plots a missingness map showing where missingness occurs in the dataset
#from Amelia
missmap(data)

#Uses mice package to predict missing values
label_data <- data[, c("label"), drop = FALSE]
confidence_data <- data[, c("confidence"), drop = FALSE]
mice_mod <- mice(label_data, confidence_data, method='rf')
mice_complete <- complete(mice_mod)

#Transfer the predicted missing values into the main data set
data$label <- mice_complete$label

#visualize the missing data again to double check
missmap(data)

#Data Visualization
#Visual 1
#Shows the age distribution count by outcome (diabetic or not diabetic)
ggplot(data, aes(label = Outcome)) +
  geom_freqpoly(binwidth = 1) + labs(title="new label")


## IF YOU GET WARNINGS – just keep going. Question 2 is to try and debug those warnings.

#Building a model
#split data into training and test data sets
#Creates a series of test/training partitions from Carat
indxTrain <- createDataPartition(y = data$Outcome,p = 0.75,list = FALSE)
training <- data[indxTrain,]
testing <- data[-indxTrain,] #Check dimensions of the split > prop.table(table(data$Outcome)) * 100

#create objects x which holds the predictor variables and y which holds the response variables
x = training[,-9]
y = training$Outcome

#Functions for Naive Bayes (provided by R)
library(e1071)

#Sets up a grid of tuning parameters for a number of classification and regression routines
#From Carat
model = train(x,y,'nb',trControl=trainControl(method='cv',number=10))

#Model Evaluation
#Predict testing set
Predict <- predict(model,newdata = testing ) #Get the confusion matrix to see accuracy value and other parameter values > confusionMatrix(Predict, testing$Outcome )
#Confusion Matrix and Statistics

#Plot Variable performance
#Tracks the changes in model statistics from Carat
X <- varImp(model)
plot(X)
