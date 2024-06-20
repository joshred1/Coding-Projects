#####Load the "Data" object into work space from the Data.r file
repPD_factors <- Data[445:786,27:30]
extPD_factors <- Data[787:1146,27:30]
repPD_returns <- Data[445:786,1:26]
extPD_returns <- Data[787:1146,1:26]

#convert to excess returns

repPD_excess <- sweep(repPD_returns[,2:26], 1, repPD_factors$RF, "-")
extPD_excess <- sweep(extPD_returns[,2:26], 1, extPD_factors$RF, "-")



###Replication Period###

#Table 2
m <- c()
s <- c()
t <- c()

for (i in 1:25)
{
m[i] <- mean(repPD_excess[,i])
s[i] <- sd(repPD_excess[,i])
t[i] <- m[i-1]/(s[i-1]/sqrt(342))
}

m_table <- matrix(m, nrow = 5, ncol = 5, byrow = T)
m_table <- rbind(c("Small","2","3","4","Big"), m_table)
rownames(m_table) <- c("Means","Low","2","3","4","High")

s_table <- matrix(s, nrow = 5, ncol = 5, byrow = T)
s_table <- rbind(c("Small","2","3","4","Big"), s_table)
rownames(s_table) <- c("Standard deviations","Low","2","3","4","High")

t_table <- matrix(t, nrow = 5, ncol = 5, byrow = T)
t_table <- rbind(c("Small","2","3","4","Big"), t_table)
rownames(t_table) <- c("t-statistics for means","Low","2","3","4","High")

table2 <- rbind(m_table, s_table, t_table)
table2

#Table 4
b <- c()
tb <- c()
r2 <- c()
se <- c()

for (i in 1:25)
{
  b[i] <- summary(lm(repPD_excess[,i]~repPD_factors$Mkt.RF))$coefficients[2,1]
  tb[i] <- summary(lm(repPD_excess[,i]~repPD_factors$Mkt.RF))$coefficients[2,3]
  se[i] <- summary(lm(repPD_excess[,i]~repPD_factors$Mkt.RF))$coefficients[2,2]
  r2[i] <- summary(lm(repPD_excess[,i]~repPD_factors$Mkt.RF))$adj.r.squared
}

b_table <- matrix(b, nrow = 5, ncol = 5, byrow = T)
b_table <- rbind(c("Small","2","3","4","Big"), b_table)
rownames(b_table) <- c("b","Low","2","3","4","High")

tb_table <- matrix(tb, nrow = 5, ncol = 5, byrow = T)
tb_table <- rbind(c("Small","2","3","4","Big"), tb_table)
rownames(tb_table) <- c("t(b)","Low","2","3","4","High")

r2_table <- matrix(r2, nrow = 5, ncol = 5, byrow = T)
r2_table <- rbind(c("Small","2","3","4","Big"), r2_table)
rownames(r2_table) <- c("R^2","Low","2","3","4","High")

se_table <- matrix(se, nrow = 5, ncol = 5, byrow = T)
se_table <- rbind(c("Small","2","3","4","Big"), se_table)
rownames(se_table) <- c("s(e)","Low","2","3","4","High")

table4 <- rbind(b_table, tb_table, r2_table, se_table)
table4

#Table 5
s <- c()
ts <- c()
h <- c()
th <- c()
r2 <- c()
se <- c()

for (i in 1:25)
{
  s[i] <- summary(lm(repPD_excess[,i]~repPD_factors$SMB+repPD_factors$HML))$coefficients[2,1]
  ts[i] <- summary(lm(repPD_excess[,i]~repPD_factors$SMB+repPD_factors$HML))$coefficients[2,3]
  h[i] <- summary(lm(repPD_excess[,i]~repPD_factors$SMB+repPD_factors$HML))$coefficients[3,1]
  th[i] <- summary(lm(repPD_excess[,i]~repPD_factors$SMB+repPD_factors$HML))$coefficients[3,3]
  r2[i] <- summary(lm(repPD_excess[,i]~repPD_factors$SMB+repPD_factors$HML))$adj.r.squared
  se[i] <- summary(lm(repPD_excess[,i]~repPD_factors$SMB+repPD_factors$HML))$sigma
}

s_table <- matrix(s, nrow = 5, ncol = 5, byrow = T)
s_table <- rbind(c("Small","2","3","4","Big"), s_table)
rownames(s_table) <- c("s","Low","2","3","4","High")

