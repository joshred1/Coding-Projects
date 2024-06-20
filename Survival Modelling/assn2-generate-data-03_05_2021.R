########################################
# Generate data for assignment 2
########################################

set.seed(6665828+3)  # insert your student number here plus 3 without the "u",
 #  e.g. if your student number is u1234567, then run set.seed(1234570)

#########################################
# Generate survival data
#########################################

N <- 200
survdata <- data.frame(ID=c(1:N),sex=rep(c("male","female"),times=N/2))
beta <- runif(1,min=-0.5,max=0.5)
survdata$stime <- rexp(N,rate=exp(-1+beta/2*(survdata$sex=="female")-beta/2*(survdata$sex=="male")))
survdata$censoring.cutoff <- runif(N,min=0.2,max=10)
survdata$time <- pmin(survdata$stime,survdata$censoring.cutoff)
survdata$death <- 1*(survdata$stime<survdata$censoring.cutoff)

write.csv(survdata[,c("ID","sex","time","death")],file="assn2-survdata.csv",row.names=FALSE)

