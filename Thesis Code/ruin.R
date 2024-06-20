library(statmod)
#simulate IG process
sim_IG = function(tmax, dt, mu, sigma) {
  t = seq(0, tmax, dt) 
  dG = rinvgauss(n = tmax/dt, mean = mu*dt/sigma, shape = (sigma*dt)^2)
  InvGauss = append(0, cumsum(dG))
  return(stepfun(t[-1], InvGauss))
}
set.seed(0)
mu = 1; sigma = 0.1; tmax = 50; dt = 0.01
plot(sim_IG(tmax, dt, mu, sigma), do.points = "FALSE")
plot(rinvgauss(n = tmax/dt, mean = alpha*dt/zeta, shape = (alpha*dt)^2), type = "l")

#simulate ruin process (exponential claims)
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
  dG = rgamma(n = tmax/dt, shape = alpha*dt, scale = beta)
  dN = rpois(n = length(dG), lambda = lambda*dG)
  claims = 0
  for (i in 1:length(dN)) {
    if (dN[i] == 0) {
      claims = append(claims, 0)
    } else {
      claims = append(claims, sum(rexp(dN[i], rate = 1/mu)))
    }
  }
  surplus = cumsum(exp(nu*Gt)*(1 - nu/beta)^(alpha*t)*claims)
  ruin = u0 + lambda*mu*alpha*(1+theta)*t/beta - surplus
  return(stepfun(t[-1], ruin))
}

#run simulation
runs = 20
set.seed(0)
plot(ruin3(80, 0.001, 3, 500, 1, 1, 0.1, 0, 10000), do.points = "FALSE", 
     xlim = c(1,49), ylim = c(-30000,50000), xlab = "t", ylab = "U(t)")
pb1 = txtProgressBar(min = 0, max = runs, style = 3) #progress completion bar
for (i in 1:max) {
  setTxtProgressBar(pb1, i)
  set.seed(i)
  U = ruin3(80, 0.001, 3, 500, 1, 1, 0.1, 0, 10000)
  lines(U, do.points = "FALSE")
}
close(pb1)
abline(h = 0, col = "red")

#probability of ruin in finite time:
#runs = number of runs to compute (higher -> greater accuracy)
#time (vector) at which ruin is checked (0<=by<=tmax)
ruin_prob = function(tmax, dt, lambda, mu, alpha, beta, nu, theta, u0, runs, 
                     by) {
  outcome = c()
  U_set = c()
  pb1 = txtProgressBar(min = 0, max = runs, style = 3) #progress completion bar
  for (i in 1:runs) {
    setTxtProgressBar(pb1, i)
    set.seed(i)
    U_set = append(U_set, ruin3(tmax, dt, lambda, mu, alpha, beta, nu, theta, 
                                u0))
  }  
  close(pb1)
  pb2 = txtProgressBar(min = 0, max = length(by), style = 3)
  for (i in 1:length(by)) {
    setTxtProgressBar(pb2, i)
    obs = c()
    for (j in 1:length(U_set)) {
      U = U_set[[j]]
      if (any(U(by[1:i]) <= 0)) {
        obs = append(obs, 1)
      } else {
        obs = append(obs, 0)
      }
    }
    outcome = append(outcome, sum(obs)/length(obs))
  }
  close(pb2)
  return(outcome)
}

prob = ruin_prob(50, 0.001, 3, 500, 1, 1, 0.1, 0.1, 10000, 1000, 
                 seq(0, 50, 0.1))
plot(prob ~ seq(0, 50, 0.1), type = "l", xlab = "t", ylab = "Prob. of Ruin")
#in the literature, the exact probability of ultimate ruin (tmax -> infinity) 
#for Cramer-Lundberg is given by:
#exp(-theta*u0/(mu*(1 + theta)))/(1 + theta) = 0.14756 for the set parameters
abline(h = exp(-0.1*10000/(500*(1 + 0.1)))/(1 + 0.1), col = "red")