ts_table <- matrix(ts, nrow = 5, ncol = 5, byrow = T)
ts_table <- rbind(c("Small","2","3","4","Big"), ts_table)
rownames(ts_table) <- c("t(s)","Low","2","3","4","High")

h_table <- matrix(h, nrow = 5, ncol = 5, byrow = T)
h_table <- rbind(c("Small","2","3","4","Big"), h_table)
rownames(h_table) <- c("h","Low","2","3","4","High")

th_table <- matrix(th, nrow = 5, ncol = 5, byrow = T)
th_table <- rbind(c("Small","2","3","4","Big"), th_table)
rownames(th_table) <- c("t(h)","Low","2","3","4","High")

r2_table <- matrix(r2, nrow = 5, ncol = 5, byrow = T)
r2_table <- rbind(c("Small","2","3","4","Big"), r2_table)
rownames(r2_table) <- c("R^2","Low","2","3","4","High")

se_table <- matrix(se, nrow = 5, ncol = 5, byrow = T)
se_table <- rbind(c("Small","2","3","4","Big"), se_table)
rownames(se_table) <- c("s(e)","Low","2","3","4","High")

table5 <- rbind(s_table, ts_table, h_table, th_table, r2_table, se_table)
table5

#Table 6
b <- c()
tb <- c()
s <- c()
ts <- c()
h <- c()
th <- c()
r2 <- c()
se <- c()

for (i in 1:25)
{
  b[i] <- summary(lm(repPD_excess[,i]~repPD_factors$Mkt.RF+repPD_factors$SMB+repPD_factors$HML))$coefficients[2,1]
  tb[i] <- summary(lm(repPD_excess[,i]~repPD_factors$Mkt.RF+repPD_factors$SMB+repPD_factors$HML))$coefficients[2,3]
  s[i] <- summary(lm(repPD_excess[,i]~repPD_factors$Mkt.RF+repPD_factors$SMB+repPD_factors$HML))$coefficients[3,1]
  ts[i] <- summary(lm(repPD_excess[,i]~repPD_factors$Mkt.RF+repPD_factors$SMB+repPD_factors$HML))$coefficients[3,3]
  h[i] <- summary(lm(repPD_excess[,i]~repPD_factors$Mkt.RF+repPD_factors$SMB+repPD_factors$HML))$coefficients[4,1]
  th[i] <- summary(lm(repPD_excess[,i]~repPD_factors$Mkt.RF+repPD_factors$SMB+repPD_factors$HML))$coefficients[4,3]
  r2[i] <- summary(lm(repPD_excess[,i]~repPD_factors$Mkt.RF+repPD_factors$SMB+repPD_factors$HML))$adj.r.squared
  se[i] <- summary(lm(repPD_excess[,i]~repPD_factors$Mkt.RF+repPD_factors$SMB+repPD_factors$HML))$sigma
}

b_table <- matrix(b, nrow = 5, ncol = 5, byrow = T)
b_table <- rbind(c("Small","2","3","4","Big"), b_table)
rownames(b_table) <- c("b","Low","2","3","4","High")

tb_table <- matrix(tb, nrow = 5, ncol = 5, byrow = T)
tb_table <- rbind(c("Small","2","3","4","Big"), tb_table)
rownames(tb_table) <- c("t(b)","Low","2","3","4","High")

s_table <- matrix(s, nrow = 5, ncol = 5, byrow = T)
s_table <- rbind(c("Small","2","3","4","Big"), s_table)
rownames(s_table) <- c("s","Low","2","3","4","High")

ts_table <- matrix(ts, nrow = 5, ncol = 5, byrow = T)
ts_table <- rbind(c("Small","2","3","4","Big"), ts_table)
rownames(ts_table) <- c("t(s)","Low","2","3","4","High")

h_table <- matrix(h, nrow = 5, ncol = 5, byrow = T)
h_table <- rbind(c("Small","2","3","4","Big"), h_table)
rownames(h_table) <- c("h","Low","2","3","4","High")

th_table <- matrix(th, nrow = 5, ncol = 5, byrow = T)
th_table <- rbind(c("Small","2","3","4","Big"), th_table)
rownames(th_table) <- c("t(h)","Low","2","3","4","High")

