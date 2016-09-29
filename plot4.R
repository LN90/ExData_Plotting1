#load the needed libraries:
library(lubridate)
library(ggplot2)

########################################################################################################################################
#STEP ONE: load the file

#first set the working directory good
setwd("~Course 4 Exploratory Data Analysis")

#handy: na.strings="?" 
#read the data in
dat<-read.csv("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")
#copy the original data in a copy to try stuff on, if it goes wrong, the original is still uploaded
copy<-dat

#copy the column of dates to first transfor it to dates and find the rows you want
copy$dates<-copy$Date
copy$Date<-as.Date(copy$Date,format="%d/%m/%Y")

#find the rows with the desired dates and store them
first<-grep("2007-02-01",copy$Date)
second<-grep("2007-02-02",copy$Date)
test<-grep("^[1,2]/2/2007",copy$Date)

#get the subsets of the table with the desired dates
firsttable<-copy[first,]
secondtable<-copy[second,]

#bind them together to one dataframe
all<-rbind(firsttable,secondtable)

#make the first two collumns in a date en time format
all$Datetime <- strptime(paste(all$dates, all$Time), "%d/%m/%Y %H:%M:%S")

########################################################################################################################################
#STEP TWO: make the graph

#create the frame
par(mfrow=c(2,2))

plot(all$Datetime,all$Global_active_power,xlab="",ylab="Global Active Power",type="l")
plot(all$Datetime,all$Voltage,xlab="datetime",ylab="Voltage",type="l")
plot(all$Datetime,all$Sub_metering_1,xlab="",ylab="Energy sub metering",type="n")
lines(all$Datetime,all$Sub_metering_1,col="black",type="l")
lines(all$Datetime,all$Sub_metering_2,col="red",type="l")
lines(all$Datetime,all$Sub_metering_3,col="blue",type="l")
legend("topright",lty=c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
plot(all$Datetime,all$Global_reactive_power,xlab="datetime",ylab="Global_reactive_power",type="l")

#now save this as a png image with 480x480 pixels
dev.copy(png,file="plot4.png",height=480,width=480)
dev.off()
