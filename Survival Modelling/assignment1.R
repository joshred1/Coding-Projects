#load packages
library(ggplot2)
library(ggpubr)
par(mar=c(5.1, 4.1, 4.1, 2.1))
setwd("C:/Users/Joshua/Desktop/Joshua's Files/Australian National University/4th year/Semester 1/STAT3032 - Survival Models/Assignments/Assignment 1")

#5.
lifetbl = read.csv("C:/Users/Joshua/Desktop/Joshua's Files/Australian National University/4th year/Semester 1/STAT3032 - Survival Models/Assignments/Assignment 1/fltper_1x1_edited.txt", sep="")

#6.
head(lifetbl)

#7.
lifetbl = lifetbl[lifetbl$Year == 1943,]

#8.
class(lifetbl$Age) #we want age to be numeric
lifetbl$Age2 = lifetbl$Age #create new column duplicating age value
lifetbl$Age2[lifetbl$Age2 == "110+"] = 110
lifetbl$Age2 = as.numeric(lifetbl$Age2)
class((lifetbl$Age2)) #check that age is now numeric

#9.
attach(lifetbl)

plt = ggplot(lifetbl, aes(x = Age2, y = lx/1000))
plt = plt+geom_point(shape = 19, colour = "lightcoral", alpha = 0.5)
plt = plt+labs(x = "Age", y = "Lives (1000s)")
plt = plt+ggtitle("Survival Function", subtitle = "Australian Females, 1943")
plt = plt+theme_light()
plt
ggsave(filename = "survival.png", dpi = 1200)

#10. # mu approx. qx
plt = ggplot(lifetbl, aes(x = Age2, y = qx))
plt = plt+geom_point(shape = 19, colour = "#00BA38", alpha = 0.5)
plt = plt+labs(x = "Age", y = "Hazard Rate")
plt = plt+ggtitle("Force of Mortality", subtitle = "Australian Females, 1943")
plt = plt+theme_light()
plt
ggsave(filename = "hazard.png", dpi = 1200)

#11.
#Curtate expectations of life:
sum(lx[-1])/lx[1]
sum(lx[29:111])/lx[28]

#12. mu approx. qx
gompertz = lm(log(qx) ~ Age2)
summary(gompertz)
anova(gompertz)

#log linear scale
plt1 = ggplot(lifetbl, aes(x = Age2, y = qx))
plt1 = plt1+ scale_y_continuous(trans = "log", labels=scales::number_format(accuracy = 0.01))
plt1 = plt1+geom_smooth(method=lm , color="#C77CFF", fill="#C77CFF", se=TRUE, size = 0.5)
plt1 = plt1+geom_point(shape = 19, colour = "#E7861B", alpha = 0.3, size = 1)
plt1 = plt1+labs(x = "Age", y = "Log Hazard Rate")
plt1 = plt1+theme_light(base_size = 10)

#transformed back to original scale #include legend or caption explaining this
plt2 = ggplot(lifetbl, aes(x = Age2, y = qx))
plt2 = plt2+labs(x = "Age", y = "Hazard Rate")
plt2 = plt2+theme_light(base_size = 10)

x0 = seq(from = 0, to = 110)

CI = predict(gompertz, newdata = data.frame(Age2 = x0), interval = "confidence") #takes in gompertz model and stores o5% confidence interval over discrete x0 steps

plt2 = plt2+geom_ribbon(aes(ymin = exp(CI[,2]), ymax = exp(CI[,3]), fill = "95% Confidence Intervals"), alpha = 0.3)
plt2 = plt2+geom_line(aes(y = exp(CI[,1]), size = "Gompertz Model"), colour = "#C77CFF")
plt2 = plt2+scale_fill_manual(values = c("#C77CFF","#00BFC4"))
plt2 = plt2+scale_size_manual(values = 0.5)
plt2 = plt2+geom_point(shape = 19, colour = "#E7861B", alpha = 0.3, size = 1)
plt2 = plt2+theme(legend.title = element_blank(), plot.title = element_text(hjust = 0.5), legend.position = "bottom")
  
figure = ggarrange(plt1, plt2, ncol=2, nrow=1, common.legend = TRUE, legend="bottom")
title = expression(atop("Force of Mortality", scriptstyle("Australian Females, 1943")))
annotate_figure(figure, top = text_grob(title, size = 12))
ggsave(filename = "gompertz.png", dpi = 1200)

#13.
plt = ggplot(gompertz, aes(x = gompertz$fitted.values, y = gompertz$residuals))
plt = plt+geom_hline(yintercept = 0, color = "#F876DD" , size = 1)
plt = plt+geom_point(shape = 19, colour = "#00C0B8", alpha = 0.5)
plt = plt+labs(x = "Fitted Values", y = "Residuals")
plt = plt+ggtitle("Force of Mortality", subtitle = "Australian Females, 1943")
plt = plt+theme_light()
plt
ggsave(filename = "residuals.png", dpi = 1200)

#looking at CI, there is not a 95% of true value staying within interval. cant be correct. quadratic or cubic may be appropriate fit. data too closely packed, almost like they follow the line which yes overemphasises correlation but shows a dependence
