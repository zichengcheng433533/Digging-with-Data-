#week 9, session 1, GG plot I. 

#1.Your first ggplot. 
install.packages("gapminder")
install.packages("ggplot2")
library(gapminder)
library(ggplot2)

gapminder #simply printing the dataset in the pacakge, but it doesn't create or copy anything into my environment. 
df<-gapminder #i am creating a new data object, copying gapminder dataset into it. 

#explain the data type 
#fct = factor (categorical)
#int = integer (whole numbers)
#dbl = double (numbers that can have decimals)
#chr = strings of text like "hello"

#country is factor/categorical variables, useful for modeling, plotting, summaries. 
#factor = stored as numbers + labels; 1=afghanistan 2= Brazil, 3=China. 


p <- ggplot(data=gapminder, mapping=aes(x=gdpPercap, y=lifeExp))

p

#add a layer to the plot, what sort of plot to draw. 
p + geom_point()

#takeaway from the scatterplot: 
#nonlinear relationship 
#Positive relationship early: GDP from very low to moderate, life expectancy rises quickly. 
#The curve flattens after 30K. GDP increases, but life expectancy becomes smaller. 
#Wealth distribution: rich countries but large people don't have access to healthcare, safe housing. 

#Practice 1
#create a scatter plot showing each team's number of wins (x) and team value (y) 
getwd()
setwd("/Users/clairecheng/Desktop/R/Week9")
list.files()

mydf<-read.csv("NFL team values.csv")
colnames(mydf)


g <- ggplot(data=mydf, mapping=aes(x=Number.of.Wins..2024., y=Value))

g
g + geom_point()

#if you want to turn off the scientific notation 
options(scipen = 999) 

#if you want to change column names: 
colnames(mydf) <- c("Rank", "Team", "Value","Revenue","Number_of_Wins_2024", "EBITDA", "Debt", "Owner_name")
#alternatively, 
#colnames(mydf)[5] <- "number_of_wins"
#colnames(mydf)[7] <- "debt_as_of_value"
#colnames(mydf)[8] <- "owner_name"

g <- ggplot(data=mydf, mapping=aes(x=Number_of_Wins_2024, y=Value))

g
g + geom_point()



#practice 2 

#Create a column chart showing each team's team value. 
f <- ggplot(data=mydf, mapping=aes(x=Team, y=Value))
f + geom_col()

#Rotate the X-label 45 degrees 
f <- ggplot(data=mydf, mapping=aes(x=Team, y=Value))
f + geom_col() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#hjust=0 starts at the reference point; hjust=1 ends at the reference point. 


#2.Build your plot layer by layer (a sophisticated plot)

p <- ggplot(data=gapminder, mapping=aes(x=gdpPercap, y=lifeExp))
p + geom_point()

#add a smooth line to ggplot 
p + geom_point() + geom_smooth()
p + geom_point() + geom_smooth(method = "gam") 


#rescale the X axis, change how it displays.  
#low GDP countries are crammed to the left,squished together; 
#log transform spread out the smaller values, pattern easier to see. 
#X-axis:0, 30k, 60k, 90k -> Smallest positive value, 1K, 10K, 100K. 
p + geom_point() + geom_smooth(method = "gam")+ scale_x_log10()  

#dollar as unit. 
p + geom_point()+ geom_smooth(method = "gam")+scale_x_log10(labels = scales::dollar)

#if you use lm instead. 
p + geom_point()+ geom_smooth(method = "lm")+scale_x_log10(labels = scales::dollar)

#the GDP is right-skewed, tail to the right, Mean > Median. Data span several magnitude 1->1M
#check the data skewness. 
ggplot(gapminder, aes(x = gdpPercap)) +
  geom_histogram(bins = 30, fill = "steelblue", color = "white")

#LM model analysis: 
lm_model <- lm(lifeExp ~ gdpPercap, data = gapminder)
summary(lm_model)

#GAM model analysis: 
install.packages("mgcv")
library(mgcv)
gam_model <- gam(lifeExp ~ s(gdpPercap), data = gapminder)
summary(gam_model)

#The explanatory power of GAM doubled the explanatory power of LM! 
#because in real life, GDP’s benefits on health taper off at high income levels.


#Practice C: 

#fit a smooth line for NFL team value and number of wins 
mydf
colnames(mydf)

#if using original names: 
g <- ggplot(data=mydf, mapping=aes(x=Number.of.Wins..2024., y=Value))
g
g + geom_point()
g + geom_point() + geom_smooth()


#if names have been changed: 
g <- ggplot(data=mydf, mapping=aes(x=Number_of_Wins_2024, y=Value))
g
g + geom_point()
g + geom_point() + geom_smooth()

#There’s no strong positive linear relationship between wins and team value.
#The relationship is weakly nonlinear — small increase early on, then plateau. 
#financial value is not tightly linked to number of wins; 
#but on market size, brand strength, fanbase. 

#fit with LM model 
g + geom_point() + geom_smooth(method="lm")
#Inspect LM model summary 
model <- lm(Value ~Number.of.Wins..2024., data = mydf)
summary(model)
#the model explains 5% of the variance in life expectancy. 

#graph: slightly downward slope, negative association, but likely not meaningful. 
#There’s no significant relationship between the number of wins and team value

loess_model <- loess(Value ~Number_of_Wins_2024, data = mydf)
summary(loess_model)

pred <- predict(loess_model)
cor(mydf$Value, pred)^2
#correlation between observed and predicted value. 



