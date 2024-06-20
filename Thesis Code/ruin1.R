library(doParallel)
library(foreach)
library(ggplot2)


#simulate poisson process 
sim_pp = function(tmax, dt, lambda) {
  t = seq(0, tmax, dt)
  jumps = rpois(tmax/dt, lambda*dt)
  N = append(0, cumsum(jumps))
  return(stepfun(t[-1], N))
}


#simulate gamma process
sim_gp = function(tmax, dt, alpha, beta) {
  t = seq(0, tmax, dt)
  jumps = rgamma(tmax/dt, shape = alpha*dt, rate = beta)
  G = append(0, cumsum(jumps))
  return(stepfun(t[-1], G))
}

plot(sim_gp(50,0.001,3,3))
plot(rgamma(50/0.001, shape = 3*0.001, scale = 3), type = "l")
#simulate exponential martingale of gamma process
sim_expmg = function(tmax, dt, alpha, beta, nu) {
  t = seq(0, tmax, dt)
  jumps = rgamma(tmax/dt, shape = alpha*dt, scale = beta)
  G = append(0, cumsum(jumps))
  E = exp(nu*G)*(1 - nu/beta)^(alpha*t)
  return(stepfun(t[-1], E))
}


#simulate exponential claims compound poisson process 
sim_cpp = function(tmax, dt, lambda, mu) {
  pp = sim_pp(tmax, dt, lambda)
  t = append(0, knots(pp))
  claims = 0
  for (i in 2:length(t)) {
   if (pp(t[i]) - pp(t[i-1]) == 1) {
     claims = append(claims, rexp(1, rate = 1/mu))
   } else {
     claims = append(claims, 0)
   }
  }
  CPP = cumsum(claims)
  return(stepfun(t[-1], CPP))
}


#simulate exponential claims compound (gamma subordinated) poisson process 
sim_surplus = function(tmax, dt, lambda, mu, alpha, beta) {
  gp = sim_gp(tmax, dt, alpha, beta)
  Gt = c()
  t = append(0, knots(gp))
  for (i in 1:length(t)) {
    Gt = append(Gt, gp(t[i]))
  }
  dg = Gt[-1] - head(Gt, -1)
  arrival = rpois(length(dg), lambda*dg)
  claims = 0
  for (i in 1:length(arrival)) {
    if (arrival[i] == 0) {
      claims = append(claims, 0)
    } else {
      claims = append(claims, sum(rexp(arrival[i], rate = 1/mu)))
    }
  }
  surplus = cumsum(claims)
  return(stepfun(t[-1], surplus))
}


#simulate gamma correlated exponential claims 
#compound (gamma subordinated) poisson process 
sim_surplus1 = function(tmax, dt, lambda, mu, alpha, beta, nu) {
  gp = sim_gp(tmax, dt, alpha, beta)
  Gt = c()
  t = append(0, knots(gp))
  for (i in 1:length(t)) {
    Gt = append(Gt, gp(t[i]))
  }
  dg = Gt[-1] - head(Gt, -1)
  arrival = rpois(length(dg), lambda*dg)
  claims = 0
  for (i in 1:length(arrival)) {
    if (arrival[i] == 0) {
      claims = append(claims, 0)
    } else {
      claims = append(claims, sum(rexp(arrival[i], rate = 1/mu)))
    }
  }
  surplus = cumsum(exp(nu*Gt)*(1 - nu/beta)^(alpha*t)*claims)
  return(stepfun(t[-1], surplus))
}


#single-run simulations
set.seed(0)

ggplot(pp) +
  stat_function(geom="point", n=11, fun=dpois, args=list(1))

pp = sim_pp(10, 0.001, 3)
plot(stepfun(, pp), do.points = "TRUE", xlab = "t", ylab = "N(t)", main = "", pch = 16, verticals = FALSE)
p <- ggplot(data = data.frame(x = 0), mapping = aes(x = x))+ stat_function(fun = pp) + xlim(-5,5)
p

set.seed(1)

n <- 10
n.t <- cumsum(rexp(n))
x <- c(0,cumsum(rexp(n,5)))
plot(stepfun(n.t, x), xlab="t", ylab="N(t)", main="", do.points = TRUE,pch = 16,col.points = "black",verticals = FALSE)

gp = sim_gp(5000, 0.001, 1, 1)
plot(gp, do.points = "FALSE", xlab = "t", ylab = "G(t)")

expmg = sim_expmg(5000, 0.001, 1, 1, 0.1)
plot(expmg, do.points = "FALSE", xlab = "t", ylab = "expmg(t)")

cpp = sim_cpp(50, 0.001, 3, 500)
plot(cpp, do.points = "FALSE", xlab = "t", ylab = "C(t)")

ss = sim_surplus(50, 0.001, 3, 500, 1, 1)
plot(ss, do.points = "FALSE", xlab = "t", ylab = "S(t)")

ss1 = sim_surplus1(50, 0.001, 3, 500, 1, 1, 0.1)
plot(ss1, do.points = "FALSE", xlab = "t", ylab = "S1(t)")



set.seed(0)
plot(sim_expmg(50, 0.001, 1, 1, 0.1), do.points = "FALSE", xlim = c(0,50), 
     ylim = c(0,5))
for (i in 1:50) {
  set.seed(i)
  lines(sim_expmg(50, 0.001, 1, 1, 0.1), do.points = "FALSE")
}  


