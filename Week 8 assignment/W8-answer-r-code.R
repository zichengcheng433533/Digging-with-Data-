#october 15 session 

getwd()
setwd("/Users/clairecheng/Desktop/R/Week8")

#install packages 

install.packages(c("quantmod","dygraphs"))

#load packages 
library("quantmod")
library("dygraphs")

#1. Stock market graphing 
google_stock_prices <- getSymbols("GOOG", src = "yahoo", from = "2008-01-01", auto.assign = FALSE)
chartSeries(google_stock_prices)

#autoassign: assign the time-series data to a variable "google_stock_prices". 

class(google_stock_prices)

#"xts""zoo"a time-series object: index of dates and times; along with a matrix of observations. 

nvdia_stock_prices <- getSymbols("NVDA", src = "yahoo", from = "2008-01-01", auto.assign = FALSE)
chartSeries(nvdia_stock_prices)

meta_stock_prices <- getSymbols("META", src = "google", from = "2008-01-01", auto.assign = FALSE)
chartSeries(meta_stock_prices) #Google finance is already defunct. 

#create an interactive stock price graph: 

#from the dataset google_stock_prices, select all rows and the column named "goog.close". 
#graphing google stock prices with the dygraphs package. 
dygraph(google_stock_prices[,c("GOOG.Close")], main="Google Stock Price Starting in 2008")

#click and drag from left to right to define a certain time period. 
#pandemic 2020 - 2022: government sent money stimulus check to the gov/people
#fed lowered the interest rate. 
#tech companies made a lot of money people shopping working online. 


#2. Graph a city's median income 
#quantmod includes a function that lets you import data directly from US federal reserve 
#fred - economic data reporting. 

#pima county (Tucson)
MHIAZ04019A052NCEN

pimaincome <- getSymbols("MHIAZ04019A052NCEN", src="FRED", auto.assign = FALSE)
names(pimaincome) <- "Income"
dygraph(pimaincome, main = "Pima County Median Household Income")

#Save the html version of this graph, keep its interactivity. 
install.packages("htmlwidgets")
library(htmlwidgets)

pimagraph <- dygraph(pimaincome, main = "Pima County Median Household Income")

saveWidget(pimagraph, file="pima county median household income.html") #will be saved to your WorkDirectory.
#now you can open this html file in your browswer and see that interactive graph again! 


##Try It Yourself: Pheonix data (Maricopa county)
phxincome <- getSymbols("MHIAZ04013A052NCEN", src="FRED", auto.assign = FALSE) #download the Fred data into an XTS time series 
names(phxincome) <- "Income" #rename the column for clarity. 
dygraph(phxincome, main = "Maricopa County Median Household Income") #plot interactive time-series chart. 

#you can click and drag from left to right inside the graph to define a portion of it.  from 2010 to 2020. 
#the graph will zoom in
#double click, you zoom out again, or you click refresh the viewer. 

#3. So many packages! 
#R weekly.org (LLM coding performance)
#Google your needs. Regression analysis, ANOVA in R. 

#https://rweekly.org/

#4. Compare one city's data to the US median 
#let's add the national median income to the graph. 
#look up the US median income on Fred. 

usincome <- getSymbols("MEHOINUSA672N", src="FRED",auto.assign = FALSE)
names(usincome) <- "US Income"
mygraphdata <- cbind(pimaincome,usincome) #combine two datasets by columns. Joins objects horizontally. 
dygraph(mygraphdata, main = "Median Household Income")


#5. You can use this basic code template, 
#plot other data series such as unemployment. 

pima.unemploy <- getSymbols("AZPIMA9URN", src="FRED", auto.assign = FALSE)
names(pima.unemploy) <- "Unemploy"
dygraph(pima.unemploy, main = "Pima County Unemployment Rate")

#update the time range to 2010 to latest. Subset the Data. 
pima.unemploy <- pima.unemploy["2010/"]
dygraph(pima.unemploy, main = "Pima County Unemployment Rate from 2010 to 2025")

#time range: 2010 to 2020 
pima.unemploy <- pima.unemploy["2010/2020"]
dygraph(pima.unemploy, main = "Pima County Unemployment Rate from 2010 to 2025")


#7. Wordcloud 
#https://r-graph-gallery.com/196-the-wordcloud2-library.html

#library
install.packages("wordcloud2")
library(wordcloud2) 

list.files()
#demo data: presidential inauguration speech 
demoFreq<-read.csv("demo-word-frequency.csv")
head(demoFreq) 
#is a table with words and their frequencies 
#how often each word appears in a document. 

#Basic plot
wordcloud2(data=demoFreq,size=0.7)

#Change the background color
wordcloud2(demoFreq, size=0.7, color='random-light', backgroundColor="black")

#Change the shape:
wordcloud2(demoFreq, size = 0.2, shape = 'circle')

#change the word orientation: 
#tilted slightly at a -30 angle (clockwise)
wordcloud2(demoFreq, size = 0.5, minRotation = -pi/6, maxRotation = -pi/6, rotateRatio = 1)

    
                  