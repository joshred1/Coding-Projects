#n array excluding 0
#t in [t1,t2]
preBM = function(n,t1,t2){
  t = seq(t1,t2,(t2-t1)/100)
  
  #identify max and min of B(t), generate plot
  set.seed(0)
  Xj = rnorm(1)*t/sqrt(pi)
  for (j in seq(1,tail(n,1))){
    set.seed(j)
    Xj = Xj+sqrt(2/pi)*sin(j*t)*rnorm(1)/j 
  }
  plot(t,Xj,type='l',xlim=c(t1,t2),ylim=c(min(Xj)-0.5,max(Xj)+0.5),ylab='B(t)')
  
  #plot each remaining fourier series
  set.seed(0)
  Xj = rnorm(1)*t/sqrt(pi)
  lines(t,Xj)
  for (elem in n[-length(n)]){
    for (j in seq(1,elem)){
      set.seed(j)
      Xj = Xj+sqrt(2/pi)*sin(j*t)*rnorm(1)/j 
    }
    lines(t,Xj)
  }
}

preBM(c(1,2,3,1000),0,pi)

#n array excluding 0
interpBM = function(n,t1,t2){
  t = seq(t1,t2,(t2-t1)/100)
  
  #identify max and min of B(t), generate plot
  Yj = t*0
  for (tk in seq(1,length(t))){
    set.seed(0) 
    #select the floor(nt)+1 Z value from the vector of Z
    Yj[tk] = (t[tk]-floor(tail(n,1)*t[tk]))*rnorm(floor(tail(n,1)*t[tk])+1)[floor(tail(n,1)*t[tk])+1]/sqrt(tail(n,1)) + 
      sum(rnorm(floor(tail(n,1)*t[tk])))/sqrt(tail(n,1)) 
  }
  plot(t,Yj,type='l',xlim=c(t1,t2),ylim=c(min(Yj)-0.5,max(Yj)+0.5),ylab='B(t)')
  
  #plot each remaining  series
  lines(t,0*t)
  for (elem in n[-length(n)]){
    Yj = t*0
    for (tk in seq(1,length(t))){
      set.seed(0) 
      #select the floor(nt)+1 Z value from the vector of Z
      Yj[tk] = (t[tk]-floor(tail(n,1)*t[tk]))*rnorm(floor(elem*t[tk])+1)[floor(elem*t[tk])+1]/sqrt(elem) + 
        sum(rnorm(floor(elem*t[tk])))/sqrt(elem) 
    }
    lines(t,Yj)
  }
}

interpBM(c(1,2,3,1000),0,pi)
