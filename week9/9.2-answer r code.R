
#week 9.2 ggplotII 
getwd()
setwd()

install.packages("gapminder")
install.packages("ggplot2")
library(gapminder)
library(ggplot2)

#Mapping aesthetics vs. Setting aesthetics 

#1. the base layer - the plot we have last session: 
p<-ggplot(data=gapminder,mapping=aes(x=gdpPercap,y=lifeExp))
p+geom_point()

#2. the "color" property will map "continent" variable. Adding another variable into the plot. 
#"let's use different colors to represent different continents on the plot" 
p<-ggplot(data=gapminder,mapping=aes(x=gdpPercap,y=lifeExp,color=continent))
p+geom_point()

#3. set the color of the points; Geom() can take color arguments. Not Representing vars. 
p<-ggplot(data=gapminder,mapping=aes(x=gdpPercap,y=lifeExp))
p+geom_point(color = "purple")

#4. Add smooth line and rescale the x-axis. 
p<-ggplot(data=gapminder,mapping=aes(x=gdpPercap,y=lifeExp))
p+geom_point(color = "purple") + geom_smooth() + scale_x_log10()

#5. Change transparency of the dots 
p<-ggplot(data=gapminder,mapping=aes(x=gdpPercap,y=lifeExp))
p+geom_point(alpha=0.3) + geom_smooth() + scale_x_log10() #transparency of the dots 0.1 very light. 0.3 good for large dataset. 1=solid. 


#6. Adjust color and size of the smooth line: 
p<-ggplot(data=gapminder,mapping=aes(x=gdpPercap,y=lifeExp))
p+geom_point(alpha=0.3) + geom_smooth(color="orange",size=1) + 
    scale_x_log10() 

#7. use the dollar function from the scales package. Plain numbers -> dollar 
p<-ggplot(data=gapminder,mapping=aes(x=gdpPercap,y=lifeExp))
p+geom_point(alpha=0.3) + geom_smooth(color="orange",size=1) + 
  scale_x_log10(labels=scales::dollar) 

#8. Add laels to the figure,set the title, subtitle, caption, xy-labels. 

p<-ggplot(data=gapminder,mapping=aes(x=gdpPercap,y=lifeExp))
p+geom_point(alpha=0.3) + 
  geom_smooth(color="orange",size=1.8) + 
  scale_x_log10(labels=scales::dollar) +
  labs(x="GDP Per Capita", y="Life Expectancy in Years", title="Economic Growth and Lfie Expectancy",
       subtitle="Data points are country-years",
       caption = "Source:Gapminder")

#if you want to fit LM line instead: 
p<-ggplot(data=gapminder,mapping=aes(x=gdpPercap,y=lifeExp))
p+geom_point(alpha=0.3) + 
  geom_smooth(color="orange",size=1.8, method="lm") + 
  scale_x_log10(labels=scales::dollar) +
  labs(x="GDP Per Capita", y="Life Expectancy in Years", title="Economic Growth and Lfie Expectancy",
       subtitle="Data points are country-years",
       caption = "Source:Gapminder")

#9. 
ggsave(filename="my_figure.png")


#10. now go back to the aes() function, Map continent to the plot  
p<-ggplot(data=gapminder,mapping=aes(x=gdpPercap,y=lifeExp,color=continent))
p+geom_point() + geom_smooth() + scale_x_log10()

#this one fills up the color of the confidence interval as well. 
p<-ggplot(data=gapminder,mapping=aes(x=gdpPercap,y=lifeExp,color=continent, fill=continent))
p+geom_point() + geom_smooth() + scale_x_log10()



#11. We want the points color-coded by continents, but we just need one smooth line for all data. 
#tricky part is if you add the color to aes, geom will inherit their mapping of color. 
#Workaroud: specify the aesthetics for each geom. 
p<-ggplot(data=gapminder,mapping=aes(x=gdpPercap,y=lifeExp))
p+geom_point(mapping=aes(color=continent)) + geom_smooth(color="black") + scale_x_log10()


#map continuous variable to the color aesthetics. 
p<-ggplot(data=gapminder,mapping=aes(x=gdpPercap,y=lifeExp))
p+geom_point(mapping=aes(color=log(pop))) + geom_smooth(color="black") + scale_x_log10() + theme_bw() #white background. 
ggsave(filename="my_figure2.png")


p<-ggplot(data=gapminder,mapping=aes(x=gdpPercap,y=lifeExp))
p+geom_point(mapping=aes(color=log(pop))) + geom_smooth(color="black") + scale_x_log10() + 
  theme(
    panel.background = element_rect(fill = "white", color = NA),  # plot area
    plot.background  = element_rect(fill = "white", color = NA),      # outer margin area
    panel.grid.major = element_line(color = "white"),                 # major gridlines
    panel.grid.minor = element_blank()                                # remove minor grids
  )
ggsave(filename="my_figure3.png")


#12. group by country, plot seprate lines for each country. Geom_line vs. Geom_smooth. 
p<-ggplot(data=gapminder, mapping=aes(x=year,y=gdpPercap))
p+geom_line(aes(group=country))

#if you don't do the group argument: 
p<-ggplot(data=gapminder, mapping=aes(x=year,y=gdpPercap))
p+geom_line()

#who is this outliner.... 
out <- boxplot.stats(gapminder$gdpPercap)$out
out_ind <- which(gapminder$gdpPercap %in% c(out))
out_ind

f<-gapminder[out_ind, ] #kuwait is the outlier. 

#13. facet the data, create a multi-panel line chart. 
#we use facet_wrap to split our plot by continent. 

p<-ggplot(data=gapminder, mapping=aes(x=year,y=gdpPercap))
p+geom_line(aes(group=country)) + facet_wrap(~continent) 

#14. cosmestic enhancement, make it prettier: 

p<-ggplot(data=gapminder, mapping=aes(x=year,y=gdpPercap))
p+geom_line(aes(group=country), color="gray70") + 
    geom_smooth(size=1.1) + 
    scale_y_log10(labels=scales::dollar) +
    facet_wrap(~continent,ncol=5) +
    labs(x = "Year",
         y = "GDP per capita",
         title= "GDP per capita on five continents")


#The student practice. 

getwd()
setwd("/Users/clairecheng/Desktop")

mydf<-read.csv("CASchools.csv")
colnames(mydf)


p<-ggplot(data=mydf,mapping=aes(x=income,y=read))
p+geom_point()+geom_smooth()

p<-ggplot(data=mydf,mapping=aes(x=income,y=math))
p+geom_point()+geom_smooth()

p<-ggplot(data=mydf,mapping=aes(x=income,y=math))
p+geom_point(size=0.5) + facet_wrap(~county) + labs(title="the relationship between income and math score across all CA county")

p<-ggplot(data=mydf,mapping=aes(x=income,y=math))
p+geom_point(size=0.5) + geom_smooth(method="lm")+facet_wrap(~county) + labs(title="the relationship between income and math score across all CA county")

p<-ggplot(data=mydf,mapping=aes(x=income,y=read))
p+geom_point(size=0.5) + geom_smooth(method="lm")+facet_wrap(~county) + labs(title="the relationship between income and read score across all CA county")



