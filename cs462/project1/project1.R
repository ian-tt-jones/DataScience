### Project 1 for CMSC 462
### Complete each of the commands below as prompted
### This is an INDIVIDUAL assignment (no groups!)
### The project is due on Monday, June 10th by 11:59pm on Blackboard

### Run the following R code and add code/commented answers where prompted


######################################## 1. #############################################
myVar = "83"

# Write the code that changes myVar to an integer data type. Assign the output to myVar.
myVar <- as.integer(myVar)

# Check the class of myVar
class(myVar)


######################################## 2. #############################################
# Create a vector named NumVec1 with the following entries -1, 4.5, 9, 10, 3
NumVec1 <- c(-1, 4.5, 9, 10, 3)

# Create a vector named NumVec2 with the following entries -5, 10, -2, 20, 3
NumVec2 <- c(-5, 10, -2, 20, 3)

# Write the code that calculates the sum of NumVec1 and NumVec2
sum(NumVec1 + NumVec2)

# Write the relational expression that checks where NumVec1 is greater than NumVec2
NumVec1 > NumVec2

# Write the relational expression that finds where NumVec1 has the same value as NumVec2
NumVec1 == NumVec2

# Update the NumVec1 vector to equal 1 if NumVec1 is less than 5
# and 0 if NumVec1 is greater than or equal to 5
NumVec1 <- ifelse(NumVec1 < 5, 1, 0)

# Print the the NumVec1 vector to check your results
# Hint: NumVec1 should now be [1, 1, 0, 0, 1]
print(NumVec1)

########################################## 3. #############################################
TextVar = "MIS 431"
Data = c(3, 7, 4.5, 9, 4, 5.67)

# Write an IF statement that prints "MIS 431 is assigned to TextVar" if TextVar is equal to "MIS 431"
if (TextVar == "MIS 431") {
  print("MIS 431 is assigned to TextVar")
}


# Write an IF-ELSE statement that prints "The mean is less than 5" if the mean of the 
# Data vector is less than 5, or prints "The mean is greater than or equal to 5" if not
# Hint: the mean() function calculates the mean of a vector
if (mean(Data) < 5) {
  print("The mean is less than 5")
} else{
  print("The mean is greater than or equal to 5")
}


# Write a FOR loop that prints the square root of the elements in the Data vector
# the sqrt() function calculates the square root of a number
for (i in Data) {
  print(sqrt(i))
}


########################################## 4. #############################################
myList = list(Gender = c("M", "F"),
              Age = c(26, 24),
              City = c("Catonsville","Towson"))

# Write the code that gives the mean of the Age vector in myList
mean(myList[[2]])

# Write the code that gives the second element of the City vector in myList
myList[[3]][[2]]

# Write the code that gives the value of City in myList that corresponds to a value of "M" in Gender
myList$City[myList$Gender == "M"]

########################################## 5. #############################################
myDataframe = data.frame(Model = c("Toyota","Honda","Ford"),
                         mpg = c(34, 33, 22),
                         stringsAsFactors = FALSE)

# Write the command that gives the first row, second column of myDataframe
myDataframe[1, 2]


# Write the command that gives the average of the mpg column in myDataframe
mean(myDataframe$mpg)


# Write the command that gives the Model value that corresponds to an mpg value of 22 in myDataframe
myDataframe$Model[myDataframe$mpg == 22]

################################# Question 6 ############################################

# Run the code below to import the tidyverse package
library(tidyverse)

# In the project directory on Blackboard there should be a file named
# proj1_data.txt. Hover over the link and click "Save Link As" and save it
# to your local computer. The proj1_data.txt is data about people who
# tip at a restaurant. 

# Fill in the correct path to the proj1_data.txt file on your computer
# Remember to end your file path with proj1_data.txt (the name of the file)
# Separate parts of your path with "/" 

Tipping = read_tsv(file = "/Users/ianjones/Desktop/cs462/project1/proj1_data.txt" )

# Now you should have a data frame, Tipping, available in your R session
# Run the code below to see what's stored in Tipping
# Tipping contains customer tipping data for a California restaurant
glimpse(Tipping)

################################# Question 7 ############################################

# We will be using dplyr functions to answer Question 7
# Here is an example of what I expect your answer to be

# Example question: Use filter() to subset the Tipping data
# to contain only Male customers.

# Your answer should be:
filter(Tipping, sex == "Male")

# Use filter() to subset the Tipping data
# to contain only Male customers who ate dinner on Saturday or Sunday

# Hint: the "day" variable gives the day a customer ate at the restaurant
# the "time" variable gives whether the meal was Dinner or Lunch
 

# Enter your code below:
filter(Tipping, sex == "Male" & ((day == "Sat") | (day == "Sun") & time == "Dinner"))


# Use filter() to subset the Tipping data
# to contain only customers that tipped more than 6 dollars

# Hint: the "tip" variable contains the dollar amount that a 
# customer left as tip

# Enter your code below:
filter(Tipping, tip > 6)


# Use arrange() to sort the Tipping data frame
# by total_bill and then by tip, both in DESCENDING order

# Enter your code below:
arrange(Tipping, desc(total_bill), desc(tip))

################################# Question 8 ############################################

# Use select() to select the first 2 columns of Tipping

# Enter your code below:
select(Tipping, total_bill, tip)

# Use select() to select columns that contain the lower case letter "s"

# Enter your code below:
select(Tipping, contains("s"))

# Use summarize() to obtain the average tip amount
# Assign the result to a variable called "AvgTip" within the summarize function

# Enter your code below:
AvgTip <- summarize(Tipping, AvgTip = mean(tip))

# Enter the numeric value that you got from the code above, what's the average tip amount?
# Your answer: 3

################################# Question 9 ############################################

# For question 9, you will need to use the %>% operator for your answers

# Use group_by() and summarise() to obtain the average tip by customer gender
# Assign the results to a variable named AvgTip, just like you did above

# Hint: Your code should look like this: Tipping %>% group_by() %>% summarise()
# Just fill in the correct input 

# Enter your code below:
AvgTip <- Tipping %>% group_by(sex) %>% summarise(AvgTip = mean(tip))

# From the results above, which gender has higher tips, on average? Just enter male or female.
# Your answer: Malw

# Use mutate() to compute a variable called TipPercent which equals tip/total_bill
# Hint, fill in the correct input: Tipping %>% mutate()

# Enter your code below:
Tipping %>% mutate(TipPercent = tip/total_bill)


# Now extend the analysis above: Use a combination of mutate(), group_by(), and summarise()
# to compute the average tip percent by customer gender. Assign the results to TipPercent 
# within the mutate() function, just like above, and AvgTipPct
# within the summarise() function

# Hint: mutate() first, then group_by(), then summarize(), use the %>% operator
# Within summarize, you need to input AvgTipPct = mean(). What should go inside the mean() function?

# Enter your code below:
TipPercent <- Tipping %>% mutate(TipPercent = tip / total_bill) %>% group_by(sex) %>% summarise(AvgTipPct = mean(TipPercent))


################################# Question 10 ############################################

# Write the R code that uses ggplot2 to produce a histogram
# of the tip variable in Tipping
# Set the color of the bars to "blue", and the border
# of the bars to "white"
# Add an appropriate title and x/y axis labels


# Enter your code below:
ggplot(Tipping, aes(x = tip)) + geom_histogram(fill = "blue", color = "white") + 
  labs(title = "Histogram of Tips", x = "Tip Amount", y = "Freq")
