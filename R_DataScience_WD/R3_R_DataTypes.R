#R3
#Some theory first

#Data Types in R  (atomic) [modes]

#1. Character
#2. Numeric (by defualt all numbers are double precision and real)
#3. Interger
#4. Complex
#5. Logical (T/F)

# Another most heavily used object - Vector 
# Most basic and default type of object, almost everything is a vector, even a scalar quantity is a vector of length 1

# Can contain objects of same class only (like our arrays, R has arrays also though). 
# Exception is List, which 'is a' vector by inheritance but can contain objects from different classes - 
# it's basic advantage


# Attributes (or properties) - Metadata for objects
# 
# Examples - class, length, dimentions (for matrices and arrays)

msg = "hello" #char vector
class(msg)
length(msg)

x = 1 #numeric vector
print (x) 

#lets's create a sequence, vector of integers, datatype of vector = 'integer'
x = 1:20
x
x[2] #second element of the vector

#Creating Vectors
# 1. c()        :combine function
# 2. vector()   :creates an empty vector populated with default values
# 3. seq()      :sequence

x = vector("numeric",length=10)
x

Sequence = seq(1,100,3)
Sequence

x = seg(1,100,2) #1 to 100 step = 2
print(x)

#what happens when we mix objects?
y = c(1.7,"a")  #coercion happens
y 

#Explicit coercion (or casting)
x = 0:6
class(x)

as.numeric(x)

as.logical(x)

as.character(x)

#Quick example with Data Frames (like matrices but each col can have different data type)
Country = c("India","US","France","Italy")
LifeExpectancy = c(57,76,72,64)

#but we want to put both our data in one object - let's use a data frame!
Data = data.frame(Country,LifeExpectancy)
Data

class(Data)

#adding columns to a data frame, let's add population  [cbind()]  ?cbind
Population = c(1.2,0.2,0.05,0.04)
Population

Data2 = cbind(Data,Population)
Data2

#adding rows to a data frame, let's add one more country [rbind()] ?rbind
Country = c("Aus","Canada")
LifeExpectancy = c(76,65)
Population = c(0.7,0.09)

DataFrameNew = data.frame(Country,LifeExpectancy,Population)
DataFrameNew

Data3 = rbind(Data2,DataFrameNew)
Data3

#Matrices - vectors with dimention (integer vector of length 2 - rows and cols) attribute
m = matrix(1:6,nrow=2,ncol=3) #fills column wise by deafult ! watch out!
m


dim(m)

#Lists - special type of vector
x = list(1,"a",T,1,1+4)
x

#Factors
x = factor(c("yes","yes","no","yes"))
x

table(x) #returns frequency for factor levels
?table

#Subsetting - operators that can be used to extract subsets of R objects

# 1. [  --> always returns an object of the same calss and so it can be used to select more than 1 element (returns by index as well as condition)
# 2. [[ --> used to extract elements of a list or data frame, single element extraction and element can be 
#       of any type. Very rarely used. Almost never (extracts by matching) (returns by index as well as condition)
# 3. $  --> same as [[ but name is used. Examples come later

#examples

x = c("a","b","c","d")
x[1]

x[1:4]

x[x > "a"]

#Subsetting example - Partial Matching
x = list(abc = 1:5,120)
x

x$a

x[["a"]]
x[["a",exact=FALSE]]

#Removing bad data
?NA

x = c(1,2,NA,4,NA)
bad = is.na(x)
x[!bad]