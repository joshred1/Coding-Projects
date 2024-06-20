#Appendix B
R code for plot in Part 2.1
library(Sim.DiffProc)
par(mfrow=c(1,1))
Xt = expression(2*(2<t)*(t<=4)-(5<t)*(t<=6))
Y = st.int(expr = Xt, lower = 0, upper = 8, type = "ito")
plot(Y, xlab="t", ylab="")
X = function(t){
  2*(2<t)*(t<=4)-(5<t)*(t<=6)
}
t=seq(0,8,0.01)
lines(t, X(t), lty=2 , col="red")
legend("bottomright", legend=c("Y(t)", "X(t)"), col=c("black", "red"), lty
       =1:2, cex=1, bty="n", inset=-.08)

#Appendix C
R code for plot in Part 2.2
t=seq(0,8,0.01)
Var = function(t){
  4*max(2,min(4,t))+max(5,min(6,t))-13
}
vart = t
for (i in 1:length(t)){
  vart[i] = Var(t[i])
}
plot(t, vart, type="l", ylab="c(t,t)", main="Variance Function of Y")
Appendix D
R code for plot in Part 2.5
t=seq(0,8,0.01)
s=seq(0,8,0.01)
Cov = function(s,t){
  4*max(2,min(4,s,t))+max(5,min(6,s,t))-13
}
covst = matrix(0, nrow=length(s), ncol=length(t))
for (i in 1:length(s)){
  for (j in 1:length(t)){
    10
    covst[i,j] = Cov(s[i],t[j])
  }
}
persp(s, t, covst, xlab="s", ylab="t", zlab="c(s,t)", main="Covariance
   Function of Y", phi=20, theta=30, col="red", shade=0.7, border=NA)