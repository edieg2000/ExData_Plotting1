## Read source file and only extract Feb 1 and 2 of 2007
library(sqldf)
library(lubridate)
library(graphics)
library(grDevices)
subdata <- read.csv.sql("household_power_consumption.txt", sql = 
          "select * from file where Date = '2/2/2007' or Date = '1/2/2007'", header=TRUE,
          sep = ";") 
closeAllConnections()

## Paste and format Date/Time columns
subdata$datetime <- paste(subdata$Date, subdata$Time, sep=' ')
subdata$datetime <- strptime(subdata$datetime, "%d/%m/%Y %H:%M:%S")

## Set PNG device and margins
png("plot4.png", width=480, height=480)
par(mfcol=c(2,2), mar = c(4,4,2,1), oma=c(0,0,2,0))

##Graph 1, in upper left
plot(subdata$datetime, subdata$Global_active_power, type="l", 
     ylab="Global Active Power (kilowatts)", xlab="") 
##Graph 2, in lower left
with(subdata, plot(datetime, Global_active_power, type="n", 
          ylab="Energy sub metering", xlab="", ylim=c(0,38)))
with(subdata, points(datetime, Sub_metering_1, type="l", col="black"))
with(subdata, points(datetime, Sub_metering_2, type="l", col="red"))
with(subdata, points(datetime, Sub_metering_3, type="l", col="blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty=1, cex=0.8, bty="n")
##Graph 3, in upper right
plot(subdata$datetime, subdata$Voltage, type="l", xlab="datetime", ylab="Voltage") 
##Graph 4, in lower right
plot(subdata$datetime, subdata$Global_reactive_power, type="l", xlab="datetime", 
     ylab="Global_reactive_power") 
dev.off()