r2_table <- matrix(r2, nrow = 5, ncol = 5, byrow = T)
r2_table <- rbind(c("Small","2","3","4","Big"), r2_table)
rownames(r2_table) <- c("R^2","Low","2","3","4","High")

se_table <- matrix(se, nrow = 5, ncol = 5, byrow = T)
se_table <- rbind(c("Small","2","3","4","Big"), se_table)
rownames(se_table) <- c("s(e)","Low","2","3","4","High")

table6 <- rbind(b_table, tb_table, s_table, ts_table, h_table, th_table, r2_table, se_table)
table6

#Table 9a
#(ii) intercepts
a <- c()
ta <- c()

for (i in 1:25)
{
  a[i] <- summary(lm(repPD_excess[,i]~repPD_factors$Mkt.RF))$coefficients[1,1]
  ta[i] <- summary(lm(repPD_excess[,i]~repPD_factors$Mkt.RF))$coefficients[1,3]
}

a_table.ii <- matrix(a, nrow = 5, ncol = 5, byrow = T)
a_table.ii <- rbind(c("Small","2","3","4","Big"), a_table.ii)
rownames(a_table.ii) <- c("a","Low","2","3","4","High")

ta_table.ii <- matrix(ta, nrow = 5, ncol = 5, byrow = T)
ta_table.ii <- rbind(c("Small","2","3","4","Big"), ta_table.ii)
rownames(ta_table.ii) <- c("t(a)","Low","2","3","4","High")

#(iii) intercepts
a <- c()
ta <- c()

for (i in 1:25)
{
  a[i] <- summary(lm(repPD_excess[,i]~repPD_factors$SMB+repPD_factors$HML))$coefficients[1,1]
  ta[i] <- summary(lm(repPD_excess[,i]~repPD_factors$SMB+repPD_factors$HML))$coefficients[1,3]
}

a_table.iii <- matrix(a, nrow = 5, ncol = 5, byrow = T)
a_table.iii <- rbind(c("Small","2","3","4","Big"), a_table.iii)
rownames(a_table.iii) <- c("a","Low","2","3","4","High")

ta_table.iii <- matrix(ta, nrow = 5, ncol = 5, byrow = T)
ta_table.iii <- rbind(c("Small","2","3","4","Big"), ta_table.iii)
rownames(ta_table.iii) <- c("t(a)","Low","2","3","4","High")

#(iv) intercepts
a <- c()
ta <- c()

for (i in 1:25)
{
  a[i] <- summary(lm(repPD_excess[,i]~repPD_factors$Mkt.RF+repPD_factors$SMB+repPD_factors$HML))$coefficients[1,1]
  ta[i] <- summary(lm(repPD_excess[,i]~repPD_factors$Mkt.RF+repPD_factors$SMB+repPD_factors$HML))$coefficients[1,3]
}

a_table.iv <- matrix(a, nrow = 5, ncol = 5, byrow = T)
a_table.iv <- rbind(c("Small","2","3","4","Big"), a_table.iv)
rownames(a_table.iv) <- c("a","Low","2","3","4","High")

ta_table.iv <- matrix(ta, nrow = 5, ncol = 5, byrow = T)
ta_table.iv <- rbind(c("Small","2","3","4","Big"), ta_table.iv)
rownames(ta_table.iv) <- c("t(a)","Low","2","3","4","High")

table9a <- rbind(a_table.ii, ta_table.ii, a_table.iii, ta_table.iii, a_table.iv, ta_table.iv)
table9a



###Extension Period###

#Table 2
m <- c()
s <- c()
t <- c()

for (i in 1:25)
{
  m[i] <- mean(extPD_excess[,i])
  s[i] <- sd(extPD_excess[,i])
  t[i] <- m[i-1]/(s[i-1]/sqrt(342))
}

m_table <- matrix(m, nrow = 5, ncol = 5, byrow = T)
m_table <- rbind(c("Small","2","3","4","Big"), m_table)
rownames(m_table) <- c("Means","Low","2","3","4","High")

s_table <- matrix(s, nrow = 5, ncol = 5, byrow = T)
s_table <- rbind(c("Small","2","3","4","Big"), s_table)
rownames(s_table) <- c("Standard deviations","Low","2","3","4","High")

t_table <- matrix(t, nrow = 5, ncol = 5, byrow = T)
t_table <- rbind(c("Small","2","3","4","Big"), t_table)
rownames(t_table) <- c("t-statistics for means","Low","2","3","4","High")

