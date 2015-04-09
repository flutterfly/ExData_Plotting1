#Read the text file into a data.frame
hh<-read.table("household_power_consumption.txt", sep=";", header=TRUE, as.is=TRUE)

#Change the format of the Date column to Date class 
hh$Date<-as.Date(hh$Date, "%d/%m/%Y")

#Subset the data.frame to include only rows with date 2007-02-01 and 2007-02-02
hhsub<-hh[hh$Date=="2007-02-01"|hh$Date=="2007-02-02",]

#Change the format of the Sub_metering columns to numeric
hhsub$Sub_metering_1<-as.numeric(hhsub$Sub_metering_1)
hhsub$Sub_metering_2<-as.numeric(hhsub$Sub_metering_2)
hhsub$Sub_metering_3<-as.numeric(hhsub$Sub_metering_3)

#Create a date/time column
#First create a vector with date and time
datetime<-strptime(paste(hhsub$Date, hhsub$Time), format="%Y-%m-%d %H:%M:%S")
#Next, add the vector as a column in the data.frame
hhsub[,10]<-list(datetime)
#Finally, change the column name to sometime descriptive
colnames(hhsub)[10]<-"DateTime"

#Print the line graphs and legend
plot(hhsub$DateTime, hhsub$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(hhsub$DateTime,hhsub$Sub_metering_2, col="red")
lines(hhsub$DateTime,hhsub$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c("Black", "Red", "Blue"))

#Finally, the code for creating the png file
png(filename = "plot3.png",width = 480, height = 480)
plot(hhsub$DateTime, hhsub$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(hhsub$DateTime,hhsub$Sub_metering_2, col="red")
lines(hhsub$DateTime,hhsub$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c("Black", "Red", "Blue"))
dev.off()