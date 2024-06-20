Claims <- read.table("C:/Users/Joshua/Desktop/Joshua's Files/Australian National University/4th year/Semester 1/STAT3057 - Risk Modelling 1/Assignments/Assignment 2/Assign2Claims.csv", quote="\"", comment.char="")
library(fExtremes)
library(moments)

#1d.
S = rep(0,100000)
for(k in 1:100000){ 
  Sa = 0
  Sb = 0
  for(i in 1:200){
    Sa = Sa + runif(1,0,400)*rbinom(1,1,0.03) 
  }
  for(i in 1:300){
    Sb = Sb + runif(1,0,300)*rbinom(1,1,0.05)
  }
  S[k] = Sa + Sb
}
plot(density(S), main = "Density of Simulated Aggregate Claims", ylab = "f(s)")
length(S[S>5000])/length(S)


#3a.
gpdFit(x = Claims, u = 0.97, type = "mle")

u = quantile(Claims$V1,0.97)
u
te = Claims[Claims>u]-u #threshold exceedances
fMLE = function(params){
  f = 1/params[1]*((1+params[2]*te/params[1])^-(1/params[2]+1))
  lnf = log(f)
  sum(-lnf)
}

MLE = nlm(fMLE,c(3000,1))
MLE$estimate
MLE$code

#3b.
hist(te, freq=FALSE, xlab="Threshold Exceedances",
     main="Histogram versus Fitted GPD Distribution",breaks = 50)
x = seq(from=min(te),to=max(te))
beta = MLE$estimate[1]; xi =  MLE$estimate[2]
GPD = 1/beta*(1+xi*x/beta)^-(1/xi+1)
lines(x,GPD,col="red")

#3c.
plot(ecdf(te), pch = 20, lty = 0, main = "Empirical versus Fitted Cumulative Distribution Function")
CDF = 1-(1+xi*x/beta)^-(1/xi)
lines(x,CDF,col="red")

#3d.
Exp = dim(Claims)[1]/100
Obs = NULL
min(Exp) > 5 #check expected count  
bin = NULL; bin[1] = 0
for(i in 1:99){
  bin[i+1] = qgpd(i/100,xi=MLE$estimate[2],
                 mu=0,beta=MLE$estimate[1])
}
for(i in 1:99){
  Obs[i] = length(Claims[Claims>bin[i] & Claims<bin[i+1]])
}
Obs[100] = length(Claims)-sum(Obs[1:99])

X2 = sum((Obs-Exp)^2/Exp)

1-pchisq(X2,df=97)
