setwd("C:/Users/Joshua/Desktop/Joshua's Files/Australian National University/4th year/Semester 1/STAT3032 - Survival Models/Assignments/Assignment 2")  
library(survival)
library(ggplot2)
library(extrafont)
library(survminer)
font_import()
loadfonts(device = "win")
attach(survdata)  

#Exploratory data analysis
survival = data.frame(sex, time, death)
sum(death) #total no. of deaths
length(death) - sum(death) #total no. of censored observations
sum(death[sex=="female"]) #female deaths
sum(death[sex=="male"]) #male deaths
summary(survival) 
head(survival)

#frequency chart
barplt = ggplot(data=survival, aes(factor(death), fill=sex)) + theme_light()
barplt = barplt + xlab("") + coord_flip()
barplt = barplt + geom_bar(alpha=0.5, position=position_dodge()) 
barplt = barplt + scale_x_discrete(labels=c("censored","death"))
barplt = barplt + theme(text=element_text(family="serif"))
barplt = barplt + theme(plot.title=element_text(size=24, hjust=0.5))
barplt = barplt + theme(axis.text.x=element_text(size=12))
barplt = barplt + theme(axis.text.y=element_text(size=18))
barplt = barplt + theme(axis.title.x=element_text(size=18))
barplt = barplt + theme(axis.title.y=element_text(size=18))
barplt = barplt + theme(legend.text=element_text(size=14))
barplt = barplt + theme(legend.title=element_text(size=16))
barplt
ggsave(filename="barplt.png", dpi=1200)

#boxplot 
bxplt = ggplot(data=survival, aes(x=factor(death), y=time, fill=sex))
bxplt = bxplt + geom_boxplot(alpha=0.5, lwd=0.5) + theme_light()
bxplt = bxplt + ggtitle("Time Since Operation") 
bxplt = bxplt + xlab("") + ylab("time (years)")
bxplt = bxplt + scale_x_discrete(labels=c("censored","death"))
bxplt = bxplt + theme(text=element_text(family="serif"))
bxplt = bxplt + theme(plot.title=element_text(size=18, hjust=0.5))
bxplt = bxplt + theme(axis.text.x=element_text(size=16))
bxplt = bxplt + theme(axis.title.y=element_text(size=16))
bxplt = bxplt + theme(axis.text.y=element_text(size=12))
bxplt = bxplt + theme(legend.text=element_text(size=14))
bxplt = bxplt + theme(legend.title=element_text(size=16))
bxplt
ggsave(filename="bxplt.png", dpi=1200)
  
#KM estimation model
km.fit = survfit(Surv(time, death) ~ sex, data=survival)
km.fit #summary statistics
survdiff(Surv(time, death) ~ sex, rho=0) #log rank test

#Survival distribution
kmplt = ggsurvplot(km.fit, data=survival, risk.table=TRUE, conf.int=TRUE, xlab="time (years)", alpha=0.5, ylab="S(t)", risk.table.y.text.col=T, risk.table.height=0.20, risk.table.y.text=FALSE, tables.theme=theme_cleantable(), legend.labs=c("female", "male"), legend.title="Sex", ggtheme=theme_light(base_size=14, base_family="serif"), font.family="serif")
kmplt$plot = kmplt$plot + labs(title="Kaplan-Meier Survival Function")
kmplt
ggsave(filename="kmplt.png", dpi=1200, print(kmplt))

#Cox proportional hazards model
cox.model = coxph(Surv(time, death)~sex, data=survival)
summary(cox.model) #likelihood ratio test
anova(cox.model)

cox = survfit(cox.model, newdata = data.frame(sex =c("female","male")))
plot(cox)

coxplt = ggsurvplot(cox, data=survival, conf.int=TRUE, xlab="time (years)", alpha=0.5, ylab="S(t)", legend.labs=c("female", "male"), legend.title="Sex", ggtheme=theme_light(base_size=14, base_family="serif"), font.family="serif")
coxplt$plot = coxplt$plot + labs(title="Cox Regression Survival Function")
coxplt
ggsave(filename="coxplt.png", dpi=1200, print(coxplt))

