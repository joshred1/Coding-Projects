Q4data <-  read.table("C:/Users/Joshua/Desktop/Joshua's Files/Australian National University/4th year/Semester 1/STAT3057 - Risk Modelling 1/Assignments/Assignment 3/Assign3Q4_Data.csv", quote="\"", comment.char="")

library(tseries)
library(forecast)
attach(Q4data)
plot(V1, type = "l",xlab = "time (weeks)", ylab = "Price ($ per litre)", main = "Weekly Oil Prices")

#Test for stationarity (Augmented Dickey-Fuller Test):
adf.test(V1, k=1) #fail to reject null
adf.test(V1, k=2) #successfully reject null and conclude stationarity

#differenced series plot:
par(mfrow=c(1,1))
plot(diff(V1,lag = 1), type = "l", xlab = "time (weeks)", ylab = "Differenced Price", main = "Second Order Differenced Prices" )

#Model fitting:
summary(auto.arima(V1))

#Correlograms for differenced series 
par(mfrow=c(1,2))
acf(diff(V1, lag = 1), main = "")
pacf(diff(V1, lag = 1), main = "")

#Diagnostics
par(mfrow=c(1,1))
fit = arima(V1, order = c(3,1,2))
tsdiag(fit, gof.lag = 30)
qqnorm(fit$residuals)
qqline(fit$residuals)

