#R4
#reading WHO.csv

WHO = read.csv("WHO.csv")
class(WHO)
str(WHO) #structure of the object

summary(WHO) #statistical summary of the data

# Number of observations for factors, For numerical values we see minimum, maximum, 1st Quartile, 3rd Quartile,
# mean and median and number of NA's'

# Let's define some basic statistical values and their meaning
# 
# 1. Mean - average
# 2. Median (2nd quartile) - sort data. If odd number then middle value is median otherwise the mean of two middle values
# 3. Mode - value that appears most often in the set
# Quartile - three points that divide the data into 4 equal sets (talking about sorted data)
# 4. 1st Quartile - number between median and smallest number
# 5. 3rd Quartile - number between median and highest value
#interquartile range and outliers
# 6. Standard Deviation - take difference of each data point from mean, add the squares of all these values, divide by N-1, take root
# 7. Z-Score -> x - mean / sd
# 8. Normal distribution curve - talk about heights 100k men

#let's draw a box-plot in R
boxplot(WHO$Under15)

#standard deviation
sd(WHO$Under15)

#Subsetting
WHO_Europe = subset(WHO,Region == "Europe") #WHO, where clause

str(WHO_Europe) #53 observations as found in original summary

#writing to a csv
write.csv(WHO_Europe,"WHO_Europe.csv")

#clearing stuff from memory - limitation of R
ls()

rm(WHO_Europe)

ls()

#let's play around with our data more and look at some variable in the set and some basic statistics
WHO$Under15
mean(WHO$Under15)
sd(WHO$Under15)
summary(WHO$Under15) #which country has only 13.12% population under 15? which one?

which.min(WHO$Under15) #gives row number

WHO$Country[86]

WHO$Country[which.max(WHO$Under15)] #which country has max % of population under 15

#let's see how income vs fertility rate is related
plot(WHO$GNI,WHO$FertilityRate) #observation and outlier, let's see which country has high income and high fertility rate

Outliers = subset(WHO,GNI > 10000 & FertilityRate > 2.5)
nrow(Outliers)

Outliers[c("Country","GNI","FertilityRate")] #i only want these following vectors

#histogram
hist(WHO$CellularSubscribers) #number of cellular subscribers by country frequency

#now let's compare life expectancy numbers be region using boxplots
boxplot(WHO$LifeExpectancy ~ WHO$Region, xlab = "Region", ylab = "Life Expectancy", main = "Life Expectancies by Region")

#tapply - another useful function from loop functions (apply, tapply, lapply, saaply, mapply)
#tapply(arg1, arg2, function) - group arg1 by arg2 and apply the function on each group

tapply(WHO$Over60,WHO$Region,mean)

tapply(WHO$LiteracyRate,WHO$Region,min)

tapply(WHO$LiteracyRate,WHO$Region,min,na.rm=TRUE)