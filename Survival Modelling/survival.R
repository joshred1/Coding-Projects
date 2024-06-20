library(RcmdrPlugin.survival)
data(Rossi)
full = coxph(formula = Surv(week,arrest) ~ fin+age+race+wexp+mar+prio, data = Rossi)
null = coxph(formula = Surv(week,arrest) ~ 1, data = Rossi) 
#this is also known as the null model since we aren't comparing covariate, we assume those beta's are all zero.

summary(full)
summary(null)
anova(null,full)

null1 = coxph(formula = Surv(week,arrest) ~ fin+age+wexp+prio, data = Rossi) 
anova(null1,full)
