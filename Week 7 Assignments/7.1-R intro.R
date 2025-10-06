#Oct 3 Intro to R studio 

#3. Set working directory 
getwd()
setwd("/Users/clairecheng/Desktop/R exercise")

#replace your home directory with ~ tilde
path.expand("~")
setwd("~/Desktop/R exercise")
getwd()

#list all the files under your working directory R exercise 
list.files()
#list all the files under a particular folder 
list.files("~/Desktop/R exercise/Week7")
#create a folder within your working directory R exercise 
dir.create("test")

#4. assignment operator 
x<-5 
x

#5. read csv file 
df1 <- read.csv("~/Desktop/R exercise/Week7/Tucson_Police_Activity_2024.csv")
df2 <- read.csv(file = "Tucson_Police_Activity_2024.csv")

#read excel file 
install.packages("readxl")
library(readxl)
df3 <- read_excel("6.2-Answer-City murder rate.xlsx")

#6. preview the data 
head(df3)
colnames(df3)
View(df3)
summary(df3)

