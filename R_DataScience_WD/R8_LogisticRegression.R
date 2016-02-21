#R8

setwd("D:/ToTransfer/DataScience/R_DataScience_WD")

#Logistic Regression
#Claims data - 131 diabetes patients. We'll predict Quality of Care. 1 for Low Quality care

# dataset
quality = read.csv("quality.csv")

str(quality)

# Table outcome
table(quality$PoorCare)

# about 75% of patients have good care
98/131

#this time we don't different files for training and test, so let's split this file only
install.packages("caTools")
library(caTools)

# splitting data. Before spliting we will set seed for R's random number generator
# that the split function uses to split data.
set.seed(88)

#split the data in such a way that the variable quality$PoorCare is well balanced 
#in each piece(70% good quality cases in each piece). 
# And put 75% of data in training set and 25% in test set.
# So, what does split function do?
# It gives a vector for the set being splitted. This vector has TRUE/FALSE values.
# So, for example if the split was 0.75 then the first set (let's say our training
# set) that has 75% of data, the vector entries against this subset will have TRUE,
# other 25% records will have that vector's entries as FALSe
# In short, each entry in split vector corresponds to each record for data being 
# splitted, whether that record belong to set 1 (TRUE value) or set 2 (FALSE value)

split = sample.split(quality$PoorCare, SplitRatio = 0.75)
str(split)

# Create training and testing sets
qualityTrain = subset(quality, split == TRUE)
qualityTest = subset(quality, split == FALSE)

# Logistic Regression Model
# Step 1
QualityLog = glm(PoorCare ~ OfficeVisits + Narcotics, data=qualityTrain, family=binomial)
summary(QualityLog)

#we see that the officeVisits and Narcotics are positive, so when they increase,
#poor quality of care goes up

# Step 2
predictTrain = predict(QualityLog, type="response")

summary(predictTrain)
str(predictTrain)

#so, we did it but did we do it right. Sure, Logistic Regression gives out all
# values between 0 and 1 but what's a good threshold value? The only challenge in 
# Logistic Regression is to pick a good threshold value! Over to whiteboard.
# Confusion matrix -> performance metrics, we try out various performance metrics 
# for various threshold values and plot ROC curve and then choose a good looking
# threshold

# Confusion matrix for threshold of 0.5. First argument or what we want to label 
# the rows by should be actual outcome, 2nd argument what we want to label the columns
# by prediction values - will return true if our prediction is greater than 0.5 and
# false otherwise
table(qualityTrain$PoorCare, predictTrain > 0.5)

#   FALSE TRUE
# 0    70    4
# 1    15   10 

# 1 and TRUE means bad care
# the number 70 specifies actual good care cases for which we also predicted good care
# 4 means they were actually good care but we predicted poor care
# 15 means actual bad care and we say good care
# 10 means actual bad care and we say bad care

table(qualityTrain$PoorCare)
 
# Sensitivity and specificity
8/25
73/74

# Confusion matrix for threshold of 0.2
table(qualityTrain$PoorCare, predictTrain > 0.2)

# Sensitivity and specificity
16/25
54/74

# Install and load ROCR package
install.packages("ROCR")
library(ROCR)

# to make an ROC curve one needs actual values and predicted values, both are given below.
# These functions will do the groupings on their own (p > 0.2, etc.) like we were doing above
ROCRpred = prediction(predictTrain, qualityTrain$PoorCare)

# Performance function
ROCRperf = performance(ROCRpred, "tpr", "fpr")

# Plot ROC curve
plot(ROCRperf)

# Add colors
plot(ROCRperf, colorize=TRUE)

# Add threshold labels 
plot(ROCRperf, colorize=TRUE, print.cutoffs.at=seq(0,1,by=0.1), text.adj=c(-0.2,1.7))