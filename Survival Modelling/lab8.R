#Q1
x_a = c(17.4, 17.0, 17.9, 18.1, 17.0, 17.6, 18.1, 17.1, 17.5, 18.1)
x_delta = c(17.8, 18.2, 19.1, 18.2, 20.0, 17.9, 999, 999, 19.6, 18.7)
x_b = c(20.3, 20.4, 19.4, 20.5, 21, 18.4, 21, 20.1, 19.7, 18.8)
#change NA to large no. as these are censored 

data = data.frame(x_a,x_delta,x_b)

data18 = subset(data, x_delta >= 18)

#a. 
a = pmax(data18$x_a, 18); b = pmin(data18$x_b, 19); T = pmin(data18$x_delta, b); V = T-a; delta = (T<b) 

sum.delta = sum(delta) #R recognises TRUE as 1 and FALSE as 0
sum.V = sum(V) #total wait

mu_hat = sum.delta/sum.V
se.mu = sqrt(sum.delta/(sum.V^2))

#Q2
entry = c(1997.5, 1998.4, 1997, 1999.1, 1997.2, 1997, 1997.8, 1997.5, 
          1998.5, 1999.1, 1999.2, 1998.7, 1998.8, 1997, 1999.5)
x = c(0.5, 0, 0, 0.3, 0.3, 0, 1.4, 0, 0, 2, 0.3, 1.9, 1.5, 1.6, 0)
died = c(9999, 1999.6, 1999.5, 1999.9, 1997.8, 1997.7, 1998.2, rep(9999,4), 1999.2, 1999.1, rep(9999,2))

#a.
operation = data.frame(entry, x, died)
operation2 = operation[-c(5,6,10,15),] #why these 4
x_a = operation2$entry - operation2$x + 1 #start of second year after operation
x_b = operation2$entry - operation2$x + 2 #end of second year after operation
a = pmax(operation2$x-1,0) + x_a #=entry, time patient started being observed during 2nd year.
b = pmin(x_b, 2000)
T = pmin(operation2$died, b)
V = T - a
delta = (T<b)

mu_hat = sum(delta)/sum(V)
se.mu_hat = sum(delta)/(sum(V)^2)

#b. 
exp(-mu_hat*0.5)
