
#Oct 8, session 7.2, R basics 


#0. How to save your R script file 
#click the save current document button on the top left corner. blue disk. 

#1.Data types 

#usually R usually distinguish between different types of data automatically. 
#But Sometimes you have to explicitly tell R how you want to treat a data type. 

#numerical (numbers, integers=whole numbers or numbers with a decimal point) "donation amount"
a <- 1
a
class(a)

a <- 1.5
a
class(a)

#character: character string something like a word or multiple words."US. States" "Name"  
b<-"today is wednesday"
b<-"hello world"
b
class(b)

#logical: take on the value of either True or False."homework submitted"  
b<-TRUE
b
class(b)

#2. Data structures 

#vector: a list of item that are of the same type.   

a <-c(1,3,5,7,9)
a
class(a) #find out the type of any object using this function. 

a <- c(1, FALSE, "hello world")
a
class(a) #when there's a mix of data types, R coerces the numeric data and other data into characters 

#dataframe: data is structured in a tabular format, spreadsheet, column and row.  
getwd()
list.files()
df <- read.csv("Tucson_Police_Activity_2024.csv")
class(df)

mtcars
class(mtcars)

#3. Calculations 

mean <- (9+10+11)/3 
mean

#apply the calculation/operation to every element in the vector. 
scores <- c(1,2,3,4,5)
scores

new.scores <- scores*2 #no spaces are allowed in the object name. 
new.scores


#4. Data 

data() #check the R Built-in Datasets 

#the mtcars dataset 
data(mtcars)
head(mtcars, 6) #print the first 6 rows 
nrow(mtcars)
ncol(mtcars)
class(mtcars)
?mtcars

#the tucson police activity dataset 
class(df)
View(df)
view(df) #V has to be written in uppercase. 
colnames(df)




