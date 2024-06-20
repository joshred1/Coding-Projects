#1.
library(survival)

km.est = survfit(Surv(ovarian$futime, ovarian$fustat)~1)
na.est = survfit(Surv(ovarian$futime, ovarian$fustat)~1, type = "fleming-harrington")

#2.
data.frame(km.est$surv, na.est$surv)
plot(km.est, col = "blue")
lines(na.est, col = "red")
#these two estimates are actually asymptotically equivalent.

#3a.
head(rats)
attach(rats)

km.est1 = survfit(Surv(time, status) ~ sex)
summary(km.est1)
plot(km.est1[1], col = "blue")
lines(km.est1[2], col = "red")
legend("bottomleft", legend = c("female", "male"), fill = c("blue","red"))
survdiff(Surv(time, status) ~ sex, rho = 0)
#rho = 0 returns log-rank test result. We conclude significant difference between the two groups.

#3b.
na.est1 = survfit(Surv(time, status) ~ rx, type = "fleming-harrington")
summary(na.est1)
plot(na.est1[1], col = "blue")
lines(na.est1[2], col = "red")
legend("bottomleft", legend = c("control", "treatment"), fill = c("red","blue"))
survdiff(Surv(time,status) ~ rx, rho = 0)
#under 0.05 significance level, treatment is significantly different.

#4.
#Treatment Group
t1 = c(6,7,10,13,16,23) #time to rejection
d1 = c(2,1,1,1,1,1) #number rejected at t
r1 = c(18,15,13,10,9,6) #number at risk at t
p1 = (r1-d1)/r1; var.logp1 = d1/(r1*(r1-d1))
s1 = rep(NA,6); s1[1] = p1[1]
for (k in 2:6){
  s1[k] = s1[k-1]*p1[k]
}
var.logs1 = rep(NA,6); var.logs1[1] = var.logp1[1]
for (k in 2:6){
  var.logs1[k] = var.logp1[k-1] + var.logp1[k]
}
sd.s1 = s1*sqrt(var.logs1)
CIu1 = s1 + 1.96*sd.s1
CIl1 = s1 - 1.96*sd.s1
CIu1 = pmin(CIu1,1)
kmtable1 = data.frame(t1, r1, d1, s1, sd.s1, CIl1, CIu1)

time1 =  c(6,6,7,10,13,16,23,6,9,11,12,19,20,25,30,32,32,35)
status1 = c(rep(1,7),rep(0,11))
km.est.1 = survfit(Surv(time1, status1) ~ 1, conf.type = "plain")
summary(km.est.1)
kmtable1

#Control Group
time2 =  c(1,1,2,3,5,5,8,9,9,10,10,11,12,18,25,3,4,9)
status2 = c(rep(1,length(time2)-3),rep(0,3))
km.est.2 = survfit(Surv(time2, status2) ~ 1, conf.type = "plain")
summary(km.est.2)
plot(km.est.1, col = "red")
lines(km.est.2, col = "blue")
legend("bottomleft", legend = c("treatment","control"), fill = c("red","blue"))