table2.1 <- rbind(m_table, s_table, t_table)
table2.1

#Table 4
b <- c()
tb <- c()
r2 <- c()
se <- c()

for (i in 1:25)
{
  b[i] <- summary(lm(extPD_excess[,i]~extPD_factors$Mkt.RF))$coefficients[2,1]
  tb[i] <- summary(lm(extPD_excess[,i]~extPD_factors$Mkt.RF))$coefficients[2,3]
  se[i] <- summary(lm(extPD_excess[,i]~extPD_factors$Mkt.RF))$coefficients[2,2]
  r2[i] <- summary(lm(extPD_excess[,i]~extPD_factors$Mkt.RF))$adj.r.squared
}

b_table <- matrix(b, nrow = 5, ncol = 5, byrow = T)
b_table <- rbind(c("Small","2","3","4","Big"), b_table)
rownames(b_table) <- c("b","Low","2","3","4","High")

tb_table <- matrix(tb, nrow = 5, ncol = 5, byrow = T)
tb_table <- rbind(c("Small","2","3","4","Big"), tb_table)
rownames(tb_table) <- c("t(b)","Low","2","3","4","High")

r2_table <- matrix(r2, nrow = 5, ncol = 5, byrow = T)
r2_table <- rbind(c("Small","2","3","4","Big"), r2_table)
rownames(r2_table) <- c("R^2","Low","2","3","4","High")

se_table <- matrix(se, nrow = 5, ncol = 5, byrow = T)
se_table <- rbind(c("Small","2","3","4","Big"), se_table)
rownames(se_table) <- c("s(e)","Low","2","3","4","High")

table4.1 <- rbind(b_table, tb_table, r2_table, se_table)
table4.1

#Table 5
s <- c()
ts <- c()
h <- c()
th <- c()
r2 <- c()
se <- c()

for (i in 1:25)
{
  s[i] <- summary(lm(extPD_excess[,i]~extPD_factors$SMB+extPD_factors$HML))$coefficients[2,1]
  ts[i] <- summary(lm(extPD_excess[,i]~extPD_factors$SMB+extPD_factors$HML))$coefficients[2,3]
  h[i] <- summary(lm(extPD_excess[,i]~extPD_factors$SMB+extPD_factors$HML))$coefficients[3,1]
  th[i] <- summary(lm(extPD_excess[,i]~extPD_factors$SMB+extPD_factors$HML))$coefficients[3,3]
  r2[i] <- summary(lm(extPD_excess[,i]~extPD_factors$SMB+extPD_factors$HML))$adj.r.squared
  se[i] <- summary(lm(extPD_excess[,i]~extPD_factors$SMB+extPD_factors$HML))$sigma
}

s_table <- matrix(s, nrow = 5, ncol = 5, byrow = T)
s_table <- rbind(c("Small","2","3","4","Big"), s_table)
rownames(s_table) <- c("s","Low","2","3","4","High")

ts_table <- matrix(ts, nrow = 5, ncol = 5, byrow = T)
ts_table <- rbind(c("Small","2","3","4","Big"), ts_table)
rownames(ts_table) <- c("t(s)","Low","2","3","4","High")

h_table <- matrix(h, nrow = 5, ncol = 5, byrow = T)
h_table <- rbind(c("Small","2","3","4","Big"), h_table)
rownames(h_table) <- c("h","Low","2","3","4","High")

th_table <- matrix(th, nrow = 5, ncol = 5, byrow = T)
th_table <- rbind(c("Small","2","3","4","Big"), th_table)
rownames(th_table) <- c("t(h)","Low","2","3","4","High")

r2_table <- matrix(r2, nrow = 5, ncol = 5, byrow = T)
r2_table <- rbind(c("Small","2","3","4","Big"), r2_table)
rownames(r2_table) <- c("R^2","Low","2","3","4","High")

se_table <- matrix(se, nrow = 5, ncol = 5, byrow = T)
se_table <- rbind(c("Small","2","3","4","Big"), se_table)
rownames(se_table) <- c("s(e)","Low","2","3","4","High")

table5.1 <- rbind(s_table, ts_table, h_table, th_table, r2_table, se_table)
table5.1

#Table 6
b <- c()
tb <- c()
s <- c()
ts <- c()
h <- c()
th <- c()
r2 <- c()
se <- c()

