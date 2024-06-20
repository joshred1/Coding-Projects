#1.
head(veteran)
library(survival)
attach(veteran)

#2.
km.fit = survfit(Surv(time, status)~1, type = "kaplan-meier")
summary(km.fit)
plot(km.fit, xlab = "t", ylab = "S(t)", main = "KM Estimation", col = "red")

#3.
na.fit = survfit(Surv(time, status)~trt, type = "fh2")
summary(na.fit)
plot(na.fit[1], xlab = "t", ylab = "S(t)", main = "Modified NA Estimation",col = "red")
lines(na.fit[2], col = "blue")
legend("topright", legend = c("standard", "test"), fill = c("red","blue"))
survdiff(Surv(time, status)~trt, rho = 0)
#cannot reject the hypothesis, and so accept that there is no significant difference between the treatment groups.

#4.
cox.fit = coxph(Surv(time,status)~ trt + celltype + karno + diagtime + age + prior)
summary(cox.fit)
#R recognises celltype as a categorical variable but fails to recognise treatment or prior as categorical. We fix this:
cox.fit = coxph(Surv(time,status)~ factor(trt) + factor(celltype) + karno + diagtime + age + factor(prior))
summary(cox.fit)

#a. p>0.05 so treatment is not significant

#b.
#small and adino cells are significantly different from the #baseline cell time, but large cell type is not. 

#c. all else equal, a small cell will increase hazard wrt baseline cell time by a factor of 2.367.

#d. cox regression compares categorical covariates, coxph can compare continuous covariates. Coxph models hazard function, KM estimation models survival function. Survival functions from Coxph can never cross, unlike in KM estimation.