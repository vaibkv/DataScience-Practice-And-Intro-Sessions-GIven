#R5

#Functions - created using function() directive and are fist class obnjects under the class 'function', 
#can be passed as arguments to other objects, can be nested, etc.

# 1. By default, they return the last expression evaluated in the function
# 2. Functions can have 'named' arguments which can have 'default' values
# 3. Lazy evaluation of arguments - arguments are evaluated only when they are needed

#example
f = function(a,b) 
{
  a^2
}

f(2)

#The "..." arguments  (variable number of arguments)
#example 1 - passing varargs to some other function inside the body

myplot = function(x,y,type="1",...)
{
  plot(x,y,type=type,...)
  
}

#example 2 - when the number of arguments is not known in advance
args(paste)
paste(1,2,"er")

args(cat)

z = 5

#Scoping Rules
f = function(x,y)
{
  x^2 + y/z
}

f(2,3)

#where is the value of Z coming from? Z is a free variable. z is searched in environment of f, 
#then global environment(workspace). So, if a value of a var is not found in the envirnment then 
#the search is continued in parent environments. Environmnts are k,v pairs like contexts in javascript.

#Closure example
make.power = function(n)
{
  
  pow = function(x)
  {
    x^n
  }
  pow
}

cube = make.power(3)
square = make.power(2)

cube(3)
square(3)

#It's called a closure becase after the call make.power(3), make.power is out scope but we've still got a 
#reference to pow

#.RHistory file in your working directory

#What we have not covered

#1. Control structures - if, else, while, for loops, switch, repeat, next, etc.
#2. How to make your own packages

#Brief discussion of control structures