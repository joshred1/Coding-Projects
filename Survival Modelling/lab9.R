#1.
library(msm)
help(msm)

#2.
head(cav)
help(cav)
mydata = cav[,c(1,3,8)]

#3.
help(statetable.msm)
mydata.states = statetable.msm(state = state, subject = PTNUM, data = mydata)
mydata.states
#we can identify that state 4 is an absorbing state (death).

#4. #X(t) t years, X state, matrix isn't square so we must specify the absorbing state, and supply constraints/initial values for qmatrix
mydata.msm = msm(formula = state ~ years, subject = PTNUM, data = mydata, deathexact = 4, qmatrix = rbind(c(0, 0.1, 0, 0.1), 
                                                                                                          c(0.1, 0, 0.1, 0.1), 
                                                                                                          c(0, 0.1, 0, 0.1),
                                                                                                          c(0, 0, 0, 0)))

qmatrix.msm(mydata.msm) #intensity matrix
for (k in 1:10){
  print(pmatrix.msm(mydata.msm, t = k))
}

#4. #cuts time into periods 0-10, 10-15, 15-infty
mydata.msm1 = msm(formula = state ~ years, subject = PTNUM, data = mydata, deathexact = 4, pci = c(10,15), qmatrix = rbind(c(0, 0.1, 0, 0.1), 
                                                                                                          c(0.1, 0, 0.1, 0.1), 
                                                                                                          c(0, 0.1, 0, 0.1),
                                                                                                          c(0, 0, 0, 0)))

qmatrix.msm(mydata.msm1, covariates = list(timeperiod = "[-Inf,10)")) 
qmatrix.msm(mydata.msm1, covariates = list(timeperiod = "[10,15)")) 
qmatrix.msm(mydata.msm1, covariates = list(timeperiod = "[15,Inf)")) 
for (k in 1:20){
  print(pmatrix.msm(mydata.msm1, t = k))
}
