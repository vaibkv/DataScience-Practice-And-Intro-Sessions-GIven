#R7
#Linear Regression - just to play around with your brains

car = read.csv("CarData.csv")
str(car)
summary(car)

#let's first only use Mileage
model1 = lm(Price ~ Mileage, data=car,na.rm=TRUE)

summary(model1)

#explain the various terms in the summary, low R-squared - not very good model, high value of theta does not
#mean greater significance of variable

#std. error = what is the likely spread of estimate across the residuals
#t-value = estimate/std error, larger the better
#p-value = probability that the variable is insignificant, we want it to be less than 0.05

plot(car$Price ~ car$Mileage)
abline(model1,col="red") #line of best fit

#SSE
model1$residuals
SSE = sum(model1$residuals ^ 2)

#another model #how to interpret data when Make is not a number
model2 = lm(Price ~ Mileage + Liter + Make, data=car)

summary(model2)

model3 = lm(Price ~ Mileage + Liter, data=car)

summary(model3)

cor(car)