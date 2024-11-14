
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



# Reading data into R
data <- read.csv("/Users/ianjones/Desktop/cs462/lab6/Student_performance_data _.csv")
data


# Studying the structure of the data
str(data)
head(data)
describe(data)



# Use mice package to predict missing values
mice_mod <- mice(data[, c("Gender", "Ethnicity", "ParentalEducation", "StudyTimeWeekly", "GPA")], method = 'rf')
mice_complete <- complete(mice_mod)

# Transfer the predicted missing values into the main data set
data$Gender <- mice_complete$Gender
data$Ethnicity <- mice_complete$Ethnicity
data$ParentalEducation <- mice_complete$ParentalEducation
data$StudyTimeWeekly <- mice_complete$StudyTimeWeekly
data$GPA <- mice_complete$GPA

# Visualize the missing data again to double check
missmap(data)

# Visual 1: StudyTimeWeekly distribution by GPA
study_time_plot <- ggplot(data, aes(x = StudyTimeWeekly, y = GPA)) +
  geom_point() + 
  labs(title = "Study Time Weekly vs GPA",
       x = "Study Time Weekly",
       y = "GPA") +
  theme(plot.title = element_text(size = 12), axis.text = element_text(size = 10), axis.title = element_text(size = 10))
print(study_time_plot)

# Visual 2: Parental Education distribution by GPA
study_time_plot <- ggplot(data, aes(x = ParentalEducation, y = GPA)) +
  geom_point() + 
  labs(title = "Parental Education vs GPA",
       x = "Parental Education",
       y = "GPA") +
  theme(plot.title = element_text(size = 12), axis.text = element_text(size = 10), axis.title = element_text(size = 10))
print(study_time_plot)

# Building a model
# Split data into training and test data sets
indxTrain <- createDataPartition(y = data$Outcome, p = 0.75, list = FALSE)
training <- data[indxTrain, ]
testing <- data[-indxTrain, ]

# Check dimensions of the split
prop.table(table(data$Outcome)) * 100

# Create objects x which holds the predictor variables and y which holds the response variables
x <- training[, -9]
y <- training$Outcome

# Set up Naive Bayes model using caret
model <- train(x, y, 'nb', trControl = trainControl(method = 'cv', number = 10))

# Model Evaluation
# Predict testing set
Predict <- predict(model, newdata = testing)

# Get the confusion matrix to see accuracy value and other parameter values
confusionMatrix(Predict, testing$Outcome)

# Plot Variable performance
X <- varImp(model)
plot(X)
