
#Code on Posit Cloud 
list.files()
df<-read.csv("Tucson_Police_Activity_2024.csv")

colnames(df)
ncol(df)
nrow(df)

head(df,10)

mean <- (1+3)/2
mean

#Dygraph Quantmod 
install.packages("quantmod")
library(quantmod)

install.packages("dygraphs")
library(dygraphs)

google_stock_prices <- getSymbols("GOOG", src = "yahoo",from = "2008-01-01",auto.assign=FALSE)
chartSeries(google_stock_prices)

dygraph(google_stock_prices[,c("GOOG.Close")],main="Google Stock Price Starting in 2008")

pimaincome <-getSymbols("MHIAZ04019A052NCEN", src="FRED",auto.assign = FALSE)
names(pimaincome) <- "Income"
dygraph(pimaincome,main="Pima County Median Household Income")


phxincome <-getSymbols("MHIAZ04013A052NCEN", src="FRED",auto.assign = FALSE)
names(phxincome) <- "Income"
dygraph(phxincome,main="Maricopa County Median Household Income")


