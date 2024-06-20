#1
setwd("C:/Users/Joshua/Desktop/Joshua's Files/Australian National University/4th year/Semester 1/STAT3032 - Survival Models/Labs")   

#2
males = read.csv("males_2005-07.csv",header = TRUE)
attach(males)

#3
plot(x= Age, y = lx/1000, ylab = "Lives (1000s)", main = "Survival Function", 
     type = "l")

#4
plot(x= Age, y= log(mux), ylab = "log mu_x", type = "l")

#5
plot(x= Age, y= log(mux))
gompertz = lm(log(mux) ~ Age)
abline(gompertz)
summary(gompertz)

#6
#H0: mu_x is constant
#H1: mu_x isn't constant
#p-value ~ 0 -> reject H0.

#7.
plot(gompertz, which = 1)
plot(x = Age[2:110], gompertz$residuals)
plot(gompertz$fitted.values, gompertz$residuals)
#apparent dependence between residuals, non-constant variance
