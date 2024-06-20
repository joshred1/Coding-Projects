setwd("C:/Users/Joshua/Desktop/Joshua's Files/Australian National University/4th year/Semester 1/STAT3057 - Risk Modelling 1/Assignments/Assignment1")

Claims <- read.csv("Assign1Claims.csv", header = FALSE)
Claims <- Claims$V1

#1a.

dGB2 <- function(x, sigma, theta, alpha1, alpha2){
  numerator <- (x/theta)^(alpha2/sigma)
  b <- beta(alpha1, alpha2)
  denominator <- x*sigma*(1+(x/theta)^(1/sigma))^(alpha1 + alpha2)*b
  return(numerator/denominator)
}

dGB2(100,2,5,6,2)

#1c.

loglikeGB2 <- function(sigma, theta, alpha1, alpha2){
  return(sum(log(dGB2(Claims, sigma, theta, alpha1, alpha2))))
}

loglikeGB2(2,5,6,2)

#1d.
#optim minimises the objective function, and so we must minimise the -log likelihood function
neglogL <- function(inputs){
  return(-loglikeGB2(inputs[1],inputs[2],inputs[3],inputs[4]))
}

inputs <- c(1,1,1,1)

optim(par = inputs, fn = neglogL, method = c("L-BFGS-B"), lower = 0.01, upper = 100)

#1e.

LN_claims <- rlnorm(Claims)
chisq.test(Claims,p = LN_claims/sum(LN_claims))  

Obs<-NULL; Bin <- NULL
Bin[1] <- 0
for(i in 1:29){
  Bin[i+1] <- qlnorm(i/30, meanlog = 7.5, sdlog = 1.7)
}

Exp <- length(Claims)/30

for(i in 1:29){
  Obs[i] <- length(Claims[Claims>=Bin[i] & Claims<Bin[i+1]])
}

Obs[30]<-length(Claims)-sum(Obs[1:29])

#Chi-square test statistic:
X2<-sum((Obs-Exp)^2/Exp)
X2

#Corresponding p-value:
1-pchisq(X2,df=27)

#2a.
hist(x = log(Claims), breaks = 100)
abline(v = log(20000), col = "red")

#2bi.
length(Claims[Claims>20000])/length(Claims)

#2bii.
Reduced_Claims = Claims
Reduced_Claims[Reduced_Claims>20000] <- 20000
(sd(Reduced_Claims)-sd(Claims))/sd(Claims)

#2biii.
Reinsured_Claims = Claims[Claims>20000] -20000
mean(Reinsured_Claims)
