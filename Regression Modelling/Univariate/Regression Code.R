##STAT2008 ASSIGNMENT##
#1a. 
oldfaithful <- read.csv("C:/Users/Joshua/Desktop/Australian National University/2nd year/Semester 1/STAT2008- Regression Modelling/Assignments/oldfaithful.csv")
attach(oldfaithful)
library(ggplot2)

ggplot(oldfaithful, aes(x = Duration, y = Interval))+geom_point(shape = 19, colour = 'lightcoral', size = 3, alpha = 0.5)+labs(x = 'Duration (seconds)', y= 'Interval Time (minutes)')+ggtitle('Relationship Between Eruption Duration and Time Before Next Eruption', subtitle = 'Old Faithful Geyser, October 1980')+theme_light()
cor.test(x = Duration, y = Interval, conf.level = 0.95)

#1b. 
lm.oldfaithful <- lm(Interval ~ Duration)
par(mfrow= c(2, 2))
plot(lm.oldfaithful, which = c(1,2))
plot(hatvalues(lm.oldfaithful), type = 'h', ylab = 'Leverage Scores', xlab = 'Obs. number', main = 'Leverage Plot of the Hat Values', font.main = 1, ylim = c(0, 0.02))
abline(h = 2 * sum(hatvalues(lm.oldfaithful)) / length(Duration), col = 'red')
plot(lm.oldfaithful, which = 4)

#1c.
anova(lm.oldfaithful)

#1d. 
summary(lm.oldfaithful)

#1e. 
par(mfrow= c(1,1))
prediction1 <- predict(lm.oldfaithful, newdata = data.frame(Duration = 120), interval = 'prediction', level = 0.95)
prediction1

#ggplot2:
prediction1 <- predict(lm.oldfaithful, newdata = data.frame(Duration = 120), interval = 'prediction', level = 0.95)
interval.predict <- predict(lm.oldfaithful, newdata = data.frame(Duration), interval = 'prediction', level = 0.95)
lma <- ggplot(oldfaithful, aes(x = Duration, y = Interval))+labs(x = 'Duration (seconds)', y= 'Interval Time (minutes)')+ggtitle('Relationship Between Eruption Duration and Time Before Next Eruption', subtitle = 'Old Faithful Geyser, October 1980')+theme_light()+geom_segment(aes(x = 120, y = prediction1[,2], xend = 120, yend = prediction1[,3], size = 'Selected 95% Prediction Interval'), colour = 'firebrick', alpha = 0.5)
lmb <- lma+geom_ribbon(aes(ymin = interval.predict[,2], ymax = interval.predict[,3], fill = '95% Prediction Intervals'), alpha = 0.2)+geom_line(aes(y = interval.predict[,2]), colour = '#F8766D')+geom_line(aes(y = interval.predict[,3]), colour = '#F8766D')+geom_smooth(method = lm, se = F, aes(colour = 'SLR Model'))
lmc <- lmb+geom_point(shape = 19, colour = '#00BFC4', alpha = 0.5, size = 3)+scale_fill_manual(values = '#F8766D')+scale_size_manual(values = 2)+scale_colour_manual(values = 'midnightblue')+theme(legend.title = element_blank(), legend.position = 'bottom')
lmc

#2a.
advertising <- read.csv("C:/Users/Joshua/Desktop/Australian National University/2nd year/Semester 1/STAT2008- Regression Modelling/Assignments/advertising.csv")
attach(advertising)

ggplot(advertising, aes(x = spend, y = return))+geom_point(shape = 19, colour = '#00BA38', size = 4, alpha = 0.5)+ylab('Retained Impressions per Week (millions)')+xlab('Advertising Expenditure ($ millions)')+ggtitle('Relationship Between Amount Spent on Advertising and its Impression on the Audience')+theme_light()
cor.test(x = spend, y = return)

advertising.lm <- lm(return ~ spend)
summary(advertising.lm)

par(mfrow= c(3,3))

case1 <- lm(return ~ spend)
plot(return ~ spend, pch = 19, main = round(cor(spend, return), 4), font.main = 3, sub = 'Model 1', font.sub = 2)
abline(case1, col = 'red', lwd = 3)

case2 <- lm(log(return) ~ spend)
plot(log(return) ~ spend, pch = 19, main = round(cor(spend, log(return)), 4), font.main = 3, sub = 'Model 2', font.sub = 2)
abline(case2, col = 'red', lwd = 3)

case3 <- lm(log(return) ~ log(spend))
plot(log(return) ~ log(spend), pch = 19, col = 'blue', main = round(cor(log(spend), log(return)), 4), font.main = 2, cex.main = 1.5, sub = 'Model 3', font.sub = 2)
abline(case3, col = 'red', lwd = 3)

case4 <- lm(return ~ log(spend))
plot(return ~ log(spend), pch = 19, main = round(cor(log(spend), return), 4), font.main = 3, sub = 'Model 4', font.sub = 2)
abline(case4, col = 'red', lwd = 3)

case5 <- lm(sqrt(return) ~ spend)
plot(sqrt(return) ~ spend, pch = 19, main = round(cor(spend, sqrt(return)), 4), font.main = 3, sub = 'Model 5', font.sub = 2)
abline(case5, col = 'red', lwd = 3)

case6 <- lm(sqrt(return) ~ sqrt(spend))
plot(sqrt(return) ~ sqrt(spend), pch =19, main = round(cor(sqrt(spend), sqrt(return)), 4), font.main = 3, sub = 'Model 6', font.sub = 2)
abline(case6, col = 'red', lwd = 3)