#combined simulations
iter = 100
set.seed(0)
s0 = sim_cpp(50, 0.001, 3, 500)
plot(s0, do.points = "FALSE", ylim = c(0,250000))
t = append(0, knots(s0))
mean_set1 = c()
mean_set2 = c()
mean_set3 = c()
registerDoParallel(cores = 8)
s_set1 = foreach (i = 1:iter, .combine = c) %dopar% {
  set.seed(i)
  sim_cpp(50, 0.001, 3, 500)
}
s_set2 = foreach (i = 1:iter, .combine = c) %dopar% {
  set.seed(i)
  sim_surplus(50, 0.001, 3, 500, 1, 1)
}
s_set3 = foreach (i = 1:iter, .combine = c) %dopar% {
  set.seed(i)
  sim_surplus1(50, 0.001, 3, 500, 1, 1, 0.1)
}
for (i in 1:length(s_set1)) {
  lines(s_set1[[i]], do.points = "FALSE")
  lines(s_set2[[i]], do.points = "FALSE", col = "blue")
  lines(s_set3[[i]], do.points = "FALSE", col = "red")
}
for (i in 1:length(t)) {
  obs_set1 = c()
  obs_set2 = c()
  obs_set3 = c()
  for (j in 1:length(s_set1)) {
    s1 = s_set1[[j]]
    s2 = s_set2[[j]]
    s3 = s_set3[[j]]
    obs_set1 = append(obs_set1, s1(t[i]))
    obs_set2 = append(obs_set2, s2(t[i]))
    obs_set3 = append(obs_set3, s3(t[i]))
  }
  mean_set1 = append(mean_set1, mean(obs_set1))
  mean_set2 = append(mean_set2, mean(obs_set2))
  mean_set3 = append(mean_set3, mean(obs_set3))
}
lines(mean_set1 ~ t, type = "l", col = "green", lwd = 5)
lines(mean_set2 ~ t, type = "l", col = "purple", lwd = 5)
lines(mean_set3 ~ t, type = "l", col = "orange", lwd = 5)


#Ruin processes
ruin1 = function(tmax, dt, lambda, mu, theta, u0) {
  pp = sim_pp(tmax, dt, lambda)
  t = append(0, knots(pp))
  claims = 0
  for (i in 2:length(t)) {
    if (pp(t[i]) - pp(t[i-1]) == 1) {
      claims = append(claims, rexp(1, rate = 1/mu))
    } else {
      claims = append(claims, 0)
    }
  }
  CPP = cumsum(claims)
  ruin = u0 + lambda*mu*(1+theta)*t - CPP
  return(stepfun(t[-1], ruin))
}

set.seed(0)
plot(ruin1(50, 0.001, 3, 500, 0, 10000), do.points = "FALSE", 
     xlim = c(1,49), ylim = c(-30000,50000))
for (i in 1:20) {
  set.seed(i)
  U = ruin1(50, 0.001, 3, 500, 0, 10000)
  lines(U, do.points = "FALSE")
}
abline(h = 0, col = "red")


ruin2 = function(tmax, dt, lambda, mu, alpha, beta, theta, u0) {
  gp = sim_gp(tmax, dt, alpha, beta)
  Gt = c()
  t = append(0, knots(gp))
  for (i in 1:length(t)) {
    Gt = append(Gt, gp(t[i]))
  }
  dg = Gt[-1] - head(Gt, -1)
  arrival = rpois(length(dg), lambda*dg)
  claims = 0
  for (i in 1:length(arrival)) {
    if (arrival[i] == 0) {
      claims = append(claims, 0)
    } else {
      claims = append(claims, sum(rexp(arrival[i], rate = 1/mu)))
    }
  }
  surplus = cumsum(claims)
  ruin = u0 + lambda*mu*alpha*(1+theta)*t/beta - surplus
  return(stepfun(t[-1], ruin))
}

set.seed(0)
plot(ruin2(50, 0.001, 3, 500, 1, 1, 0, 10000), do.points = "FALSE", 
     xlim = c(1,49), ylim = c(-30000,50000))
for (i in 1:20) {
  set.seed(i)
  U = ruin2(50, 0.001, 3, 500, 1, 1, 0, 10000)
  lines(U, do.points = "FALSE")
}
abline(h = 0, col = "red")


ruin3 = function(tmax, dt, lambda, mu, alpha, beta, nu, theta, u0) {
  gp = sim_gp(tmax, dt, alpha, beta)
  Gt = c()
  t = append(0, knots(gp))
  for (i in 1:length(t)) {
    Gt = append(Gt, gp(t[i]))
  }
  dg = Gt[-1] - head(Gt, -1)
  arrival = rpois(length(dg), lambda*dg)
  claims = 0
  for (i in 1:length(arrival)) {
    if (arrival[i] == 0) {
      claims = append(claims, 0)
    } else {
      claims = append(claims, sum(rexp(arrival[i], rate = 1/mu)))
    }
  }
  surplus = cumsum(exp(nu*Gt)*(1 - nu/beta)^(alpha*t)*claims)
  ruin = u0 + lambda*mu*alpha*(1+theta)*t/beta - surplus
  return(stepfun(t[-1], ruin))
}

set.seed(0)
plot(ruin3(80, 0.001, 3, 500, 1, 1, 0.1, 0, 10000), do.points = "FALSE", 
     xlim = c(1,49), ylim = c(-30000,50000))
for (i in 1:20) {
  set.seed(i)
  U = ruin3(50, 0.001, 3, 500, 1, 1, 0.1, 0, 10000)
  lines(U, do.points = "FALSE")
}
abline(h = 0, col = "red")