for (i in 1:25)
{
  b[i] <- summary(lm(extPD_excess[,i]~extPD_factors$Mkt.RF+extPD_factors$SMB+extPD_factors$HML))$coefficients[2,1]
  tb[i] <- summary(lm(extPD_excess[,i]~extPD_factors$Mkt.RF+extPD_factors$SMB+extPD_factors$HML))$coefficients[2,3]
  s[i] <- summary(lm(extPD_excess[,i]~extPD_factors$Mkt.RF+extPD_factors$SMB+extPD_factors$HML))$coefficients[3,1]
  ts[i] <- summary(lm(extPD_excess[,i]~extPD_factors$Mkt.RF+extPD_factors$SMB+extPD_factors$HML))$coefficients[3,3]
  h[i] <- summary(lm(extPD_excess[,i]~extPD_factors$Mkt.RF+extPD_factors$SMB+extPD_factors$HML))$coefficients[4,1]
  th[i] <- summary(lm(extPD_excess[,i]~extPD_factors$Mkt.RF+extPD_factors$SMB+extPD_factors$HML))$coefficients[4,3]
  r2[i] <- summary(lm(extPD_excess[,i]~extPD_factors$Mkt.RF+extPD_factors$SMB+extPD_factors$HML))$adj.r.squared
  se[i] <- summary(lm(extPD_excess[,i]~extPD_factors$Mkt.RF+extPD_factors$SMB+extPD_factors$HML))$sigma
}

b_table <- matrix(b, nrow = 5, ncol = 5, byrow = T)
b_table <- rbind(c("Small","2","3","4","Big"), b_table)
rownames(b_table) <- c("b","Low","2","3","4","High")

tb_table <- matrix(tb, nrow = 5, ncol = 5, byrow = T)
tb_table <- rbind(c("Small","2","3","4","Big"), tb_table)
rownames(tb_table) <- c("t(b)","Low","2","3","4","High")

s_table <- matrix(s, nrow = 5, ncol = 5, byrow = T)
s_table <- rbind(c("Small","2","3","4","Big"), s_table)
rownames(s_table) <- c("s","Low","2","3","4","High")

ts_table <- matrix(ts, nrow = 5, ncol = 5, byrow = T)
ts_table <- rbind(c("Small","2","3","4","Big"), ts_table)
rownames(ts_table) <- c("t(s)","Low","2","3","4","High")

h_table <- matrix(h, nrow = 5, ncol = 5, byrow = T)
h_table <- rbind(c("Small","2","3","4","Big"), h_table)
rownames(h_table) <- c("h","Low","2","3","4","High")

th_table <- matrix(th, nrow = 5, ncol = 5, byrow = T)
th_table <- rbind(c("Small","2","3","4","Big"), th_table)
rownames(th_table) <- c("t(h)","Low","2","3","4","High")

r2_table <- matrix(r2, nrow = 5, ncol = 5, byrow = T)
r2_table <- rbind(c("Small","2","3","4","Big"), r2_table)
rownames(r2_table) <- c("R^2","Low","2","3","4","High")

se_table <- matrix(se, nrow = 5, ncol = 5, byrow = T)
se_table <- rbind(c("Small","2","3","4","Big"), se_table)
rownames(se_table) <- c("s(e)","Low","2","3","4","High")

table6.1 <- rbind(b_table, tb_table, s_table, ts_table, h_table, th_table, r2_table, se_table)
table6.1

#Table 9a
#(ii) intercepts
a <- c()
ta <- c()

for (i in 1:25)
{
  a[i] <- summary(lm(extPD_excess[,i]~extPD_factors$Mkt.RF))$coefficients[1,1]
  ta[i] <- summary(lm(extPD_excess[,i]~extPD_factors$Mkt.RF))$coefficients[1,3]
}

a_table.ii <- matrix(a, nrow = 5, ncol = 5, byrow = T)
a_table.ii <- rbind(c("Small","2","3","4","Big"), a_table.ii)
rownames(a_table.ii) <- c("a","Low","2","3","4","High")

ta_table.ii <- matrix(ta, nrow = 5, ncol = 5, byrow = T)
ta_table.ii <- rbind(c("Small","2","3","4","Big"), ta_table.ii)
rownames(ta_table.ii) <- c("t(a)","Low","2","3","4","High")

#(iii) intercepts
a <- c()
ta <- c()