case7 <- lm(return ~ sqrt(spend))
plot(return ~ sqrt(spend), pch = 19, main = round(cor(sqrt(spend), return), 4), font.main = 3, sub = 'Model 7', font.sub = 2)
abline(case7, col = 'red', lwd = 3)

case8 <- lm(log(return) ~ sqrt(spend))
plot(log(return) ~ sqrt(spend), pch = 19, main = round(cor(sqrt(spend), log(return)), 4), font.main = 3, sub = 'Model 8', font.sub = 2)
abline(case8, col = 'red', lwd = 3)

case9 <- lm(sqrt(return) ~ log(spend))
plot(sqrt(return) ~ log(spend), pch = 19, col = 'blue', main = round(cor(log(spend), sqrt(return)), 4), font.main = 2, cex.main = 1.5, sub = 'Model 9', font.sub = 2)
abline(case9, col = 'red', lwd = 3)

par(mfrow = c(1,2))
plot(case3$fitted.values, case3$residuals, pch = 19, xlab = 'Fitted Values', ylab = 'Residuals', main = 'Model 3', font.main = 1)
abline(h = 0, lty = 2)
plot(case9$fitted.values, case9$residuals, pch = 19, xlab = 'Fitted Values', ylab = 'Residuals', main = 'Model 9', font.main = 1)
abline(h = 0, lty = 2)

#2b. 
par(mfrow= c(1,1))
ggplot(advertising, aes(x = log(spend), y = log(return)))+geom_point(shape = 19, colour = '#00BFC4', size = 4, alpha = 0.4)+ylab('Log of Retained Impressions per Week (millions)')+xlab('Log of Advertising Expenditure ($ millions)')+ggtitle('Relationship Between Amount Spent on Advertising\n and its Impression on the Audience')+geom_smooth(method = lm, col = '#619CFF', se = F)+theme_light()

par(mfrow= c(2, 2))
plot(case3, which = c(1,2))
plot(hatvalues(case3), type = 'h', ylab = 'Leverage Scores', xlab = 'Obs. number', main = 'Leverage Plot\n of the Hat Values', font.main = 1)
abline(h = 2 * sum(hatvalues(case3)) / length(spend), col = 'red')
plot(case3, which = 4)

#2c.
anova(case3)

#2d.
b0 <- case3$coefficients[1]
b1 <- case3$coefficients[2]
curve(expr = b1*exp(b0)*(x)^(b1-1), xlab = 'Advertising Expenditure ($ millions)', main = 'Change in Retained Impressions per Week (millions)', ylab = 'df/dX')

#R base graphics:
par(mfrow= c(1,1))
case3 <- lm(log(return) ~ log(spend))
plot(return ~ spend, xlab = 'Advertising Expenditure ($ millions)', ylab = 'Retained Impressions per Week (millions)', main = 'Relationship Between Amount Spent on Advertising\n and its Impression on the Audience', pch = 20)
x0 <- seq(from = 0, to = 200, by = length(spend)/20)
pred.intervals <- predict(case3, newdata = data.frame(spend = x0), interval = 'prediction')
conf.intervals <- predict(case3, newdata = data.frame(spend = x0), interval = 'confidence')
lines(x = x0, y = exp(pred.intervals[,1]), lty = 1, lwd = 1.5)
lines(x = x0, y = exp(pred.intervals[,2]), lty = 3, lwd = 1.5)
lines(x = x0, y = exp(pred.intervals[,3]), lty = 3, lwd = 1.5)
lines(x = x0, y = exp(conf.intervals[,2]), lty = 2, lwd = 1.5)
lines(x = x0, y = exp(conf.intervals[,3]), lty = 2, lwd = 1.5)
legend(x = c(130,200), y = c(0,20),lty = c(1,2,3), legend = c('SLR Model', '95% Confidence Intervals', '95% Prediction Intervals'), bty = 'n')

#ggplot2:
pred.intervals <- predict(case3, newdata = data.frame(spend), interval = 'prediction')
conf.intervals <- predict(case3, newdata = data.frame(spend), interval = 'confidence')
lm1 <- ggplot(advertising, aes(x = spend, y = return))+ylab('Retained Impressions per Week (millions)')+xlab('Advertising Expenditure ($ millions)')+ggtitle('Relationship Between Amount Spent on Advertising\n and its Impression on the Audience')+theme_light()
lm2 <- lm1+geom_ribbon(aes(ymin = exp(pred.intervals[,2]), ymax = exp(pred.intervals[,3]), fill = '95% Prediction Intervals'), alpha = 0.2)+geom_line(aes(y = exp(pred.intervals[,2])), colour = '#F8766D')+geom_line(aes(y = exp(pred.intervals[,3])), colour = '#F8766D')
lm3 <- lm2+geom_ribbon(aes(ymin = exp(conf.intervals[,2]), ymax = exp(conf.intervals[,3]), fill = '95% Confidence Intervals'), alpha = 0.3)+geom_line(aes(y = exp(conf.intervals[,2])), colour = '#C77CFF')+geom_line(aes(y = exp(conf.intervals[,3])), colour = '#C77CFF')
lm4 <- lm3+geom_line(aes(y = exp(pred.intervals[,1]), size = 'SLR Model'), colour = '#7CAE00')+geom_point(shape = 19, colour = '#00BFC4', size = 4, alpha = 0.5)
lm5 <- lm4+scale_fill_manual(values = c('#C77CFF','#F8766D'))+scale_size_manual(values = 1)+theme(legend.title = element_blank(), plot.title = element_text(hjust = 0.5), legend.position = 'bottom')
lm5

