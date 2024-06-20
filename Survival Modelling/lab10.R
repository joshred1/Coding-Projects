w10q1 <- read.csv("C:/Users/Joshua/Desktop/Joshua's Files/Australian National University/4th year/Semester 1/STAT3032 - Survival Models/Labs/w10q1.csv")

#q1
#chi square test
X2 = sum(w10q1$Chi.Square)
df = nrow(w10q1)
1-pchisq(X2,df)
#fail to reject null, and so we accept the null (graduation rates are similar to actual rates)

#sign test
X = sum(sign(w10q1$Deviation)==1)
k = nrow(w10q1)
binom.test(X,k,p=0.5, alternative = "two.sided", conf.level = 0.95)
#fail to reject null

#runs test
l = diff(sign(w10q1$Deviation))
X1 = sum(l!=0) 
mu = 2*X*(k-X)/k + 1
var = (mu-1)*(mu-2)/(k-1)
pnorm(X1, mean = mu, sd = sqrt(var)) #one-sided test
#non significant under 5% CI but very close

#2.
age = c(60,61,62,63,64)
death = c(450,550,525,700,650)
qx = 1/(1 + exp(-(-10.9 + 0.11*age)))
chsq = (35000*qx - death)^2/(35000*qx)
T = sum(chsq)
1-pchisq(T, length(age)-2)
