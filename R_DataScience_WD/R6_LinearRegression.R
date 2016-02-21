#R6
#LinearRegression - estimate the price of wine

# Read in data
wine = read.csv("wine.csv")
str(wine)
summary(wine)

# Linear Regression (one variable) AGST = average growing season temperature
model1 = lm(Price ~ AGST, data=wine)
summary(model1)

#We sought out to find the line of best fit and we got an object? Well, yes - it 'is' the line of best fit.
#It has all defining characteristics of the line and much more!

#explain the various terms in the summary, low R-squared - not very good model, high value of theta does not
#mean greater significance of variable

#std. error = what is the likely spread of estimate across the residuals
#t-value = estimate/std error, larger the better
#p-value = probability that the variable is insignificant, we want it to be less than 0.05

# Sum of Squared Errors
model1$residuals
SSE = sum(model1$residuals^2)
SSE

# Linear Regression (two variables)
model2 = lm(Price ~ AGST + HarvestRain, data=wine)
summary(model2)

# Sum of Squared Errors
SSE = sum(model2$residuals^2)
SSE

# Linear Regression (all variables)
model3 = lm(Price ~ AGST + HarvestRain + WinterRain + Age + FrancePop, data=wine)
summary(model3)

# Sum of Squared Errors
SSE = sum(model3$residuals^2)
SSE

# Remove FrancePop - best model
model4 = lm(Price ~ AGST + HarvestRain + WinterRain + Age, data=wine)
summary(model4)

# Correlations
plot(wine$WinterRain, wine$Price)
plot(wine$Age, wine$FrancePop)

cor(wine$WinterRain, wine$Price)
cor(wine$Age, wine$FrancePop)
cor(wine)

# Remove Age and FrancePop
model5 = lm(Price ~ AGST + HarvestRain + WinterRain, data=wine)
summary(model5)

#Before we continue on predictions, let's see why multicollinearity is a bad thing
x1 = c(1,2,3,4,5)
x2 = c(2,4,6,8,10)
y = c(4,10,15,20,23)

multi_col_data = data.frame(x1,x2,y)

summary(multi_col_data)

multiCol_model = lm(y ~ x1 + x2,data=multi_col_data)
summary(multiCol_model)

#since x2 could be written as X1, its effect was redundant and R is not considering it!

#Now, let's change data a bit

x1 = c(1,2,3,4,5)
x2 = c(2,4,6,8,11.8)
y = c(4,10,15,20,23)

plot(x1 ~ x2)

multi_col_data = data.frame(x1,x2,y)

summary(multi_col_data)

multiCol_model = lm(y ~ x1 + x2,data=multi_col_data)

summary(multiCol_model)

#as you can see, high p-value for x2, but even if we ignore this it seems like we were able to still make a 
#model, earlier R was not even considering x2 when there was perfect collinearity but now the 
#collinearity is high (a soft case of perfect multicollinearity) and it's considering it! 
#Multicollinearity makes statistical packages go mad.

#Till now we've made the model, now it's time to predict some test values

# Read in test set
wineTest = read.csv("wine_test.csv")
str(wineTest)

# Make test set predictions
predictTest = predict(model4, newdata=wineTest)
predictTest

# Compute R-squared
SSE = sum((wineTest$Price - predictTest)^2)
SST = sum((wineTest$Price - mean(wine$Price))^2)
1 - SSE/SST

#R-sq is not charateristic of the model, it's characteristic of the data also

#Leftovbers
#- how logistic regression actually happens
#- add residual plotting and how to figure linear vs polynomial regression using data plotting
#- t-values revisit