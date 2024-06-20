# Generate country, year and gender using student ID

myID <- 6665828 # put your student ID here (as a number, without the "u")
# Aus 1921-2016, Austria 1947-2017, Belarus 1959-2016, Chile 1992-2008
d1 <- data.frame(country="Australia",year=c(1921:2016))
d2 <- data.frame(country="Austria",year=c(1947:2017))
d3 <- data.frame(country="Belarus",year=c(1959:2016))
d4 <- data.frame(country="Belgium",year=c(1841:2018))
d5 <- data.frame(country="Bulgaria",year=c(1947:2017))
d6 <- data.frame(country="Canada",year=c(1921:2016))
d7 <- data.frame(country="Chile",year=c(1992:2008))
d8 <- data.frame(country="Croatia",year=c(2002:2017))
d9 <- data.frame(country="Czechia",year=c(1950:2017))
d10 <- data.frame(country="Denmark",year=c(1835:2016))
d11 <- data.frame(country="Estonia",year=c(1959:2017))
d12 <- data.frame(country="Finland",year=c(1878:2018))
d13 <- data.frame(country="France",year=c(1816:2017))
d14 <- data.frame(country="Germany",year=c(1990:2017))
d15 <- data.frame(country="Greece",year=c(1981:2017))
d16 <- data.frame(country="Hong Kong",year=c(1986:2017))
d17 <- data.frame(country="Japan",year=c(1947:2017))
d18 <- data.frame(country="New Zealand",year=c(1948:2013))
d.A <- d.B <- rbind(d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15)
d.A$sex <- "male"
d.B$sex <- "female"
d <- rbind(d.A,d.B)
set.seed(myID)
my.example <- sample(nrow(d),1)
d[my.example,]
