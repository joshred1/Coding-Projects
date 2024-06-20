#1.
library(survival)
head(ovarian)

#2. 
km.est = survfit(Surv(ovarian$futime, ovarian$fustat)~1, conf.type = "plain" ) #~1 indicates that groups arent separated.
#0 is censored, 1 is time of death
summary(km.est)
plot(km.est)

#3.
km.est2 = survfit(Surv(ovarian$futime)~1, conf.type = "plain" )
lines(km.est2, col = "red") #plots regardless of censoring (i.e assume 0 is time of death also)

#4.
km.est3 = survfit(Surv(ovarian$futime[ovarian$fustat==1])~1, conf.type = "plain" )
lines(km.est3, col = "blue") #disregard times whose death is censored

#5.
km.log = survfit(Surv(ovarian$futime, ovarian$fustat)~1, conf.type = "log" )

km.loglog = survfit(Surv(ovarian$futime, ovarian$fustat)~1, conf.type = "log-log" )

plot(km.est)
lines(km.log, col = "red")
lines(km.loglog, col = "blue")

#6.
km.est.rx = survfit(Surv(ovarian$futime, ovarian$fustat)~ovarian$rx, conf.type = "plain" ) 
summary(km.est.rx)
plot(km.est.rx[1])
lines(km.est.rx[2], col = "red")
legend(x = 0, y = 0.3, legend = c("group 1","group 2"), fill = c("black", "red"))

#7. 
survdiff(Surv(ovarian$futime, ovarian$fustat)~ovarian$rx, rho = 0)
