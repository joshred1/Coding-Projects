sim_gp = function(tmax, dt, alpha, beta) {
  t = seq(0, tmax, dt)
  jumps = rgamma(tmax/dt, shape = alpha*dt, scale = beta)
  G = append(0, cumsum(jumps))
  return(stepfun(t[-1], G))
}

ruin3 = function(tmax, dt, lambda, mu, alpha, beta, nu, theta, u0, sigma) {
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
  ruin = u0 + lambda*mu*alpha*(1+theta)*t/beta + cumsum(rnorm(length(t), sd = sigma))- surplus
  return(stepfun(t[-1], ruin))
}
set.seed(1)
plot(ruin3(30, 0.001, 3, 500, 1, 1, 0.1, 0.1, 10000, 100), do.points = "FALSE")
plot(cumsum(rnorm(30/0.001, sd = 5)), type = "l")

