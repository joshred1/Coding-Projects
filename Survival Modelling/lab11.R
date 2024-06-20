library(splines)

#1. 
x1 <- c(0, 2.1, 0.5, 1, 4, 1.5, 1.9, 2, 2.5, 3)
y1 <- c(4, 6, 2, 4.5, 7, 3, 8, 4, 6, 5)
plot(x,y)

#2.
set.seed(123)
x<-seq(0,4,by=0.05)
y<-sin(4*x)+rnorm(length(x),0,1/3)
plot(x,y)

#normal kernel smoothing
fit1 = ksmooth(x,y,kernel = "normal", bandwidth = 0.25)
lines(fit1, col = "red")

#cubic spline
fit2 = lm(y~ns(x,df=12))
values = seq(0,4,0.01)
temp = data.frame("x" = values)
y.fit2 = predict(fit2, temp)
lines(y.fit2~values, col = "blue")
AIC(fit2)
BIC(fit2)
#both are high values indicating poor fit

#triangle kernel smoothing
triangle_smooth = function(xt,x,y,b){
  y_tri = c()
  for (i in 1:length(xt)){
    t = abs(xt[i]-x)/b
    k_tri = 2-4*abs(t)
    k_tri[k_tri<0] = 0
    w_tri = k_tri/sum(k_tri)
    y_tri[i] = sum(w_tri*y)
  }
  return(y_tri)
}
y.fit3 = triangle_smooth(values,x,y,0.75)
lines(y.fit3~values, col = "green")
