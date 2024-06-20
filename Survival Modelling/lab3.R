#1.
t = c(1.56, 0.99, 1.37, 1.03, 0.86, 0.61, 3.25, 0.16, 2.23, 0.77, 0.81, 1.50,
      2.22, 2.10, 1.41, 0.19, 2.10, 2.68, 1.61, 1.21)

#(negative) log-likelihood function:
logL = function(alpha){
  -sum(log((alpha^2)*t*exp(-alpha*t)))
}

#optimise log-likelihood:
MLE = optim(par = 1, fn = logL, method = "BFGS")


#2. 
D2.logL = -2*length(t)/MLE$par^2
Var = -1/D2.logL

#3.
F.nonparametric = ecdf(t)
plot(F.nonparametric)

#4.
F.parametric = function(x){
  1 - exp(-MLE$par*x) - MLE$par*x*exp(-MLE$par*x)
}
curve(expr = F.parametric, from = 0, to = 4, lty = 2, col = 'red', add = TRUE)

#5. 
legend(0,1, legend = c('parametric cdf', 'non-parametric cdf'), col = c('black', 'red'), lty = c(1,2))

#6. 
1 - F.nonparametric(3)
1 - F.parametric(3)

#variance = F(t)*(1-F(t))/n for non-parametric estimate. Note variance of 1-F(t)
#is the same as variance of F(3).
(F.nonparametric(3)*(1-F.nonparametric(3)))/length(t)