for (i in 1:25)
{
  a[i] <- summary(lm(extPD_excess[,i]~extPD_factors$SMB+extPD_factors$HML))$coefficients[1,1]
  ta[i] <- summary(lm(extPD_excess[,i]~extPD_factors$SMB+extPD_factors$HML))$coefficients[1,3]
}

a_table.iii <- matrix(a, nrow = 5, ncol = 5, byrow = T)
a_table.iii <- rbind(c("Small","2","3","4","Big"), a_table.iii)
rownames(a_table.iii) <- c("a","Low","2","3","4","High")

ta_table.iii <- matrix(ta, nrow = 5, ncol = 5, byrow = T)
ta_table.iii <- rbind(c("Small","2","3","4","Big"), ta_table.iii)
rownames(ta_table.iii) <- c("t(a)","Low","2","3","4","High")

#(iv) intercepts
a <- c()
ta <- c()

for (i in 1:25)
{
  a[i] <- summary(lm(extPD_excess[,i]~extPD_factors$Mkt.RF+extPD_factors$SMB+extPD_factors$HML))$coefficients[1,1]
  ta[i] <- summary(lm(extPD_excess[,i]~extPD_factors$Mkt.RF+extPD_factors$SMB+extPD_factors$HML))$coefficients[1,3]
}

a_table.iv <- matrix(a, nrow = 5, ncol = 5, byrow = T)
a_table.iv <- rbind(c("Small","2","3","4","Big"), a_table.iv)
rownames(a_table.iv) <- c("a","Low","2","3","4","High")

ta_table.iv <- matrix(ta, nrow = 5, ncol = 5, byrow = T)
ta_table.iv <- rbind(c("Small","2","3","4","Big"), ta_table.iv)
rownames(ta_table.iv) <- c("t(a)","Low","2","3","4","High")

table9a.1 <- rbind(a_table.ii, ta_table.ii, a_table.iii, ta_table.iii, a_table.iv, ta_table.iv)
table9a.1


###Test for January Effect###
Jan <- c()
for (j in 1:1146) {  
  if ((Data[j,1]-1)%%100==0) {
    Jan[j] <- 1
  } else {
    Jan[j] <- 0
  }
}
repPD_excess <- cbind(repPD_excess, Jan[1:342])

#Regressed Excess Returns on Jan Effect:
a <- c()
b <- c()
ta <- c()
tb <- c()
r2 <- c()

for (i in 1:25)
{
  a[i] <- summary(lm(repPD_excess[,i]~repPD_excess$Jan))$coefficients[1,1]
  b[i] <- summary(lm(repPD_excess[,i]~repPD_excess$Jan))$coefficients[2,1]
  ta[i] <- summary(lm(repPD_excess[,i]~repPD_excess$Jan))$coefficients[1,3]
  tb[i] <- summary(lm(repPD_excess[,i]~repPD_excess$Jan))$coefficients[2,3]
  r2[i] <- summary(lm(repPD_excess[,i]~repPD_excess$Jan))$adj.r.squared
}

a_table <- matrix(a, nrow = 5, ncol = 5, byrow = T)
a_table <- rbind(c("Small","2","3","4","Big"), a_table)
rownames(a_table) <- c("a","Low","2","3","4","High")

b_table <- matrix(b, nrow = 5, ncol = 5, byrow = T)
b_table <- rbind(c("Small","2","3","4","Big"), b_table)
rownames(b_table) <- c("b","Low","2","3","4","High")

ta_table <- matrix(ta, nrow = 5, ncol = 5, byrow = T)
ta_table <- rbind(c("Small","2","3","4","Big"), ta_table)
rownames(ta_table) <- c("t(a)","Low","2","3","4","High")

tb_table <- matrix(tb, nrow = 5, ncol = 5, byrow = T)
tb_table <- rbind(c("Small","2","3","4","Big"), tb_table)
rownames(tb_table) <- c("t(b)","Low","2","3","4","High")

r2_table <- matrix(r2, nrow = 5, ncol = 5, byrow = T)
r2_table <- rbind(c("Small","2","3","4","Big"), r2_table)
rownames(r2_table) <- c("R^2","Low","2","3","4","High")

table10_excess <- rbind(a_table, b_table, ta_table, tb_table, r2_table)
table10_excess

#Regressed 3-factor Residuals on Jan Effect:
a <- c()
b <- c()
ta <- c()
tb <- c()
r2 <- c()

