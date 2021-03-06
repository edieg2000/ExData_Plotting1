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

## Plot histogram and save as PNG file
png("plot2.png", width=480, height=480)
hist(subdata$Global_active_power, xlab="Global Active Power (kilowatts)", 
     ylab="Frequency", main="Global Active Power", col="red")
dev.off()


