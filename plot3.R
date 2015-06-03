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

## Plot Line graph by series and with legend, then save as PNG file
png("plot3.png", width=480, height=480)
with(subdata, plot(datetime, Global_active_power, type="n", 
          ylab="Energy sub metering", xlab="", ylim=c(0,38)))
with (subdata, points(datetime, Sub_metering_1, type="l", col="black"))
with (subdata, points(datetime, Sub_metering_2, type="l", col="red"))
with (subdata, points(datetime, Sub_metering_3, type="l", col="blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty=1, cex=0.8)
dev.off()