for (i in 1:25)
{
  e <- lm(repPD_excess[,i]~repPD_factors$Mkt.RF+repPD_factors$SMB+repPD_factors$HML)$residuals
  a[i] <- summary(lm(e~repPD_excess$Jan))$coefficients[1,1]
  b[i] <- summary(lm(e~repPD_excess$Jan))$coefficients[2,1]
  ta[i] <- summary(lm(e~repPD_excess$Jan))$coefficients[1,3]
  tb[i] <- summary(lm(e~repPD_excess$Jan))$coefficients[2,3]
  r2[i] <- summary(lm(e~repPD_excess$Jan))$adj.r.squared
}

a_table <- matrix(a, nrow = 5, ncol = 5, byrow = T)
a_table <- rbind(c("Small","2","3","4","Big"), a_table)
rownames(a_table) <- c("a","Low","2","3","4","High")

b_table <- matrix(b, nrow = 5, ncol = 5, byrow = T)
b_table <- rbind(c("Small","2","3","4","Big"), b_table)
rownames(b_table) <- c("b","Low","2","3","4","High")

ta_table <- matrix(ta, nrow = 5, ncol = 5, byrow = T)
ta_table <- rbind(c("Small","2","3","4","Big"), ta_table)
rownames(ta_table) <- c("t(a)","Low","2","3","4","High")

tb_table <- matrix(tb, nrow = 5, ncol = 5, byrow = T)
tb_table <- rbind(c("Small","2","3","4","Big"), tb_table)
rownames(tb_table) <- c("t(b)","Low","2","3","4","High")

r2_table <- matrix(r2, nrow = 5, ncol = 5, byrow = T)
r2_table <- rbind(c("Small","2","3","4","Big"), r2_table)
rownames(r2_table) <- c("R^2","Low","2","3","4","High")

table10_3factor <- rbind(a_table, b_table, ta_table, tb_table, r2_table)
table10_3factor

table10 <- cbind(t(table10_excess),t(table10_3factor))
table10

library(gridExtra)
pdf("~/Desktop/Joshua's Files/Australian National University/5th year - Honours/Semester 1/FINM4106 - Advanced Investments/Assignment/tables.pdf")       
grid.table(table2)
grid.table(table2.1)
grid.table(table4)
grid.table(table4.1)
grid.table(table6)
grid.table(table6.1)
grid.table(table9a)
grid.table(table9a.1)
grid.table(table10)
dev.off()


write.table(table2, "~/Desktop/Joshua's Files/Australian National University/5th year - Honours/Semester 1/FINM4106 - Advanced Investments/Assignment/table2.csv", append = FALSE, sep = ",", dec = ".", row.names = TRUE, col.names = TRUE)
write.table(table2.1, "~/Desktop/Joshua's Files/Australian National University/5th year - Honours/Semester 1/FINM4106 - Advanced Investments/Assignment/table2.1.csv", append = FALSE, sep = ",", dec = ".", row.names = TRUE, col.names = TRUE)
write.table(table4, "~/Desktop/Joshua's Files/Australian National University/5th year - Honours/Semester 1/FINM4106 - Advanced Investments/Assignment/table4.csv", append = FALSE, sep = ",", dec = ".", row.names = TRUE, col.names = TRUE)
write.table(table4.1, "~/Desktop/Joshua's Files/Australian National University/5th year - Honours/Semester 1/FINM4106 - Advanced Investments/Assignment/table4.1.csv", append = FALSE, sep = ",", dec = ".", row.names = TRUE, col.names = TRUE)
write.table(table6, "~/Desktop/Joshua's Files/Australian National University/5th year - Honours/Semester 1/FINM4106 - Advanced Investments/Assignment/table6.csv", append = FALSE, sep = ",", dec = ".", row.names = TRUE, col.names = TRUE)
write.table(table6.1, "~/Desktop/Joshua's Files/Australian National University/5th year - Honours/Semester 1/FINM4106 - Advanced Investments/Assignment/table6.1.csv", append = FALSE, sep = ",", dec = ".", row.names = TRUE, col.names = TRUE)
write.table(table9a, "~/Desktop/Joshua's Files/Australian National University/5th year - Honours/Semester 1/FINM4106 - Advanced Investments/Assignment/table9a.1.csv", append = FALSE, sep = ",", dec = ".", row.names = TRUE, col.names = TRUE)