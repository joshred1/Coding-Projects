library(progress)
library(plotly)
library(MASS)

mc_baccarat = function(T){
  B = c()
  B[1] = 0
  for(j in 2:(T+1)){
    B[j] = sample(c(ifelse(B[j-1]<=0, 0.95, B[j-1]+0.95), B[j-1], ifelse(B[j-1]<=0, B[j-1]-1, -1)), size = 1, prob = c(0.4585, 0.0953, 0.4462))
  }
  return(B)
}

game_baccarat = function(V0=100,K=1,T=V0/K,R=0.5,g="fib"){
  n_won = 0
  n_tied = 0
  n_lost = 0
  V = c()
  V[1] = V0
  B = mc_baccarat(T)
  Fib = function(x){
    return((1.618034^x)/sqrt(5))
  }
  Nara = function(x){
    return(0.611492*1.465571^x)
  }
  print(c("bankroll at time", 0, V[1]))
  for(j in 2:(T+1)){
    Delta_Bj = B[j]-B[j-1]
    if(g == "mg"){
      V[j] = V[j-1]+K*round(max(1, 2^(B[j-1]-1)))*ifelse(Delta_Bj == 0, 0, ifelse(Delta_Bj<0, -1, 0.95))
    }else if(g == "flat"){
      V[j] = V[j-1]+K*ifelse(Delta_Bj == 0, 0, ifelse(Delta_Bj<0, -1, 0.95))
    }else if(g == "fib"){
      V[j] = V[j-1]+K*round(Fib(1+max(0, B[j-1])))*ifelse(Delta_Bj == 0, 0, ifelse(Delta_Bj<0, -1, 0.95))
    }else if(g == "cows"){
      V[j] = V[j-1]+K*round(Nara(max(0, B[j-1])))*ifelse(Delta_Bj == 0, 0, ifelse(Delta_Bj<0, -1, 0.95))
    }else{
      break
    }
    print(c("money staked at time", j-1, K*round(Fib(1+max(0,B[j-1])))))
    if(Delta_Bj>0){
      print("hand won")
      n_won = n_won+1
    }else if(Delta_Bj==0){
      print("hand pushed")
      n_tied = n_tied+1
    }else{
      print("hand lost")
      n_lost = n_lost+1
    }
    if(V[j]>=(1+R)*V0){
      print(c("bankroll at time", j-1, V[j]))
      print("gambler has beat the game.")
      break
    }else if(V[j]>0){
      print(c("bankroll at time", j-1, V[j])) 
    }else{
      print("gambler is bankrupt.")
      break
    }
  }
  print(c("ROI (%):", ifelse(min(V)<=0, "-100", ifelse(max(V)>=(1+R)*V0, (max(V)-V0)/V0*100, (V[T+1]-V0)/V0*100)), "hands won:", n_won, ",hands tied:", n_tied, ",hands lost:", n_lost))
  plot(stepfun(x = c(1:(length(V)-1)), y = V), do.points = FALSE, ylim = c(0,max(V)), xlab = "t", ylab = "V_t", main = "Bankroll during a game of Baccarat")
}

sim_baccarat = function(V0=100,K=1,T=V0/K,g="fib",N=1000,k=150){
  n = 1
  V_coords = rep(0, T)
  t_coords = 1:T
  Fib = function(x){
    return((1.618034^x)/sqrt(5))
  }
  Nara = function(x){
    return(0.611492*1.465571^x)
  }
  pb = progress_bar$new(
    format = "[:bar] :percent ETA: :eta",
    total = N
  )
  while(n<=N){
    V = c()
    V[1] = V0
    V_coords = append(V_coords, V0)
    t_coords = append(t_coords, 0)
    B = mc_baccarat(T)
    for(j in 2:(T+1)){
      Delta_Bj = B[j]-B[j-1]
      if(g == "mg"){
        V[j] = V[j-1]+K*round(max(1, 2^(B[j-1]-1)))*ifelse(Delta_Bj == 0, 0, ifelse(Delta_Bj<0, -1, 0.95))
      }else if(g == "flat"){
        V[j] = V[j-1]+K*ifelse(Delta_Bj == 0, 0, ifelse(Delta_Bj<0, -1, 0.95))
      }else if(g == "fib"){
        V[j] = V[j-1]+K*round(Fib(1+max(0, B[j-1])))*ifelse(Delta_Bj == 0, 0, ifelse(Delta_Bj<0, -1, 0.95))
      }else if(g == "cows"){
        V[j] = V[j-1]+K*round(Nara(max(0, B[j-1])))*ifelse(Delta_Bj == 0, 0, ifelse(Delta_Bj<0, -1, 0.95))
      }else{
        break
      }
      V_coords = append(V_coords, V[j])
      t_coords = append(t_coords, j-1)
      if(V[j]<=0 | V[j] >= 1.5*V0){
        break
      }
    }
    pb$tick()
    n = n+1
  }
  data = data.frame(t = t_coords, V = V_coords)
  kd = kde2d(x = data$t, y = data$V, n = k)
  contour = plot_ly(x = kd$x, y = kd$y, z = t(kd$z)*N/max(kd$z), type = "heatmap", colorscale = "Viridis") %>%
    layout(xaxis = list(title = "t"),
           yaxis = list(title = "V", range = c(0, 1.5*V0)), font = list(size = 32))
  surface = plot_ly(x = kd$x, y = kd$y, z = t(kd$z)*N/max(kd$z), type = "surface", colorscale = "Viridis", lighting = list(diffuse = 0.1, specular = 0.4, roughness = 0.45)) %>%
    layout(scene = list(xaxis = list(title = "t"),
                        yaxis = list(title = "V", range = c(0, 1.5*V0)),                                           
                        zaxis = list(title = ""), font = list(size = 32))) 
  return(list(contour, surface))
}

V0 = 20 #initial bankroll
K=1 #minimum wager
T = 500 #number of hands played
R=0.5 #target return
g="mg" #strategy played: fib, mg, flat, cows.
N=1000 #number of simulations
k=350 #kernel smoothing parameter

set.seed(123) 
par(mfrow = c(1,1))
plot(stepfun(x = c(1:20), y = mc_baccarat(20), right = TRUE), do.points = TRUE, 
     pch = 16, xlab = "t", ylab = "B_t", 
     main = "Streak trajectory during a game of Baccarat")
game_baccarat(V0,K,T,R,g)
sim_baccarat(V0,K,T,g,N,k)

