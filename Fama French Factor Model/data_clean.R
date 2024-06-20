#MERGE TWO DATASETS INTO THE DATA FILE, THEN CONSTRUCT THE FACTORS/RETURNS FROM THIS ONE FILE
F.F_mthly_factors <- read.csv("~/Desktop/Joshua's Files/Australian National University/5th year - Honours/Semester 1/FINM4106 - Advanced Investments/Assignment/F-F_Research_Data_Factors(mthly edit).txt", sep="")
pf_mthly_returns <- read.csv("~/Desktop/Joshua's Files/Australian National University/5th year - Honours/Semester 1/FINM4106 - Advanced Investments/Assignment/25_Portfolios_5x5(avg mthly value wgt).txt", sep="")
Data <- cbind(pf_mthly_returns[1:1146,],F.F_mthly_factors[1:1146,2:5])

write.table(Data, "~/Desktop/Joshua's Files/Australian National University/5th year - Honours/Semester 1/FINM4106 - Advanced Investments/Assignment/Data.txt", append = FALSE, sep = " ", dec = ".", row.names = TRUE, col.names = TRUE)
