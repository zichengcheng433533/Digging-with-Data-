
#Week 8 - October 15 

getwd()
setwd("/Users/clairecheng/desktop")

#install packages 

install.packages(c("quantmod","dygraphs"))

#load packages 

library("quantmod")
library("dygraphs")

#1.stock market graphing 

google_stock_prices <- getSymbols("GOOG", src = "yahoo", from = "2008-01-01", auto.assign = FALSE)
chartSeries(google_stock_prices)

class(google_stock_prices)

nvdia_stock_prices <- getSymbols("NVDA", src = "yahoo", from = "2008-01-01", auto.assign = FALSE)
chartSeries(nvdia_stock_prices)

meta_stock_prices <- getSymbols("META", src = "google", from = "2008-01-01", auto.assign = FALSE)
chartSeries(meta_stock_prices) #defunct. 

#from the dataset google_stock_prices, select all rows and the column named "goog.close". 
#graphing google stock prices with the dygraphs package. 
dygraph(google_stock_prices[,c("GOOG.Close")], main="Google Stock Price Starting in 2008")


#2.graph city's median income 

#pima county (Tucson)
pimaincome <- getSymbols("MHIAZ04019A052NCEN", src="FRED", auto.assign = FALSE)
names(pimaincome) <- "Income"
dygraph(pimaincome, main = "Pima County Median Household Income")

#Save the html version of this graph, keep its interactivity. 
install.packages("htmlwidgets")
library(htmlwidgets)

pimagraph <- dygraph(pimaincome, main = "Pima County Median Household Income")

saveWidget(g, file="pima county median household income.html") #will be saved to your WorkDirectory.
#now you can open this html file in your browswer and see that interactive graph again! 


#maricopa county (Pheonix)
phxincome <- getSymbols("MHIAZ04013A052NCEN", src="FRED", auto.assign = FALSE) #download the Fred data into an XTS time series 
names(phxincome) <- "Income" #rename the column for clarity. 
dygraph(phxincome, main = "Maricopa County Median Household Income") #plot interactive time-series chart. 

#you can click and drag from left to right inside the graph to define a portion of it.  from 2010 to 2020. 
#the graph will zoom in
#double click, you zoom out again, or you click refresh the viewer. 

#3. So many packages! 
#R weekly.org (LLM coding performance)
#Google your needs. Regression analysis, ANOVA in R. 


#4. Compare one city's data to the US median 

#add the national media income to the graph. 

usincome <- getSymbols("MEHOINUSA672N", src="FRED",auto.assign = FALSE)
names(usincome) <- "US Income"
mygraphdata <- cbind(pimaincome,usincome) #combine two datasets by columns. Joins objects horizontally. 
dygraph(mygraphdata, main = "Median Household Income")


#5. You can use this basic code, change to another data point such as unemployment. 

pima.unemploy <- getSymbols("AZPIMA9URN", src="FRED", auto.assign = FALSE)
names(pima.unemploy) <- "Unemploy"
dygraph(pima.unemploy, main = "Pima County Unemployment Rate")

#update the time range to 2010 to latest. Subset the Data. 
pima.unemploy <- pima.unemploy["2010/"]
dygraph(pima.unemploy, main = "Pima County Unemployment Rate from 2010 to 2025")

#time range: 2010 to 2020 
pima.unemploy <- pima.unemploy["2010/2020"]
dygraph(pima.unemploy, main = "Pima County Unemployment Rate from 2010 to 2025")

#6. Run a remote script to make an interactive map 


install.packages("leaflet")
library(leaflet)

leaflet() %>%
  addTiles() %>%
  addMarkers(lng = -110.9747, lat = 32.2226, popup = "Tucson, AZ — 🌵🏜️")


#7 Wordcloud 
install.packages("wordcloud")
library(wordcloud)

text <- c("Happy", "Birthday", "Journalism", "Data", "Visualization", "Fun", "R")
wordcloud(text, colors = rainbow(7), scale = c(4, 1))


#7 Wordcloud 2 
# library
install.packages("wordcloud2")
library(wordcloud2) 

# have a look to the example dataset
head(demoFreq)

# Basic plot
wordcloud2(data=demoFreq, size=1.6)

# Change the background color
wordcloud2(demoFreq, size=1.6, color='random-light', backgroundColor="black")

# Change the shape:
wordcloud2(demoFreq, size = 0.7, shape = 'pentagon')

#change the word orientation: 
wordcloud2(demoFreq, size = 2.3, minRotation = -pi/6, maxRotation = -pi/6, rotateRatio = 1)

