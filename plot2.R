#Read the text file into a data.frame
hh<-read.table("household_power_consumption.txt", sep=";", header=TRUE, as.is=TRUE)

#Change the format of the Date column to Date class 
hh$Date<-as.Date(hh$Date, "%d/%m/%Y")

#Subset the data.frame to include only rows with date 2007-02-01 and 2007-02-02
hhsub<-hh[hh$Date=="2007-02-01"|hh$Date=="2007-02-02",]

#Change the format of the Global_active_power column to numeric
hhsub$Global_active_power<-as.numeric(hhsub$Global_active_power)

#Create a date/time column
#First create a vector with date and time
datetime<-strptime(paste(hhsub$Date, hhsub$Time), format="%Y-%m-%d %H:%M:%S")
#Next, add the vector as a column in the data.frame
hhsub[,10]<-list(datetime)
#Finally, change the column name to sometime descriptive
colnames(hhsub)[10]<-"DateTime"

#Print the line graph
plot(hhsub$DateTime, hhsub$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")

#Finally, the code for creating the png file
png(filename = "plot2.png",width = 480, height = 480)
plot(hhsub$DateTime, hhsub$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()