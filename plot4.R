#Read the text file into a data.frame
hh<-read.table("household_power_consumption.txt", sep=";", header=TRUE, as.is=TRUE)

#Change the format of the Date column to Date class 
hh$Date<-as.Date(hh$Date, "%d/%m/%Y")

#Subset the data.frame to include only rows with date 2007-02-01 and 2007-02-02
hhsub<-hh[hh$Date=="2007-02-01"|hh$Date=="2007-02-02",]

#Change the format of the data columns to numeric
hhsub$Sub_metering_1<-as.numeric(hhsub$Sub_metering_1)
hhsub$Sub_metering_2<-as.numeric(hhsub$Sub_metering_2)
hhsub$Sub_metering_3<-as.numeric(hhsub$Sub_metering_3)
hhsub$Global_active_power<-as.numeric(hhsub$Global_active_power)
hhsub$Global_reactive_power<-as.numeric(hhsub$Global_reactive_power)
hhsub$Voltage<-as.numeric(hhsub$Voltage)

#Create a date/time column
#First create a vector with date and time
datetime<-strptime(paste(hhsub$Date, hhsub$Time), format="%Y-%m-%d %H:%M:%S")
#Next, add the vector as a column in the data.frame
hhsub[,10]<-list(datetime)
#Finally, change the column name to sometime descriptive
colnames(hhsub)[10]<-"DateTime"

#Create a 2 x 2 plotting area
par(mfrow=c(2,2))

with(hhsub, {
        #Print the line graph for Global Active Power
        plot(hhsub$DateTime, hhsub$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
        
        #Print the line graph for Voltage
        plot(hhsub$DateTime, hhsub$Voltage, type="l", ylab="Voltage", xlab="datetime")
        
        #Print the line graphs and legend for Sub Metering data
        plot(hhsub$DateTime, hhsub$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
        lines(hhsub$DateTime,hhsub$Sub_metering_2, col="red")
        lines(hhsub$DateTime,hhsub$Sub_metering_3, col="blue")
        legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c("Black", "Red", "Blue"))   
        
        #Print the line graph for Global Reactive Power
        plot(hhsub$DateTime, hhsub$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
})


#Finally, the code for producing the png file
png(filename = "plot4.png",width = 480, height = 480)
par(mfrow=c(2,2))

        with(hhsub, {
             #Print the line graph for Global Active Power
             plot(hhsub$DateTime, hhsub$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
             
             #Print the line graph for Voltage
             plot(hhsub$DateTime, hhsub$Voltage, type="l", ylab="Voltage", xlab="datetime")
             
             #Print the line graphs and legend for Sub Metering data
             plot(hhsub$DateTime, hhsub$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
             lines(hhsub$DateTime,hhsub$Sub_metering_2, col="red")
             lines(hhsub$DateTime,hhsub$Sub_metering_3, col="blue")
             legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c("Black", "Red", "Blue"))   
             
             #Print the line graph for Global Reactive Power
             plot(hhsub$DateTime, hhsub$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
        })
dev.off()
