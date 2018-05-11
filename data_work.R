#Data structures


#make a data frame
cats <- data.frame(coat=c("calico","black","tabby"),
                   weight = c(2.1,5.0,3.2),
                   likes_string = c(1,0,1))
cats

#look at the weights column
cats$weight
cats$coat
cats$weight + 2
cats$weight + cats$coat

class(cats$weight)
class(cats$coat)

str(cats)

str(cats$coat)

#write to a csv file
write.csv(x = cats, file = "Data/feline_data.csv")
read.csv(file = "Data/feline_data.csv")

#change the order of factors
#here I added a column to the cats table called coat_reordered and have changed the structure of the coats column
cats$coat_reorder <- factor(x = cats$coat,
                            levels = c("tabby","calico","black"),
                            ordered = TRUE)
str(cats$coat_reorder)
levels(cats$coat_reorder)

#exploring data frames
#read in data
gap <- read.csv(file = "Data/gapminder-FiveYearData.csv")
gap
head(gap)
str(gap)

#look at the dims of the data frame
nrow(gap)
ncol(gap)
dim(gap)

colnames(gap)

#Subsetting Data
x <- c(5.4, 6.2, 7.1, 4.8, 7.5)  #create the vector
names(x) <- c("a","b","c","d","e")  #name the vector

x[1]  #indices are in square brackets
x[3]
x[c(1,3)] # #need to use the combine function to look at multiple elements at the same time
x[1:4]    #slicing
x[-2]  #remove the second element of the vector
x[-(2:4)]
x[-2:4] #throws error

#subsetting gapminder data
head(gap[1])
head(gap["pop"]) #look at the top of the pop column
head(gap[,1]) #subset by row
gap[3, ]   #[row, column] 
gap[138, ]  #look at the data in row 138

albania <- gap[13:24, 3:6]

#subset the info for afghanistan from the gap data set and then create a column called gdp
#gdp column is POP multiplied by gdpPerCap 
afg <- gap[1:12, ]
afg$gdp <- afg$pop*afg$gdpPercap  

##conditional statements, functions, and ggplot##

##conditional statements##
number <- 37
if (number >100){
  print("greater than 100")
}else {
  print("less than 100")
}
print("finish checking")

#comparison operators
# greater than >
#less than <
# equal to  ==
# not equal to !=
# greater than or equal to >=
# less than or equal to <=

number <- 150
if (number >100){
  print("greater than 100")
}

# more than one test within a conditional
number <- -3
if (number > 0){
  print(1)
} else if (number < 0) {
    print(-1)
}else{
    print(0)
  }

#combine tests
#AND condition
number1 <- -15
number2 <- 40

if (number1>=0 &number2>=0){
  print("both numbers are positive")
}else{
  print("at least one is negative")
}

#OR condition
number1 <- -15
number2 <- -40

if (number1>=0 | number2>=0){
  print("at least one number is positive")
}else{
  print("both numbers are negative")
}

##creating and using functions
fahr_to_kelvin <- function(temp){
  kelvin <- ((temp-32) * (5/9)) + 273.15
  return(kelvin)
}

#calling the function
fahr_to_kelvin(32) #freezing point
fahr_to_kelvin(212) #boiling point

#convert kelvin to celsius
kelvin_to_celsius <- function(temp){
  celsius <- temp - 273.15
  return(celsius)
}

kelvin_to_celsius(0)
kelvin_to_celsius(100)

#variable scope (variables within a function stay in the function)

#mix and match functions
#convert fahrenheit to celsius
fahr_to_celsius <- function(temp){
  temp_k <- fahr_to_kelvin(temp)
  temp_c <- kelvin_to_celsius(temp_k)
  return(temp_c)
}

fahr_to_celsius(32)

##convert celsius to fahrenheit
cel2fahr <- function(temp){
  tempf <- ((temp)*(9/5)) + 32
  return(tempf)
}
#it works!
cel2fahr(0)
cel2fahr(100)


#making reproducible graphics
library(ggplot2)

#read in some data
gap <- read.csv(file = "Data/gapminder-FiveYearData.csv")
head(gap)
str(gap)

plot(x=gap$gdpPercap, y= gap$lifeExp)

#ggplot image
#aes - specifying the axes that we want to look at in gap
#geom_point = type of graph, in this case point geometry
ggplot(data = gap, aes(x= gdpPercap, y=lifeExp)) +
  scale_x_log10()+   #change the scale of the x axis to log10 scale
  geom_point(alpha=0.5)+  #alpha changes the transparency of the points
  geom_smooth(method = "lm")
  #theme_bw()+                                              ##cleaning up the data
  ggtitle("Effects of gdpPerCapita on life expectancy")+
  xlab("GDP per Capita ($)")+
  ylab("Life Expectancy (years)")


  
ggplot(data = gap, aes(x= year, y=lifeExp)) +
  geom_point()

ggplot(data = gap, aes(x=year, y=lifeExp, by = country))+
  geom_line(aes(color = continent))+
  geom_point(color="blue")

ggsave(filename = "results/life_expectancy.png")
?ggsave

#faceting
ggplot(data = gap, aes(x=gdpPercap, y= lifeExp, color = continent))+
  geom_point()+
  scale_x_log10()+
  geom_smooth(method="lm")+
  facet_wrap(~year)
  











