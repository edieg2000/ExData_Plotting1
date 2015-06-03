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

## Plot Line graph and save as PNG file
png("plot2.png", width=480, height=480)
plot(subdata$datetime, subdata$Global_active_power, type="l", 
     ylab="Global Active Power (kilowatts)", xlab="") 
dev.off()


