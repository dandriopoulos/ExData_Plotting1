#Packages
library(caret)
library(dplyr)
library(ggplot2)
library(corrgram)
library(corrplot)
#install.packages("lubridate")
library(lubridate)

pacman::p_load("caret","ROCR","lift","glmnet","MASS","e1071") #Check, and if needed install the necessary packages

#Memory Usage
memory<-2075259*9*8
print(paste0("The memory needed is about ", memory/1000000000, " GB"))

#Data sets
el.pow.cons<-read.table("household_power_consumption.txt", header = TRUE, sep = ";")
el.pow.cons$Date<-as.Date(el.pow.cons$Date, "%d/%m/%Y")

el.pow.cons.1<-subset(el.pow.cons, Date == as.Date("2007-02-01")) 
el.pow.cons.2<-subset(el.pow.cons, Date == as.Date("2007-02-02"))

consumption.select<-rbind(el.pow.cons.1,el.pow.cons.2)

consumption.select$Global_active_power<-as.numeric(as.character(consumption.select$Global_active_power))
consumption.select$Time.1<-as.character(consumption.select$Time)
consumption.select$Date.1<-as.character(consumption.select$Date)

consumption.select$datetime<-paste(consumption.select$Date.1, consumption.select$Time.1)
consumption.select$datetime<-as.POSIXct(consumption.select$datetime)

#Plot 1
png("plot2.png", width = 480, height = 480)
plot(consumption.select$datetime,consumption.select$Global_active_power, ylab = "Global Active Power (kilowatts)", main = "", xlab = "", type = "l" )
dev.off()
