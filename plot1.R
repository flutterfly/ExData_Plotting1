#Read the text file into a data.frame
hh<-read.table("household_power_consumption.txt", sep=";", header=TRUE, as.is=TRUE)

#Change the format of the Date column to Date class 
hh$Date<-as.Date(hh$Date, "%d/%m/%Y")

#Subset the data.frame to include only rows with date 2007-02-01 and 2007-02-02
hhsub<-hh[hh$Date=="2007-02-01"|hh$Date=="2007-02-02",]

#Change the format of the Global_active_power column to numeric
hhsub$Global_active_power<-as.numeric(hhsub$Global_active_power)

#Print the histogram
hist(hhsub$Global_active_power, col = "red", main = "Global Active Power", xlab="Global Active Power (kilowatts)")