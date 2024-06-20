#generate a single run of the risk-reserve process

#tmax = right endpoint of time interval
#dt = increment size for random walk (smaller -> greater accuracy)
#lambda = claim arrival intensity parameter (lambda>0)
#mu = expected value of claim severity (mu>0)
#alpha = shape parameter of gp (alpha>0)
#beta = scale parameter of gp (beta>0)
#nu = parameter of mgf (0<nu<beta)
#theta = premium loading (theta>0)
#u0 = initial surplus of reserves (u0>0)


sim_ruin = function(tmax, dt, lambda, mu, alpha, beta, nu, theta, u0) {
  t = seq(0, tmax, dt) 
  #generate vector of jumps in gamma-time representative of global risk: 
  dG = rgamma(n = tmax/dt, shape = alpha*dt, scale = beta) 
  #generate the gamma-subordinated poisson process:
  dN = rpois(n = length(dG), lambda = lambda*dG) 
  #generate the gamma process:
  G = append(0, cumsum(dG))
  #generate vector of claim sizes (if no claim occurs, size = 0):
  claims = 0 #at time 0, no claim occurs
  for (i in 1:length(dN)) { 
    if (dN[i] == 0) {
      claims = append(claims, 0) 
    } else {
      claims = append(claims, sum(rexp(dN[i], rate = 1/mu)))
    }
  }
  #scale claim size according to gamma-exponential martingale "risk factor" wrt time of claim occurrence:
  surplus = cumsum(exp(nu*G)*(1 - nu/beta)^(alpha*t)*claims) 
  ruin = u0 + lambda*mu*alpha*(1+theta)*t/beta - surplus 
  return(stepfun(t[-1], ruin)) 
}


plot(sim_ruin(80, 0.001, 3, 500, 1, 1, 0.1, 0, 10000), do.points = "FALSE", 
     xlab = "t", ylab = "U(t)", main = "")


sim_ruin1 = function(tmax, dt, lambda, mu, alpha, beta, nu, theta, u0) {
  t = seq(0, tmax, dt)
  y = alpha*(nu/beta + log(1-nu/beta))
  surplus = cumsum(mu*lambda*alpha*(exp(t*y) - 1)/(beta*y) + 
    (lambda*alpha/beta)*(1 + lambda*alpha)*(t*exp(2*t*y)/2 + 
    (1 - exp(2*t*y))/(4*y^2))*append(0, rnorm(n = tmax/dt)))
  ruin = u0 + lambda*mu*alpha*(1+theta)*t/beta - surplus 
  return(stepfun(t[-1], ruin)) 
}
