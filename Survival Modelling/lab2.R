#2. 
library("MASS")
data("geyser")
head("geyser")

#3.
hist(geyser$waiting,freq=FALSE, xlab = "geyser waiting times (mins)", main = "")

#4.
curve(dexp(x,rate=1/mean(geyser$waiting)),col="red",lty=1,add=TRUE)

#5.
curve(dnorm(x,mean = mean(geyser$waiting),sd = sd(geyser$waiting)), col = 
        "blue", lty = 1, add = TRUE)

#7.
theoretical.dsn.sim <- rexp(n=10000,rate=1/mean(geyser$waiting))
qqplot(theoretical.dsn.sim,geyser$waiting, xlim = c(0,300), ylim = c(0,300))
abline(a = 0, b = 1)

#8.
qqnorm(y = geyser$waiting)
qqline(y = geyser$waiting)

#9. 
#normal fits better

#10.
censored.waiting = geyser$waiting #copy of data
censored.waiting[censored.waiting > 85] = 85
censored.waiting2 = geyser$waiting
censored.waiting2[censored.waiting2 > 85] = NA
mean(geyser$waiting)
mean(censored.waiting)
mean(censored.waiting2, na.rm = TRUE)
