#i.
a = 2 #alpha>0
b = 5 #beta>0 
s = 4 #sigma>0
dt = 0.5
t = seq(0,20,dt) 

#ii.
delta = b*dt #shape parameter
n = 100
G = rgamma(n,delta)

#iii.
Z = rnorm(n,0,s^2)

#iv.
dL = Z*sqrt(G/a)

#v.
k = seq(1,n-1)
L_tk = rep(0,n-1)
for (i in 2:length(k)){
  L_tk[i+1] = sum(dL[1:i])
}
plot(L_tk, type = "s")
