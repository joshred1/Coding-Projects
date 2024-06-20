#1a.
time = c(5,9,4,8,6,15,13,1,2)
event = c(1,1,1,1,1,0,1,0,1)
hospital = c(0,0,1,1,1,1,1,0,0)

library(survival)

#b.
cox.model = coxph(Surv(time,event)~hospital)
summary(cox.model)

#2a.
Rossi = read.table("http://socserv.mcmaster.ca/jfox/Books/Companion/data/Rossi.txt", header = TRUE)
attach(Rossi) 

#b.
cox.rossi = coxph(Surv(week,arrest) ~ fin + age + mar + prio + race)
summary(cox.rossi)

#c.
cox.rossi2 = coxph(Surv(week,arrest) ~ fin + age + I(age^2) + mar + prio + race)
summary(cox.rossi2)

#d.
indivA = c(1,23,23^2,0,1,2)
indivB = c(0,26,26^2,0,0,0)
beta = cox.rossi2$coefficients
exp(beta%*%(indivA - indivB)) #hazard ratio

#e.
exp(beta%*%c(0,0,0,0,2,0)) #c() represents indivA-indivB.
x = c(beta[5] - 1.96*0.027367  , beta[5] + 1.96*0.027367) #95% CI for beta[5]
exp(2*x)

se = sqrt((0.027367^2)*2*exp(beta[5])^2)
c(exp(2*beta[5]) - 1.96*se, exp(2*beta[5]) + 1.96*se) #using delta method

#f.
# var(exp(beta[1])) = var(beta[1])*exp(beta[1])^2
se = sqrt((0.191009^2)*exp(beta[1])^2)
c(exp(beta[1]) - 1.96*se, exp(beta[1]) + 1.96*se)

y = c(beta[1] - 1.96*0.191009  , beta[1] + 1.96*0.191009) #95% CI for beta[1]
exp(y)

#g.
#no statistical significant evidence suggesting marital status affects time till first arrest.

#h.
#positive coefficient suggests that the relative risk/hazard of an increase in number of prior convictions increases by 10.51%. 

#i.
cox.rossi3 = coxph(Surv(week,arrest) ~ age + prio)
summary(cox.rossi3)
ts = -2*(cox.rossi3$loglik[2] - cox.rossi2$loglik[2]) #likelihood ratio test
1 - pchisq(ts, df = 4)
#if not significant, conclude that smaller model is better as there is no statistically significant different between the models.

anova(cox.rossi3, cox.rossi2)
